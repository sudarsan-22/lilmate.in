#!/bin/bash
# Deck buddy: one A1 mini plate, 8 objects. Tree supports on the BODY only (per-object setting), others none.
# usage: ./slice_all.sh   -> ../DECK_BUDDY_print.gcode.3mf
cd "$(dirname "$0")"; rm -rf proj && mkdir proj; O=../../reference/original
~/.local/bin/bambu-studio --orient 0 --arrange 1 --load-settings "machine.json;process_deck_buddy.json" --load-filaments "filament.json" \
  --slice 0 --outputdir proj --export-3mf step1.3mf \
  "$O/obj_7_corp+face.stl_1.stl" "$O/obj_2_Yeti Full.stl_7.stl" ../../output/print_back_lid_switch.stl "$O/obj_8_corp+face.stl_2.stl" \
  "$O/obj_1_Yeti Full.stl_1.stl" "$O/obj_3_Yeti Full.stl_2.stl" "$O/obj_5_Yeti Full.stl_4.stl" "$O/obj_6_Yeti Full.stl_8.stl" >/dev/null 2>&1
python3 - <<'PY'
import zipfile
zi = zipfile.ZipFile('proj/step1.3mf'); zo = zipfile.ZipFile('proj/step2.3mf', 'w', zipfile.ZIP_DEFLATED)
for it in zi.infolist():
    if it.filename.endswith('.gcode') or it.filename.endswith('.gcode.md5'): continue
    b = zi.read(it.filename)
    if it.filename == 'Metadata/model_settings.config':
        s = b.decode(); a = '<metadata key="name" value="obj_7_corp+face.stl_1.stl"/>\n    <metadata key="extruder" value="1"/>\n'
        assert s.count(a) == 1
        b = s.replace(a, a + '    <metadata key="enable_support" value="1"/>\n    <metadata key="support_type" value="tree(auto)"/>\n').encode()
    zo.writestr(it, b)
zo.close()
PY
mkdir proj/out && ~/.local/bin/bambu-studio --slice 0 --outputdir proj/out --export-3mf DECK_BUDDY_print.gcode.3mf proj/step2.3mf >/dev/null 2>&1
python3 -c "
import json; d=json.load(open('proj/out/result.json')); p=d['sliced_plates'][0]
print(d['error_string'], '| plates', len(d['sliced_plates']), '| %.0f min' % (p['total_predication']/60), '| %.1f g' % p['filaments'][0]['total_used_g'], '|', p.get('warning_message') or 'no warning')"
cp proj/out/DECK_BUDDY_print.gcode.3mf ../DECK_BUDDY_print.gcode.3mf && rm -rf proj && ls -la ../DECK_BUDDY_print.gcode.3mf
