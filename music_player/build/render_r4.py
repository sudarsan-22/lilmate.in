# Blender product-shot render for the round-4 music player looks.
# usage: blender -b -P render_r4.py -- <design 10|11|12|group> <front|back> <out.png> [samples] [WxH]
import bpy, bmesh, sys, os, math
from mathutils import Vector

argv = sys.argv[sys.argv.index("--") + 1:]
design, view, out = argv[0], argv[1], argv[2]
samples = int(argv[3]) if len(argv) > 3 else 128
res = [int(v) for v in (argv[4] if len(argv) > 4 else "1200x1500").split("x")]
HERE = os.path.dirname(os.path.abspath(__file__))
PARTS = os.path.join(HERE, "r4")
S = 0.01                                         # 1 mm -> 0.01 unit

def lin(c): return tuple((v ** 2.2) for v in c) + (1.0,)
COL = {   # sRGB-ish, same as look4.scad
    "J_body": (0.94, 0.89, 0.80), "J_acc": (0.97, 0.43, 0.34),
    "K_body": (0.97, 0.92, 0.89), "K_acc": (0.95, 0.56, 0.62),
    "L_body": (0.90, 0.84, 0.72), "L_key": (0.74, 0.71, 0.66), "L_acc": (0.98, 0.52, 0.22),
}

bpy.ops.wm.read_factory_settings(use_empty=True)
sc = bpy.context.scene

def material(name):
    m = bpy.data.materials.get(name)
    if m: return m
    m = bpy.data.materials.new(name); m.use_nodes = True
    b = m.node_tree.nodes["Principled BSDF"]
    if name == "glass":
        b.inputs["Base Color"].default_value = (0.004, 0.004, 0.006, 1)
        b.inputs["Roughness"].default_value = 0.35
        b.inputs["Specular IOR Level"].default_value = 0.25
        b.inputs["Coat Weight"].default_value = 0.35
        b.inputs["Coat Roughness"].default_value = 0.08
    elif name == "pix":
        b.inputs["Base Color"].default_value = (1, 1, 1, 1)
        b.inputs["Emission Color"].default_value = (0.85, 0.92, 1.0, 1)
        b.inputs["Emission Strength"].default_value = 6.0
    elif name == "shadow":
        b.inputs["Base Color"].default_value = lin((0.45, 0.43, 0.40))
        b.inputs["Roughness"].default_value = 0.6
    elif name == "backdrop":
        b.inputs["Base Color"].default_value = lin((0.97, 0.95, 0.92))
        b.inputs["Roughness"].default_value = 0.9
    else:   # matte PLA-like plastic
        b.inputs["Base Color"].default_value = lin(COL[name])
        b.inputs["Roughness"].default_value = 0.42
        b.inputs["Specular IOR Level"].default_value = 0.35
        b.inputs["Subsurface Weight"].default_value = 0.08
        b.inputs["Subsurface Radius"].default_value = (0.02, 0.02, 0.02)
    return m

def load(d, dx, rotz):
    objs = []
    for f in sorted(os.listdir(PARTS)):
        if not f.startswith("d%s_" % d): continue
        part = f[len("d%s_" % d):-4]
        bpy.ops.wm.stl_import(filepath=os.path.join(PARTS, f))
        o = bpy.context.selected_objects[0]
        me = o.data
        bm = bmesh.new(); bm.from_mesh(me)
        bmesh.ops.remove_doubles(bm, verts=bm.verts, dist=1e-4)
        bm.to_mesh(me); bm.free()
        o.scale = (S, S, S); o.rotation_euler = (0, 0, rotz); o.location = (dx, 0, 0)
        bpy.context.view_layer.objects.active = o
        bpy.ops.object.shade_smooth_by_angle(angle=math.radians(32))
        o.data.materials.append(material(part))
        objs.append(o)
    return objs

rot = math.pi if view == "back" else 0.0
if design == "group":
    objs = load(10, -0.78, rot) + load(11, 0.0, rot) + load(12, 0.80, rot)
else:
    objs = load(design, 0.0, rot)

# bounding box of everything
bpy.context.view_layer.update()
pts = [o.matrix_world @ Vector(c) for o in objs for c in o.bound_box]
lo = Vector((min(p.x for p in pts), min(p.y for p in pts), min(p.z for p in pts)))
hi = Vector((max(p.x for p in pts), max(p.y for p in pts), max(p.z for p in pts)))
ctr = (lo + hi) / 2; size = hi - lo

