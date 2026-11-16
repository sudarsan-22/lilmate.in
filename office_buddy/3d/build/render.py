# Blender product render. usage: blender -b -P render.py -- <hero|back|side|plate> <out.png> [samples] [WxH]
import bpy, sys, os, math
from mathutils import Vector
argv = sys.argv[sys.argv.index("--") + 1:]
view, out = argv[0], argv[1]
samples = int(argv[2]) if len(argv) > 2 else 96
res = [int(v) for v in (argv[3] if len(argv) > 3 else "1200x1500").split("x")]
HERE = os.path.dirname(os.path.abspath(__file__)); PARTS = os.path.join(HERE, "parts"); S = 0.01
def lin(c): return tuple(v ** 2.2 for v in c) + (1.0,)
COL = {"body": (0.90, 0.84, 0.72), "key": (0.74, 0.71, 0.66), "acc": (0.98, 0.52, 0.22)}
bpy.ops.wm.read_factory_settings(use_empty=True); sc = bpy.context.scene
def mat(name):
    m = bpy.data.materials.new(name); m.use_nodes = True; b = m.node_tree.nodes["Principled BSDF"]
    if name == "glass":
        b.inputs["Base Color"].default_value = (0.004, 0.004, 0.006, 1); b.inputs["Roughness"].default_value = 0.35
        b.inputs["Coat Weight"].default_value = 0.35; b.inputs["Coat Roughness"].default_value = 0.08
    elif name == "pix":
        b.inputs["Base Color"].default_value = (1, 1, 1, 1); b.inputs["Emission Color"].default_value = (0.85, 0.92, 1.0, 1); b.inputs["Emission Strength"].default_value = 6.0
    elif name == "floor":
        b.inputs["Base Color"].default_value = lin((0.80, 0.78, 0.74)); b.inputs["Roughness"].default_value = 0.9
    else:
        b.inputs["Base Color"].default_value = lin(COL[name]); b.inputs["Roughness"].default_value = 0.42
        b.inputs["Subsurface Weight"].default_value = 0.08; b.inputs["Subsurface Radius"].default_value = (0.02, 0.02, 0.02)
    return m
M = {n: mat(n) for n in ["body", "key", "acc", "glass", "pix", "floor"]}
def load(path, m):
    bpy.ops.wm.stl_import(filepath=path); o = bpy.context.selected_objects[0]
    o.scale = (S, S, S); bpy.context.view_layer.objects.active = o; bpy.ops.object.transform_apply(scale=True)
    o.data.materials.append(M[m]); bpy.ops.object.shade_smooth(); return o
if view == "plate":
    for f in os.listdir(os.path.join(HERE, "plate")):
        m = "acc" if ("key1" in f or "knob" in f) else ("key" if "key" in f and "plate" not in f else "body")
        load(os.path.join(HERE, "plate", f), m)
    pass
else:
    sel = {"base": "body", "deck": "body", "keyplate": "body", "shell": "body", "back": "body", "knob": "acc",
           "r_glass": "glass", "r_pix": "pix", "r_key0": "key", "r_key1": "acc", "r_key2": "key", "r_key3": "key"}
    for n, m in sel.items(): load(os.path.join(PARTS, n + ".stl"), m)
bpy.ops.mesh.primitive_plane_add(size=20, location=(0, 0, -0.0005)); M_floor = bpy.context.object; M_floor.data.materials.append(M["floor"])
# camera
cam = bpy.data.cameras.new("c"); co = bpy.data.objects.new("c", cam); sc.collection.objects.link(co); sc.camera = co
tgt = Vector((0, 0.17, 0.27))
if view == "plate":
    cam.type = 'ORTHO'; cam.ortho_scale = 1.95; co.location = (0.9, 0.9, 6); co.rotation_euler = (0, 0, 0)
else:
    cam.lens = 85
    az, el, d = {"hero": (38, 24, 3.1), "back": (150, 24, 3.1), "side": (90, 4, 3.4)}[view]
    co.location = tgt + Vector((d*math.cos(math.radians(el))*math.sin(math.radians(az)), -d*math.cos(math.radians(el))*math.cos(math.radians(az)), d*math.sin(math.radians(el))))
    direction = tgt - co.location; co.rotation_euler = direction.to_track_quat('-Z', 'Y').to_euler()
def light(name, kind, loc, energy, size):
    l = bpy.data.lights.new(name, kind); l.energy = energy
    if kind == 'AREA': l.size = size
    o = bpy.data.objects.new(name, l); o.location = loc; sc.collection.objects.link(o)
    o.rotation_euler = (tgt - Vector(loc)).to_track_quat('-Z', 'Y').to_euler()
light("key", 'AREA', (-2.2, -3, 3.5), 260, 2.5); light("fill", 'AREA', (3, -2, 1.5), 90, 3); light("rim", 'AREA', (1, 3, 3), 120, 2)
w = bpy.data.worlds.new("w"); sc.world = w; w.use_nodes = True
w.node_tree.nodes["Background"].inputs[0].default_value = (0.93, 0.91, 0.88, 1); w.node_tree.nodes["Background"].inputs[1].default_value = 0.9
sc.render.engine = 'CYCLES'; sc.cycles.samples = samples; sc.cycles.use_denoising = True
sc.render.resolution_x, sc.render.resolution_y = res; sc.render.filepath = out
try: sc.view_settings.view_transform = 'Standard'
except Exception: pass
bpy.ops.render.render(write_still=True)
