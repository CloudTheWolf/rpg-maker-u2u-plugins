-- Reconstructed, untested example. See ../../../README.md.
-- API names are recovered; complete return schemas were not recovered.

local ok, message = pcall(function()
    local current = ctx.editor.getCurrentMap()
    ctx.editor.log("Current map result type: " .. type(current))

    local selection = ctx.editor.getSelection()
    if type(selection) ~= "table" then
        ctx.editor.log("Selection was not returned as a table.")
        return
    end

    local count = 0
    for key, part in pairs(selection) do
        count += 1
        if type(part) == "table" then
            ctx.editor.log(tostring(key) .. ": id=" .. tostring(part.id)
                .. ", type=" .. tostring(part.type))
        else
            ctx.editor.log(tostring(key) .. ": " .. tostring(part))
        end
    end
    ctx.editor.log("Selection entries: " .. tostring(count))
end)

if not ok then
    if type(message) == "table" then
        message = message.message or message.kind or "Editor API error"
    end
    ctx.editor.log("Selection Inspector: " .. tostring(message))
end
