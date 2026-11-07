"""Run portable core behavior tests: python -m pip install lupa; python tests/run_memao.py.
Lupa validates the Lua-compatible subset used here, not the U2U host or annotation parser.
"""
from pathlib import Path
import re
from lupa import LuaRuntime
root = Path(__file__).resolve().parents[1]
# Compare every packed range against the MZ source when tested in the parent repo.
mz = root.parent / 'mz/Cloud_MemaoAnimatorMZ.js'
if mz.exists():
    block = mz.read_text().split('const DEFAULT_ROW_MAP = {', 1)[1].split('function parseRowMapOverride', 1)[0]
    expected = []
    for row, entries in re.findall(r'\{ r:\s*(\d+),\s*entries:\s*\[(.*?)\]', block, re.S):
        for name, first, last in re.findall(r'\{\s*"?name"?:\s*"([^"]+)",\s*"?start"?:\s*(\d+),\s*"?end"?:\s*(\d+)\s*\}', entries):
            expected.append((name, int(row), int(first), int(last)))
    actual = [(name, int(row), int(first), int(last)) for name, row, first, last in
              re.findall(r'\{ "([^"]+)", (\d+), (\d+), (\d+) \}',
                         (root / 'Cloud_MemaoAnimatorU2U.luau').read_text())]
    assert len(expected) == 103 and expected == actual, 'MZ frame range parity failed'
    print('All 103 MZ frame ranges match', flush=True)
lua = LuaRuntime(unpack_returned_tuples=True)
memao = lua.execute((root / 'Cloud_MemaoAnimatorU2U.luau').read_text())
lua.execute((root / 'tests/memao.spec.lua').read_text(), memao)
