"""Translate binary STLs so their bbox min corner sits at (x0, y0, 0). usage: place.py outdir name:x0:y0:file ..."""
import struct, sys, os
out = sys.argv[1]; os.makedirs(out, exist_ok=True)
for spec in sys.argv[2:]:
    name, x0, y0, f = spec.split(':', 3); x0 = float(x0); y0 = float(y0)
    raw = open(f, 'rb').read()
    if raw[:5] == b'solid' and b'facet' in raw[:400]:          # ASCII STL (OpenSCAD export) -> binary
        import re
        vs = [float(x) for x in re.findall(rb'vertex\s+(\S+)\s+(\S+)\s+(\S+)', raw) for x in x]
        n = len(vs) // 9; d = bytearray(84 + 50*n); d[80:84] = struct.pack('<I', n)
        for i in range(n): d[84+50*i+12:84+50*i+48] = struct.pack('<9f', *vs[9*i:9*i+9])
    else:
        d = bytearray(raw); n = struct.unpack('<I', d[80:84])[0]
    mn = [1e9, 1e9, 1e9]
    for i in range(n):
        v = struct.unpack('<12f', d[84+50*i:84+50*i+48])
        for k in range(3):
            for p in range(3): mn[k] = min(mn[k], v[3+3*p+k])
    dx, dy, dz = x0 - mn[0], y0 - mn[1], -mn[2]
    for i in range(n):
        o = 84 + 50*i; v = list(struct.unpack('<12f', d[o:o+48]))
        for p in range(3):
            v[3+3*p] += dx; v[4+3*p] += dy; v[5+3*p] += dz
        d[o:o+48] = struct.pack('<12f', *v)
    open(os.path.join(out, name), 'wb').write(d); print(name, 'placed at', x0, y0, 'shift', round(dx, 2), round(dy, 2), round(dz, 2))
