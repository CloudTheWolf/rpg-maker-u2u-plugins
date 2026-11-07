-- Run with a Lua 5.4-compatible runner or Luau runner passing Memao as an argument.
local Memao = ...
local function eq(actual, expected)
    assert(actual == expected, tostring(actual) .. " ~= " .. tostring(expected))
end
local function args(t) return t or {} end
assert(Memao.isMemaoName("!teo_$(MEMAO)"))
assert(not Memao.isMemaoName("teo_$(memao).png"))
local a = Memao.new()
local f = a.update(0, { direction = 2 })
eq(f.row, 1); eq(f.column, 1); eq(f.scale, 2); eq(f.yOffset, 16)
eq(a.update(1, {}).column, 1) -- breathing first frame held four slots
local b = Memao.new({ EnableIdle = false })
eq(b.update(100, {}).column, 1)
b.setIdleAnimation(true)
eq(b.update(1 / 3, { idlePause = false }).column, 2)
local c = Memao.new({ WalkFps = 6 })
eq(c.update(0, { moving = true, direction = 8 }).column, 7)
eq(c.update(2 / 6, { moving = true, direction = 8 }).row, 4)
eq(c.update(0.05, { moving = false }).action, "walk")
eq(c.update(0.06, {}).action, "idle")
eq(c.update(0, { moving = true, dashing = true, direction = 6 }).row, 8)
local function columns(animator, action, direction, count, extra)
    local p = extra or {}
    p.Action, p.Direction, p.HoldLastFrame = action, direction, true
    local token = animator.playAction(p)
    local frames = {}
    for i = 1, count do
        local frame = animator.update(i == 1 and 0 or 1 / 8, {})
        frames[i] = frame.row .. ":" .. frame.column
    end
    return table.concat(frames, ","), token
end
local d = Memao.new()
local seq, token = columns(d, "revive", "up", 3)
eq(seq, "25:2,25:1,24:8")
assert(d.isWaiting(token))
local done = d.update(1 / 8, {})
assert(done.done and not done.locked and not d.isWaiting(token))
seq = columns(d, "water", "down", 7)
eq(seq, "16:5,16:6,16:7,16:8,16:7,16:6,16:5")
seq, token = columns(d, "wave", "left", 8, { RepeatLastTwo = true, RepeatCount = 2, Loop = true })
eq(seq, "30:1,30:2,30:3,30:4,30:3,30:4,30:3,30:4")
assert(d.isWaiting(token))
d.update(1 / 8, {})
assert(not d.isWaiting(token))
seq = columns(d, "drink", "down", 8, { RepeatLastTwo = true, RepeatCount = 1 })
eq(seq, "27:5,27:6,27:7,27:6,27:7,27:7,27:6,27:5")
token = d.playAction({ Action = "death", Loop = true })
done = d.update(10, {})
assert(done.done and not done.locked and not d.isWaiting(token))
eq(done.column, 7)
eq(d.update(10, {}).column, 7)
d.playAction({ Action = "downed" })
assert(not d.update(1, {}).done)
d.stopAction()
assert(not d.update(0, {}).locked)
token = d.playAction({ Action = "hurt" })
d.playAction({ Action = "wave" })
assert(not d.isWaiting(token))
d.stopAction()
token = d.playAction({ Action = "hurt" })
eq(d.update(1, {}).action, "idle")
assert(not d.isWaiting(token))
local custom = Memao.new({ RowMapOverride = { rows = {
    { r = 2, entries = { { name = "idleDown", start = 2, ["end"] = 3 } } }
} } })
f = custom.update(0, {})
eq(f.sourceX, 48); eq(f.sourceY, 48)
assert(not pcall(Memao.new, { RowMapOverride = "{}" }))
assert(not pcall(d.update, -1, {}))
-- Fractional rate and large delta follow the same elapsed-time clock.
local x, y = Memao.new(), Memao.new()
x.update(0, { idlePause = false }); y.update(0, { idlePause = false })
for _ = 1, 60 do f = x.update(1 / 60, { idlePause = false }) end
local other = y.update(1, { idlePause = false })
eq(f.column, other.column)
print("Memao core tests passed")
