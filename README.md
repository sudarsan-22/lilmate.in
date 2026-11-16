# lilmate

Desk-buddy products. Every project uses the same layout:

```
<project>/
  README.md
  3d/          src  output  print  previews  reference  build  archive
  firmware/    sketch + flashing notes
  hardware/    bom.csv  pinout.md  components.md  datasheets/
  docs/        notes, concepts, dimensions/
  packaging/   box + cutting template (deck_buddy, elephant, desk_mini)
  .claude/skills/
```

| Project | What |
|---|---|
| `deck_buddy` | Yeti desk buddy, 1.3" OLED |
| `desk_mini` | Small desk gadget with display and buzzer |
| `elephant` | Ellie v3 elephant desk buddy |
| `elephant_cute` | Cuter elephant look study (concept) |
| `music_player` | Retro-PC music player v2 |
| `office_buddy` | Retro-PC office buddy v1 |
| `pengu_chubby` | Pengu v3 penguin desk buddy |

Shared tooling is in `.claude/skills/` (`build-final-3mf`, `commit-design`). `packaging/` at this level holds the shared box template source.
