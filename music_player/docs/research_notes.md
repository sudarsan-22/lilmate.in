# Music player – design R&D (2026-11-14)

The user rejected rounds 1–3 (A–I) as "not looking good". These notes record the research done next.

## Why A–I looked weak
1. **Sticker look.** Faces, pads and grilles sit on top of blobby shapes as flat decals. Real products sink these into the shell: flush windows, recessed dials, split lines.
2. **Too many ideas in one design.** Ears, tail, loop, whiskers, sprinkles and a bite all on one body. Good products have one hero element.
3. **One face on every concept.** The same big OLED face with a thick beige bezel makes everything read as a toy.
4. **4–6 colours per design.** The references use one body colour plus one accent.
5. **Invisible controls.** Touch pads give no feel. The references all have one tactile hero control: a dial, a D-pad or a rocker.
6. **Speaker grilles with no speaker.** The YX6300 only drives headphones, so the grilles are fake.

## References
| Product | What to take from it |
|---|---|
| Yoto Mini (Pentagram) | Everything on the front face, large controls, small pixel window instead of a big screen, "not too toy-like", Walkman feel |
| MP-1 concept (Yanko, TE-style) | Slim body with softened corners, one big dial as the hero, narrow strip display, orange accent on a nubbed rocker, slider that shows state by colour |
| MAD-5 concept (Yanko) | Square body, display on the front lip, etched concentric rings on the jog disc, clip |
| Teenage Engineering | Restraint: grey/white/black plus one bright accent, consistent radii, treated as an industrial object |
| 8BitDo Retro Cube 2 | Character comes from a borrowed icon (NES D-pad), 3 colours, controls are the decoration |
| Kokogol MiniToo (retro PC) | Tiny beige retro PC, CRT-style screen bezel, 4 oversized square keys, one orange knob |
| IKEA GREJSIMOJS mouse | One simple animal form, the tail doubles as the carry handle (function = cuteness) |
| DeskMate Mochi / Dasai Mochi | Same parts as ours (1.3" OLED, C3, TTP223); 3-piece stack (base, OLED holder, helmet); the personality lives in the screen animation, not the shell |

## Open-source engineering references
- Dasai-Mochi ESP32-C3 DIY: OLED + TTP223 + C3, 4 heat inserts join top and bottom.
- ESPuino (github.com/biologist79/ESPuino): rotary encoder plus RFID player.
- TonUINO cases (Printables / Thingiverse): DFPlayer boxes; felt-wrapped Put'n'Play cube.
- stack-chan (github.com/stack-chan/stack-chan, case/): Fusion source, STEP + STL.
- Knobby (github.com/quadule/knobby): ESP32 + single-encoder enclosure.

## New directions (pending the user's pick)
- **J "Pocket Walkman"**: slim rectangle, R4 corners, cream body with a coral accent, strip OLED window, big EC11 dial as the hero, side slide switch with a coloured "OFF" flag, clip on the back.
- **K "Mochi Pebble"**: one smooth superellipse pebble, a flush dark oval window, the face only on screen, a pat-the-head TTP223 for play/pause, a 3-key side rocker, tiny moulded ear nubs. Two colours.
- **L "Tiny Retro PC"**: desk unit, CRT-style screen box on a sloped base, 4 oversized printed keycaps on tact switches, one accent knob. The face lives on screen.
