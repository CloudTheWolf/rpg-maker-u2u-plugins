-- Reconstructed, untested resident example.
-- The registerParamEditor/onEditor contracts are visible in the embedded shim.
-- The manifest parser and runtime annotation integration are not runtime-tested.

local typeName = "ExampleMapTarget"

local function parseTarget(value)
    if type(value) ~= "string" then
        return nil
    end
    local map, x, y = string.match(value, "^(%d+):(%d+):(%d+)$")
    if map == nil then
        return nil
    end
    local mapId = tonumber(map)
    local tileX = tonumber(x)
    local tileY = tonumber(y)
    if mapId == nil or tileX == nil or tileY == nil
        or mapId == math.huge or tileX == math.huge or tileY == math.huge
        or mapId < 1 then
        return nil
    end
    return { map = mapId, x = tileX, y = tileY }
end

ctx.editor.registerParamEditor({
    type = typeName,

    open = function(_request)
        -- This deliberately returns no replacement.
        -- To implement real picking, first establish:
        --   * supported ctx.editor.pick.position(opts) option fields;
        --   * the returned result's exact fields and cancellation value;
        --   * how to resolve the intended runtime map identity.
        -- Call the picker here, in this host-managed coroutine, then serialize
        -- the verified result to a string. Do not guess result.x/result.mapId.
        ctx.editor.log(typeName .. ": picker result schema is not yet documented; cancelled.")
        return nil
    end,

    render = function(value)
        local target = parseTarget(value)
        if target == nil then
            return "Invalid map target"
        end
        return "Map " .. tostring(target.map) .. " at "
            .. tostring(target.x) .. ", " .. tostring(target.y)
    end,

    validate = function(value)
        if parseTarget(value) == nil then
            return false, "Use map:x:y with a positive map number and nonnegative integer coordinates."
        end
        -- This checks our string format only, not existence or map bounds.
        return true
    end,
})

onEditor("project.opened", function(payload)
    ctx.editor.log(typeName .. ": received " .. tostring(payload.hook))
end)
