# Memao Animator U2U development port

`Cloud_MemaoAnimatorU2U.luau` ports the animation core of
`mz/Cloud_MemaoAnimatorMZ.js` v1.6 into Luau. **This is an adapter-ready core,
not a working standalone U2U plugin.** The available demo evidence does not
establish character sprite replacement, command registration, parameter access,
or module loading signatures. See [the local authoring guide](docs/README.md).
No guessed `ctx` calls are shipped. Engine integration and in-engine testing remain required.

The port preserves all 103 named ranges in the 8-column, 45-row sheet,
split-row animations, idle breathing, walk/run selection, water ping-pong,
reverse death for revive, slow looping downed, death holding its final frame,
and wave/laugh/drink ending repeats (including drink's reversed finish).
Unsupported action/direction combinations fall back to directional idle.
Graphic names, without extension, must end with `_$(memao)` (case insensitive).

## Core API

The file returns `Memao`. Load or embed it using the integration mechanism
verified for your U2U build; this file does not assume `require` exists.
Each character needs a separate `Memao.new(parameters)` instance.
All calls use dot syntax, without an implicit `self` argument.

```lua
local animator = Memao.new({ ScalePercent = 200, WalkFps = 7 })
-- First provide the character's current state so Direction=current is known.
local frame = animator.update(0, { direction = 2, moving = false })
local waitToken = animator.playAction({
    Action = "wave", Direction = "current", Loop = false,
    RepeatLastTwo = true, RepeatCount = 3,
})
-- Once per game update; dt is elapsed SECONDS supplied by the integration.
frame = animator.update(1 / 60, {
    direction = 2, moving = false, dashing = false, idlePause = true,
})
local shouldPauseInterpreter = animator.isWaiting(waitToken)
animator.stopAction()
animator.setIdleAnimation(false)
```

`playAction` accepts the MZ action options, including string booleans, direction
names, Loop, HoldLastFrame, RepeatLastTwo and RepeatCount (0–99, default 3).
Use `stopAction` to cancel/unlock. Wait tokens finish after one full extended
sequence, or immediately when stopped/replaced. Looping actions stay locked
until stopped; completed one-shot and held actions unlock.
Target, EventId and Wait belong to the adapter/interpreter, not the core.

Parameters: CellWidth/CellHeight (48), ScalePercent (200), CrispPixels (true),
XOffset (0), YOffset (8, scaled), WalkFps (7), IdleFps (3), RunFps (9),
ActionFps (8), EnableIdle (true), RowMapOverride (optional).
Defaults match the MZ plugin manager header. RowMapOverride must be a decoded
`{ rows = { { r = 1, entries = { { name = "idleDown", start = 1, ["end"] = 4 } } } }`
table, with at least idleDown; the adapter must decode JSON parameter strings.

## Required U2U adapter

1. Read configured parameters using verified host signatures. Create instances
   for Memao player, follower and event graphics. Destroy/reset instances and
   cancel their waits when characters disappear, change sheet, or maps unload.
2. Feed direction (2/4/6/8), movement and dashing snapshots on each map update.
   Followers inherit player dashing; events normally do not dash. Convert
   `<ctw:idlePause:false>` actor/event notes into `idlePause = false`.
3. Apply the returned sourceX/sourceY/width/height crop to the character image.
   Apply scale, bottom-center anchor, X/Y offsets and crisp nearest sampling,
   disable mipmaps if supported, round screen positions, and carry character
   depth, visibility and opacity. Suppress the original sprite while attached;
   restore it on detach. Keep engine-owned effects/balloons attached correctly.
4. Enforce `frame.locked` on player input and event movement routes. Resolve
   player/this-event/explicit-event targets before dispatching actions. Connect
   interpreter waits to `isWaiting(token)` without blocking the game update.
5. Register PlayAction, StopAction and SetIdleAnimation using verified command
   APIs. The MZ Debug window, PIXI/prototype patches, ABS/HUD compatibility,
   shadow handling and save/load integration are not ported host features.
   Persist/rebuild state explicitly if your project needs save continuity.

Intentional fixes: per-character SetIdleAnimation actually affects playback
(the MZ setter stores an unused field), and timing uses elapsed seconds with
fractional carry instead of assuming 60 updates per second. Movement smoothing
uses 0.1 seconds. Calls on ordinary sheets must be filtered by the adapter.

## Validation

Run `python tests/run_memao.py` from this directory with the optional `lupa`
package installed in your development environment. The tests execute the core
in Lua, covering packed rows, playback, repeats, waits, locking, overrides and
fractional timing. The source deliberately uses Lua-compatible Luau syntax.
These tests do not validate U2U loading, annotations, graphics or host APIs.
