#!/usr/bin/env bash
# Commit and push major lilmate design changes. Safe by design: scoped to lilmate_3D_design/,
# never force-pushes, skips files over 95 MB, stays silent for minor edits.
# usage: auto_commit.sh [--hook] [--dry-run] [--force-major] [-m "message"]
set -u
HOOK=0; DRY=0; FORCE=0; MSG=""
while [ $# -gt 0 ]; do
  case "$1" in
    --hook) HOOK=1;; --dry-run) DRY=1;; --force-major) FORCE=1;;
    -m) shift; MSG="${1:-}";;
  esac; shift
done
HERE="$(cd "$(dirname "$0")/../../../.." && pwd)"          # lilmate_3D_design/
cd "$HERE" || exit 0
TOP="$(git rev-parse --show-toplevel 2>/dev/null)" || exit 0
LINES_MAJOR=30    # changed lines in current src/*.scad that count as a major design change

say() { if [ "$HOOK" = 1 ]; then printf '{"systemMessage": "%s"}\n' "$(printf '%s' "$1" | sed 's/"/\\"/g' | tr '\n' ' ')"; else echo "$1"; fi; }

# nothing to do?
[ -z "$(git status --porcelain -- . )" ] && exit 0
git add -A -- . 2>/dev/null

# drop files too big for GitHub (limit 100 MB)
big=""
while IFS= read -r f; do
  [ -f "$TOP/$f" ] && [ "$(stat -c %s "$TOP/$f")" -gt 99614720 ] && { git reset -q -- "$TOP/$f"; big="$big $f"; }
done < <(git diff --cached --name-only --relative="" -- . 2>/dev/null | sed "s#^#$(realpath --relative-to="$TOP" "$HERE")/#" | sed "s#^\./##")

staged="$(git diff --cached --name-status -- .)"
[ -z "$staged" ] && exit 0

# ---- is it a major design change? ----
reasons=()
# 1. a FINAL file was added, changed or renamed
echo "$staged" | grep -qE '_FINAL[^/]*$' && reasons+=("final file updated")
# 2. a brand new project folder (first path component under lilmate_3D_design/ that has no tracked files yet)
rel="$(realpath --relative-to="$TOP" "$HERE")"
newp=""
for p in $(git diff --cached --diff-filter=A --name-only --relative -- . | awk -F/ 'NF>1{print $1}' | sort -u); do
  [ -z "$(git ls-tree -r --name-only HEAD -- "$rel/$p" 2>/dev/null | head -1)" ] && [ "$p" != ".claude" ] && newp="$newp $p"
done
[ -n "$newp" ] && reasons+=("new project:$newp")
# 3. big edit of current CAD source (renames into archive/ do not count)
n="$(git diff --cached -M --numstat --relative -- . | awk '$3 ~ /\/src\/[^\/]*\.scad/ && $3 !~ /archive\// && $3 !~ /=>/ {s+=$1+$2} END{print s+0}')"
[ "$n" -ge "$LINES_MAJOR" ] && reasons+=("CAD source changed ($n lines)")
[ "$FORCE" = 1 ] && reasons+=("forced")

if [ ${#reasons[@]} -eq 0 ]; then git reset -q -- . ; exit 0; fi   # minor: leave it for later

projects="$(git diff --cached --name-only -- . | awk -F/ 'NF>1 && $1!=".claude"{print $1}' | sort -u | paste -sd, -)"
[ -z "$projects" ] && projects="lilmate"
why="$(IFS=';'; echo "${reasons[*]}")"
[ -z "$MSG" ] && MSG="design($projects): $why"
MSG="$MSG

Co-Authored-By: Claude Sonnet 5.5 <noreply@anthropic.com>"

if [ "$DRY" = 1 ]; then
  echo "WOULD COMMIT ($why):"; git diff --cached --stat -- . | tail -5; git reset -q -- .; exit 0
fi

git commit -q -m "$MSG" -- . || { say "auto-commit: commit failed"; exit 0; }
sha="$(git rev-parse --short HEAD)"
branch="$(git rev-parse --abbrev-ref HEAD)"
if git push -q origin "$branch" 2>/tmp/auto_commit_push.err; then
  out="lilmate auto-commit $sha pushed to origin/$branch ($why)"
else
  out="lilmate auto-commit $sha saved locally, PUSH FAILED (see /tmp/auto_commit_push.err); no force push attempted"
fi
[ -n "$big" ] && out="$out; skipped files over 95 MB:$big"
say "$out"