# cyclorama backdrop (floor curving up into a wall behind)
bm = bmesh.new(); prof = []
for i in range(0, 13):
    prof.append((-8 + i * 0.75, 0.0))                       # floor y -8 .. 1
R = 2.0
for k in range(1, 17):
    a = math.radians(90 * k / 16)
    prof.append((1 + R * math.sin(a), R - R * math.cos(a)))
prof.append((1 + R, 9.0))
rows = []
for x in (-12, 12):
    rows.append([bm.verts.new((x, y, z)) for (y, z) in prof])
for i in range(len(prof) - 1):
    bm.faces.new((rows[0][i], rows[0][i + 1], rows[1][i + 1], rows[1][i]))
me = bpy.data.meshes.new("cyc"); bm.to_mesh(me); bm.free()
cyc = bpy.data.objects.new("cyc", me); sc.collection.objects.link(cyc)
cyc.data.materials.append(material("backdrop"))
cyc.location.y = ctr.y + 1.2
for p in cyc.data.polygons: p.use_smooth = True

# lights: big soft key from upper-left front, fill from right, rim from behind
def area(name, loc, energy, sz, color=(1, 1, 1)):
    l = bpy.data.lights.new(name, "AREA"); l.energy = energy; l.size = sz; l.color = color
    o = bpy.data.objects.new(name, l); sc.collection.objects.link(o)
    o.location = ctr + Vector(loc)
    t = o.constraints.new("TRACK_TO"); e = bpy.data.objects.new(name + "_t", None)
    sc.collection.objects.link(e); e.location = ctr; t.target = e
    return o
k = max(size.x, size.z) / 1.0
area("key", (-1.6 * k, -2.0 * k, 1.9 * k), 260 * k * k, 1.8 * k, (1.0, 0.97, 0.93))
area("fill", (2.2 * k, -1.4 * k, 0.6 * k), 90 * k * k, 2.2 * k, (0.92, 0.95, 1.0))
area("rim", (0.8 * k, 2.2 * k, 1.8 * k), 180 * k * k, 1.2 * k)
area("top", (0, -0.3 * k, 2.6 * k), 70 * k * k, 2.5 * k)
w = bpy.data.worlds.new("w"); sc.world = w; w.use_nodes = True
w.node_tree.nodes["Background"].inputs[0].default_value = lin((0.93, 0.92, 0.90))
w.node_tree.nodes["Background"].inputs[1].default_value = 0.35

# camera: 3/4 view, slightly above
cam = bpy.data.cameras.new("cam"); cam.lens = 85; cam.sensor_fit = "AUTO"
co = bpy.data.objects.new("cam", cam); sc.collection.objects.link(co); sc.camera = co
az = math.radians(-28 if design != "group" else -14); el = math.radians(16)
d = Vector((math.sin(az) * math.cos(el), -math.cos(az) * math.cos(el), math.sin(el)))
sc.render.resolution_x, sc.render.resolution_y = res
aspect = res[0] / res[1]
fov = 2 * math.atan(36 / 2 / cam.lens)                  # fov of the longer side
half_w = max(size.x, size.y) * 0.62; half_h = size.z * 0.62
need = max(half_w / (math.tan(fov / 2) * (1 if aspect >= 1 else aspect)),
           half_h / (math.tan(fov / 2) * (1 / aspect if aspect >= 1 else 1)))
co.location = ctr + d * need * 1.12
tgt = bpy.data.objects.new("cam_t", None); sc.collection.objects.link(tgt); tgt.location = ctr
c = co.constraints.new("TRACK_TO"); c.target = tgt

# render settings
sc.render.engine = "CYCLES"
prefs = bpy.context.preferences.addons["cycles"].preferences
for dev in ("OPTIX", "CUDA"):
    try:
        prefs.compute_device_type = dev; prefs.get_devices()
        if any(x.type == dev for x in prefs.devices):
            for x in prefs.devices: x.use = True
            sc.cycles.device = "GPU"; break
    except Exception:
        pass
sc.cycles.samples = samples; sc.cycles.use_denoising = True
sc.view_settings.view_transform = "AgX"; sc.view_settings.look = "AgX - Punchy"; sc.view_settings.exposure = -0.55
sc.render.film_transparent = False
sc.render.filepath = out
bpy.ops.render.render(write_still=True)
print("WROTE", out, "device", sc.cycles.device)
