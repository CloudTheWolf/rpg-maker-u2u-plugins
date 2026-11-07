--[[:
@plugindesc Memao Animator U2U development port (adapter required)
@author CloudTheWolf
@help
Animation core ported from Cloud_MemaoAnimatorMZ.js v1.6.
Not a standalone installed plugin: return value must be consumed by a verified
U2U integration. See Cloud_MemaoAnimatorU2U.md for the adapter contract.
No undocumented ctx calls or global mutations are performed here.
]]

local Memao = {}
local defaultRanges = {
    { "idleDown", 1, 1, 4 },
    { "idleUp", 1, 5, 8 },
    { "idleLeft", 2, 1, 4 },
    { "idleRight", 2, 5, 8 },
    { "walkDown", 3, 1, 6 },
    { "walkUp_a", 3, 7, 8 },
    { "walkUp_b", 4, 1, 4 },
    { "walkLeft_a", 4, 5, 8 },
    { "walkLeft_b", 5, 1, 2 },
    { "walkRight", 5, 3, 8 },
    { "runDown", 6, 1, 6 },
    { "runUp_a", 6, 7, 8 },
    { "runUp_b", 7, 1, 4 },
    { "runLeft_a", 7, 5, 8 },
    { "runLeft_b", 8, 1, 2 },
    { "runRight", 8, 3, 8 },
    { "pickupDown", 9, 1, 4 },
    { "pickupUp", 9, 5, 8 },
    { "pickupLeft", 10, 1, 4 },
    { "pickupRight", 10, 5, 8 },
    { "pickaxeDown", 11, 1, 4 },
    { "pickaxeUp", 11, 5, 8 },
    { "pickaxeLeft", 12, 1, 4 },
    { "pickaxeRight", 12, 5, 8 },
    { "axe_chopDown", 13, 1, 4 },
    { "axe_chopUp", 13, 5, 8 },
    { "axe_chopLeft", 14, 1, 4 },
    { "axe_chopRight", 14, 5, 8 },
    { "plantDown", 15, 1, 3 },
    { "plantUp", 15, 4, 6 },
    { "plantLeft_a", 15, 7, 8 },
    { "plantLeft_b", 16, 1, 1 },
    { "plantRight", 16, 2, 4 },
    { "waterDown", 16, 5, 8 },
    { "waterUp", 17, 1, 4 },
    { "waterLeft", 17, 5, 8 },
    { "waterRight", 18, 1, 4 },
    { "reapDown", 18, 5, 8 },
    { "reapUp", 19, 1, 4 },
    { "reapLeft", 19, 5, 8 },
    { "reapRight", 20, 1, 4 },
    { "slashDown", 20, 5, 8 },
    { "slashUp", 21, 1, 4 },
    { "slashLeft", 21, 5, 8 },
    { "slashRight", 22, 1, 4 },
    { "hurtDown", 22, 5, 6 },
    { "hurtUp", 22, 7, 8 },
    { "hurtLeft", 23, 1, 2 },
    { "hurtRight", 23, 3, 4 },
    { "downedDown", 23, 5, 6 },
    { "downedUp", 23, 7, 8 },
    { "downedLeft", 24, 1, 2 },
    { "downedRight", 24, 3, 4 },
    { "deathDown", 24, 5, 7 },
    { "deathUp_a", 24, 8, 8 },
    { "deathUp_b", 25, 1, 2 },
    { "deathLeft", 25, 3, 5 },
    { "deathRight", 25, 6, 8 },
    { "eatDown", 26, 1, 3 },
    { "eatUp", 26, 4, 6 },
    { "eatLeft_a", 26, 7, 8 },
    { "eatLeft_b", 27, 1, 1 },
    { "eatRight", 27, 2, 4 },
    { "drinkDown", 27, 5, 7 },
    { "drinkUp_a", 27, 8, 8 },
    { "drinkUp_b", 28, 1, 2 },
    { "drinkLeft", 28, 3, 5 },
    { "drinkRight", 28, 6, 8 },
    { "waveDown", 29, 1, 4 },
    { "waveUp", 29, 5, 8 },
    { "waveLeft", 30, 1, 4 },
    { "waveRight", 30, 5, 8 },
    { "laughDown", 31, 1, 3 },
    { "laughUp", 31, 4, 6 },
    { "laughLeft_a", 31, 7, 8 },
    { "laughLeft_b", 32, 1, 1 },
    { "laughRight", 32, 2, 4 },
    { "shrugDown", 32, 5, 8 },
    { "shrugUp", 33, 1, 4 },
    { "shrugLeft", 33, 5, 8 },
    { "shrugRight", 34, 1, 4 },
    { "thinkDown", 34, 5, 8 },
    { "thinkUp", 35, 1, 4 },
    { "thinkLeft", 35, 5, 8 },
    { "thinkRight", 36, 1, 4 },
    { "sitDown", 36, 5, 8 },
    { "sitUp", 37, 1, 4 },
    { "sitLeft", 37, 5, 8 },
    { "sitRight", 38, 1, 4 },
    { "readDown", 38, 5, 8 },
    { "readUp", 39, 1, 4 },
    { "readLeft", 39, 5, 8 },
    { "readRight", 40, 1, 4 },
    { "paintLeft", 40, 5, 8 },
    { "paintRight", 41, 1, 4 },
    { "hoeDown", 42, 1, 4 },
    { "hoeUp", 42, 5, 8 },
    { "hoeLeft", 43, 1, 4 },
    { "hoeRight", 43, 5, 8 },
    { "axe_strikeDown", 44, 1, 4 },
    { "axe_strikeUp", 44, 5, 8 },
    { "axe_strikeLeft", 45, 1, 4 },
    { "axe_strikeRight", 45, 5, 8 },
}

