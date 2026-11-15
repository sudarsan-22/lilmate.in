"""Flatten a Bambu Studio system preset (resolve 'inherits') and apply overrides."""
import json, os, sys
SYS = os.path.expanduser("~/.config/BambuStudio/system/BBL")

def load(kind, name):
    with open(os.path.join(SYS, kind, name + ".json")) as f:
        d = json.load(f)
    if d.get("inherits"):
        base = load(kind, d["inherits"])
        base.update(d)
        d = base
    return d

def flat(kind, name, overrides, out):
    d = load(kind, name)
    d.update(overrides)
    d.pop("inherits", None)
    d["inherits"] = ""
    d["from"] = "User"
    d["name"] = name + " (pengu)"
    json.dump(d, open(out, "w"), indent=2)
    return d

if __name__ == "__main__":
    kind, name = sys.argv[1], sys.argv[2]
    d = load(kind, name)
    for k in sys.argv[3:]:
        print(k, "=", json.dumps(d.get(k)))
