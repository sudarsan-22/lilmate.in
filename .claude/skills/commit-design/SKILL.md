---
name: commit-design
description: Commit and push lilmate design work to the remote (origin) when a major design change happens. Use after a final 3mf is rebuilt, after a significant CAD/source edit, a new project, or when the user says commit, push, save to git, or back this up, in any lilmate project (deck_buddy, desk_mini, elephant, elephant_cute, music_player, office_buddy, pengu_chubby). Also use to understand why an automatic commit happened.
---

# Commit and push major design changes

Remote: `origin` (GitHub `sudarsan-22/crazy_projects`, branch `main`). The git root is `crazy_projects/`, which also holds unrelated projects, so only ever commit paths under `lilmate_3D_design/`.

## What counts as major (commit + push automatically)
- a `*_FINAL*` file was added, changed or renamed (the FINAL 3mf was rebuilt)
- a new project folder appeared
- at least 30 changed lines in a current `src/*.scad` (moves into `archive/` do not count)
Minor edits (docs, previews, comments, small tweaks) wait until one of the above happens.

## Run it
```bash
bash .claude/skills/commit-design/scripts/auto_commit.sh --dry-run        # show what would be committed
bash .claude/skills/commit-design/scripts/auto_commit.sh                  # commit + push if major
bash .claude/skills/commit-design/scripts/auto_commit.sh --force-major -m "elephant: wider trunk slot"   # commit anyway, own message
```
It stages only `lilmate_3D_design/`, writes `design(<projects>): <reason>` as the message (or yours with `-m`) with the Co-Authored-By trailer, commits with a path limit so nothing outside lilmate is swept in, then `git push origin <branch>`.

## Safety rules
- Never force-push. If the push is rejected the commit stays local and the failure goes to `/tmp/auto_commit_push.err`; tell the user, do not retry with force.
- Files over 95 MB are skipped (GitHub limit 100 MB) and reported.
- `lilmate_3D_design/.gitignore` keeps slicer scratch (`print/slice/out*`, `proj*`), logs and `__pycache__` out; the repo-level ignore already excludes `output/` STLs, `backup_before_*/`, `*.zip` and `result.json`.
- Rebuild the FINAL 3mf first (build-final-3mf skill) so the commit contains a final that matches the source.

## Automatic
The Stop hook in `.claude/settings.json` runs `build-final-3mf/scripts/on_stop.sh` after every Claude turn: stale FINALs are rebuilt in the background, then this script commits and pushes. Result lines go to `/tmp/lilmate_auto.log` and show as a status message.
