#!/bin/bash
# Deck buddy SA with the 1.3" OLED (new bracket frame + new bezel); (stand-alone, upright): body is printed UPRIGHT (src/deck_buddy_SA.scad), no spike base.
# Plate: upright body (tree supports, per object) + bezel + bracket + angled block + 2 small plates + new switch back lid.
# usage: ./slice_SA.sh   -> ../DECK_BUDDY_SA_OLED13_print.gcode.3mf
cd "$(dirname "$0")"; rm -rf projSA13 && mkdir projSA13; O=../../reference/original
~/.local/opt/openscad-nightly/OpenSCAD.AppImage --backend Manifold -D 'view="print"' -o ../../output/deck_buddy_SA_body_upright.stl ../../src/deck_buddy_SA.scad 2>&1 | grep -iE "error"
# manual layout on the 180 x 180 bed (bbox min corner x:y), so tall overhangs of the body keep clear of the other parts
python3 place.py projSA13/parts "deck_buddy_SA_body_upright.stl:52.6:80.4:../../output/deck_buddy_SA_body_upright.stl" "back_lid_switch.stl:8:8:../../output/print_back_lid_switch.stl" \
  "bezel_obj8.stl:70:20:../../output/deck_buddy_bezel_oled13.stl" "bracket_obj1.stl:130:10:../../output/deck_buddy_bracket_oled13.stl" "block_obj3.stl:8:100:$O/obj_3_Yeti Full.stl_2.stl" \
  "plate_obj5.stl:145:90:$O/obj_5_Yeti Full.stl_4.stl" "plate_obj6.stl:145:125:$O/obj_6_Yeti Full.stl_8.stl" >/dev/null
~/.local/bin/bambu-studio --orient 0 --arrange 0 --load-settings "machine.json;process_deck_buddy_SA.json" --load-filaments "filament.json" \
  --slice 0 --outputdir projSA13 --export-3mf step1.3mf projSA13/parts/*.stl >/dev/null 2>&1
python3 - <<'PY'
import zipfile
zi = zipfile.ZipFile('projSA13/step1.3mf'); zo = zipfile.ZipFile('projSA13/step2.3mf', 'w', zipfile.ZIP_DEFLATED)
for it in zi.infolist():
    if it.filename.endswith('.gcode') or it.filename.endswith('.gcode.md5'): continue
    b = zi.read(it.filename)
    if it.filename == 'Metadata/model_settings.config':
        s = b.decode(); a = '<metadata key="name" value="deck_buddy_SA_body_upright.stl"/>\n    <metadata key="extruder" value="1"/>\n'
        assert s.count(a) == 1
        b = s.replace(a, a + '    <metadata key="enable_support" value="1"/>\n    <metadata key="support_type" value="tree(auto)"/>\n').encode()
    zo.writestr(it, b)
zo.close()
PY
mkdir projSA13/out && ~/.local/bin/bambu-studio --slice 0 --outputdir projSA13/out --export-3mf DECK_BUDDY_SA_OLED13_print.gcode.3mf projSA13/step2.3mf >/dev/null 2>&1
python3 -c "
import json; d=json.load(open('projSA13/out/result.json')); p=d['sliced_plates'][0]
print(d['error_string'], '| plates', len(d['sliced_plates']), '| %.0f min' % (p['total_predication']/60), '| %.1f g' % p['filaments'][0]['total_used_g'], '|', p.get('warning_message') or 'no warning')"
cp projSA13/out/DECK_BUDDY_SA_OLED13_print.gcode.3mf ../DECK_BUDDY_SA_OLED13_print.gcode.3mf && rm -rf projSA13 && ls -la ../DECK_BUDDY_SA_OLED13_print.gcode.3mf
