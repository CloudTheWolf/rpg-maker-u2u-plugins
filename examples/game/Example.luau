--[[:
@plugindesc Reconstructed U2U lifecycle smoke test
@author Example author
@help
Unofficial, untested starter. Requires a plugin-enabled U2U build.
The annotation grammar is reconstructed. The callback deliberately ignores
arguments because the production game.update payload was not recovered.
]]

local updates = 0

on("game.update", function()
    updates += 1
    if updates == 1 then
        print("Example: first game.update received")
    end
end)