local directions = { [2] = "Down", [4] = "Left", [6] = "Right", [8] = "Up" }
local aliases = {
    ["pick up"] = "pickup", ["pick-up"] = "pickup", pick = "pickup",
    ["pick axe"] = "pickaxe", mining = "pickaxe", chop = "axe_chop",
    chopping = "axe_chop", sow = "plant", seed = "plant", watering = "water",
    scythe = "reap",
}
local function number(value, default, low, high)
    local n = tonumber(value)
    if not n or n ~= n or n == math.huge or n == -math.huge then n = default end
    return math.max(low, math.min(high, n))
end
local function boolean(value, default)
    if value == nil then return default end
    return value == true or value == "true"
end
local function normalized(value)
    return tostring(value or ""):lower():match("^%s*(.-)%s*$")
end
local function append(out, source)
    for _, frame in ipairs(source) do out[#out + 1] = frame end
end

function Memao.isMemaoName(name)
    return type(name) == "string" and name:lower():sub(-9) == "_$(memao)"
end

-- Each instance belongs to one map character. Inputs are snapshots, not host objects.
function Memao.new(parameters)
    local p = parameters or {}
    local self = {}
    local ranges = {}
    local source = defaultRanges
    if p.RowMapOverride ~= nil then
        -- Adapter decodes JSON; the core accepts the original { rows = ... } table.
        assert(type(p.RowMapOverride) == "table" and type(p.RowMapOverride.rows) == "table",
            "RowMapOverride must be a decoded table with rows")
        source = {}
        for _, row in ipairs(p.RowMapOverride.rows) do
            for _, entry in ipairs(row.entries or {}) do
                source[#source + 1] = { entry.name, row.r, entry.start, entry["end"] }
            end
        end
    end
    for _, range in ipairs(source) do
        local name, row, first, last = range[1], tonumber(range[2]), tonumber(range[3]), tonumber(range[4])
        assert(type(name) == "string" and row and first and last
            and row >= 1 and first >= 1 and last >= first and last <= 4096
            and row < math.huge and row % 1 == 0 and first % 1 == 0 and last % 1 == 0,
            "Invalid row map range")
        local frames = {}
        for column = first, last do frames[#frames + 1] = { row = row, column = column } end
        ranges[name] = frames
    end
    assert(ranges.idleDown and #ranges.idleDown > 0, "Row map requires idleDown")
    local width = number(p.CellWidth, 48, 1, 4096)
    local height = number(p.CellHeight, 48, 1, 4096)
    local scale = number(p.ScalePercent, 200, 1, 800) / 100
    local fps = {
        idle = number(p.IdleFps, 3, 0.01, 60), walk = number(p.WalkFps, 7, 0.01, 60),
        run = number(p.RunFps, 9, 0.01, 60), action = number(p.ActionFps, 8, 0.01, 60),
    }
    local idleEnabled = boolean(p.EnableIdle, true)
    local manual, sequence, key = nil, {}, nil
    local index, elapsed, cycles, revision, moveHold = 1, 0, 0, 0, 0
    local lastDirection = 2

    local function framesFor(action, direction)
        local base = (action == "revive" and "death" or action) .. directions[direction]
        local out = {}
        if ranges[base .. "_a"] then
            append(out, ranges[base .. "_a"])
            append(out, ranges[base .. "_b"] or {})
        else
            append(out, ranges[base] or {})
        end
        if #out == 0 then append(out, ranges["idle" .. directions[direction]] or ranges.idleDown) end
        return out
    end

    function self.playAction(args)
        args = args or {}
        local action = normalized(args.Action or "axe")
        action = aliases[action] or action
        local known = action == "revive"
        for _, direction in pairs(directions) do
            known = known or ranges[action .. direction] ~= nil or ranges[action .. direction .. "_a"] ~= nil
        end
        if not known then action = "idle" end
        local direction = normalized(args.Direction or "current")
        local dir = ({ up = 8, down = 2, left = 4, right = 6 })[direction] or lastDirection
        revision = revision + 1
        manual = {
            action = action, direction = dir,
            loop = action ~= "death" and (action == "downed" or boolean(args.Loop, false)),
            hold = action == "death" or boolean(args.HoldLastFrame, false),
            repeatEnding = boolean(args.RepeatLastTwo, false),
            repeats = math.floor(number(args.RepeatCount, 3, 0, 99)),
            done = false, locked = true,
        }
        key = nil
        -- Wait token completes after one full extended sequence, even when looping.
        return { revision = revision, cycle = cycles + 1 }
    end

    function self.stopAction()
        manual = nil
        revision = revision + 1
        key = nil
    end

    function self.setIdleAnimation(enabled)
        idleEnabled = boolean(enabled, true)
        key = nil
    end

    function self.isWaiting(token)
        return token ~= nil and token.revision == revision and cycles < token.cycle and manual ~= nil
    end

    function self.update(dt, snapshot)
        assert(type(dt) == "number" and dt >= 0 and dt < math.huge, "dt must be finite seconds >= 0")
        local s = snapshot or {}
        lastDirection = directions[s.direction] and s.direction or lastDirection
        if s.moving then moveHold = 6 / 60 else moveHold = math.max(0, moveHold - dt) end
        local action = manual and manual.action or (moveHold > 0 and (s.dashing and "run" or "walk") or "idle")
        local dir = manual and manual.direction or lastDirection
        local idleMode = not idleEnabled and "disabled" or (s.idlePause == false and "loop" or "pause")
        local nextKey = action .. ":" .. dir .. ":" .. idleMode .. ":" .. revision .. ":" .. tostring(manual ~= nil)
        local rate = manual and fps.action * (action == "downed" and 0.25 or 1) or fps[action]
        if nextKey ~= key then
            key, index, elapsed = nextKey, 1, 0
            sequence = framesFor(action, dir)
            if action == "idle" then
                if idleMode == "disabled" then sequence = { sequence[1] }
                elseif idleMode == "pause" then
                    local out = { sequence[1], sequence[1], sequence[1] }
                    append(out, sequence)
                    sequence = out
                end
            elseif action == "revive" then
                local out = {}
                for i = #sequence, 1, -1 do out[#out + 1] = sequence[i] end
                sequence = out
            elseif manual and action == "water" then
                local length = #sequence
                for i = length - 1, 1, -1 do sequence[#sequence + 1] = sequence[i] end
            end
            if manual and manual.repeatEnding and (action == "wave" or action == "laugh" or action == "drink") and #sequence >= 2 then
                local original = {}
                append(original, sequence)
                for _ = 1, manual.repeats do
                    sequence[#sequence + 1] = original[#original - 1]
                    sequence[#sequence + 1] = original[#original]
                end
                if action == "drink" then
                    for i = #original, 1, -1 do sequence[#sequence + 1] = original[i] end
                end
            end
        end
        if not (manual and manual.done) then
            elapsed = elapsed + dt * rate
            local steps = math.floor(elapsed)
            elapsed = elapsed - steps
            if manual and not manual.loop and index + steps > #sequence then
                cycles = cycles + 1
                manual.done, manual.locked = true, false
                index = #sequence
                if not manual.hold then
                    self.stopAction()
                    return self.update(0, s)
                end
            else
                cycles = cycles + math.floor((index - 1 + steps) / #sequence)
                index = (index - 1 + steps) % #sequence + 1
            end
        end
        local frame = sequence[index]
        -- Renderer consumes this description; coordinates are zero-based pixels.
        return {
            row = frame.row, column = frame.column,
            sourceX = (frame.column - 1) * width, sourceY = (frame.row - 1) * height,
            width = width, height = height, scale = scale,
            xOffset = number(p.XOffset, 0, -100000, 100000),
            yOffset = number(p.YOffset, 8, -100000, 100000) * scale,
            crispPixels = boolean(p.CrispPixels, true), anchorX = 0.5, anchorY = 1,
            locked = manual ~= nil and manual.locked,
            done = manual ~= nil and manual.done, action = action, cycles = cycles,
        }
    end
    return self
end

return Memao
