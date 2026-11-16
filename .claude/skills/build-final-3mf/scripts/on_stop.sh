#!/usr/bin/env bash
# Stop hook: if any project's CAD source changed since its FINAL was built, rebuild the FINAL(s) in the background,
# then commit + push (auto_commit.sh sees the updated FINAL file and treats it as a major change).
ROOT="$(cd "$(dirname "$0")/../../../.." && pwd)"; cd "$ROOT" || exit 0
LOCK=/tmp/lilmate_auto.lock; LOG=/tmp/lilmate_auto.log
cat >/dev/null   # drain hook stdin
stale=""
for p in deck_buddy desk_mini elephant music_player office_buddy pengu_chubby; do
  [ -d "$p/3d/src" ] || continue
  cur="$(cat $p/3d/src/*.scad 2>/dev/null | sha1sum | cut -d' ' -f1)"
  [ "$cur" != "$(cat $p/3d/print/.final_src.sha1 2>/dev/null)" ] && stale="$stale $p"
done
if [ -z "$stale" ]; then bash .claude/skills/commit-design/scripts/auto_commit.sh --hook; exit 0; fi   # nothing to rebuild: still commit/push finished major work
if ! mkdir "$LOCK" 2>/dev/null; then exit 0; fi   # a build is already running
(
  trap 'rmdir "$LOCK"' EXIT
  echo "=== $(date) rebuilding:$stale" > "$LOG"
  for p in $stale; do bash .claude/skills/build-final-3mf/scripts/build_final.sh "$p" >> "$LOG" 2>&1 || echo "FAILED: $p (old FINAL kept)" >> "$LOG"; done
  bash .claude/skills/commit-design/scripts/auto_commit.sh >> "$LOG" 2>&1
  echo "=== done $(date)" >> "$LOG"
) >/dev/null 2>&1 &
printf '{"systemMessage": "CAD changed in:%s - rebuilding FINAL 3mf in the background, then auto-commit and push. Log: /tmp/lilmate_auto.log"}\n' "$stale"
