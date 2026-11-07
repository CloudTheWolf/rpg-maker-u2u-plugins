# RPG Maker U2U: Luau plugin authoring guide

An unofficial, evidence-based guide to **game (runtime) plugins** and **editor plugins**, recovered from the installed Windows demo. Prepared 7 November 2026. Target build: **2952782**, built **16 October 2026 at 18:58** (timezone not specified by the build file). The bundled license identifies **Luau 0.723**.

This guide is for someone who wants to write, install and use plugins. It covers what this demo establishes, supplies starter files, and identifies what still needs a working plugin-enabled build. It is not an official SDK or a promise about the release version.

**Start here:** read the availability note, choose game or editor plugins, then use the relevant walkthrough. Use [API-INDEX.md](API-INDEX.md) to look up recovered names and [reference.json](reference.json) for machine-readable evidence and source hashes. The [HTML edition](index.html) includes this guide and the API index in one searchable page.

## Contents

1. [Availability and confidence](#availability-and-confidence)
2. [How U2U plugins fit together](#how-u2u-plugins-fit-together)
3. [Luau essentials](#luau-essentials)
4. [Game plugins: files and installation](#game-plugins-files-and-installation)
5. [Game plugin annotations](#game-plugin-annotations)
6. [Game plugin lifecycle and hooks](#game-plugin-lifecycle-and-hooks)
7. [Game plugin APIs and state](#game-plugin-apis-and-state)
8. [Game plugin commands](#game-plugin-commands)
9. [Editor plugins: files and manifests](#editor-plugins-files-and-manifests)
10. [Editor plugin walkthrough](#editor-plugin-walkthrough)
11. [Editor hooks](#editor-hooks)
12. [Custom parameter editors and picking](#custom-parameter-editors-and-picking)
13. [Editor map APIs, IDs and undo](#editor-map-apis-ids-and-undo)
14. [Errors and troubleshooting](#errors-and-troubleshooting)
15. [Testing and distribution](#testing-and-distribution)
16. [Porting MV/MZ plugins](#porting-mvmz-plugins)
17. [Missing contracts and next steps](#missing-contracts-and-next-steps)
18. [Evidence and reproducibility](#evidence-and-reproducibility)

## Availability and confidence

**The demo is not a verified plugin development environment.** The [official demo announcement](https://steamcommunity.com/app/4856440/allnews/) says it does not include game creation features. A developer's [21 October forum response](https://guild.rpgmakerofficial.com/t/topic/3380?tl=en) says the relevant requested plugin functions are unavailable in the demo. That statement does not enumerate every inaccessible API. Locally, this installation contains plugin managers, bindings, a native Luau runtime and an editor bootstrap, but no loose `.luau` scripts, bundled editor-plugin examples, or standalone Luau type definitions were found. Static code presence does not establish that a menu, loader, hook or API can be used in this demo.

The producer's [plugin overview](https://steamcommunity.com/app/4856440/allnews/) confirms the distinction between runtime and editor plugins, the move to Luau and the need to port MV/MZ plugins. It describes a product under development. The detailed contracts in this guide come from the local build, not from that overview.

These labels apply throughout:

| Label | Meaning |
|---|---|
| **Recovered implementation** | Behavior is directly visible in the embedded editor Luau shim. It has not been exercised in U2U here. |
| **Recovered diagnostic/constant** | A literal or stored constant explicitly describes a format, restriction or failure. It does not prove the success path. |
| **Recovered name** | A function, class, field or hook name exists. Its full signature and behavior may be unknown. |
| **Reconstructed example** | A new starter based on the evidence. It is not an extracted official sample and has not been run in U2U. |
| **Unknown** | This investigation did not establish the contract. |

All supplied plugins are **reconstructed examples**, stored only under this documentation folder. They have not been installed into an active project. None should be advertised as tested in the demo.

## How U2U plugins fit together

| Question | Game/runtime plugin | Editor plugin |
|---|---|---|
| When does it run? | Within a game/player Luau host, subject to the current game context | In an editor host, as a command or resident extension |
| What does it change? | Game behavior, UI, events and game state | Authoring workflows, maps and parameter editing |
| How is it described? | Luau annotations and entries in `plugins.json` | A per-plugin `manifest.json` and a main Luau script |
| Where is it expected? | Project `luau/plugins` | Project `luau/editorPlugins/<group>/<plugin>` |
| Main API family | `ctx.game`, `ctx.party`, `ctx.ui` and other runtime namespaces | `ctx.editor` plus `onEditor` for resident hooks |
| Does its existence enable the other kind? | No | No |

The folder layout is reconstructed from catalog class names, stored directory constants and diagnostics. The editor grouping is specifically supported by a message requesting `<DLC>/<plugin>/manifest.json`. The outer group is a discovery grouping; the evidence does not establish a requirement to own or publish paid DLC.

An editor plugin can define a custom parameter editor that helps authors configure a game plugin. It does not follow that its editor hooks will run in an exported game. The exact export inclusion/exclusion rules remain unverified.

Use the host API to work with the engine. Native `LuauCAbi.dll` exports and `__u2u*` bridge names are implementation details, not a public plugin SDK. Do not call them from your plugins.

## Luau essentials

Luau uses Lua-style syntax. Its upstream [syntax guide](https://luau.org/syntax/) is a useful language reference, but it may describe features newer than the demo's bundled version. Roblox APIs such as `game:GetService`, `Instance.new` and `task.wait` are not established U2U APIs.

```lua
local enabled = true
local count = 0
local settings = { label = "Example", enabled = enabled }

local function increment(amount)
    count += amount
    return count
end

if settings.enabled then
    increment(1)
end
```

Keep state in local variables captured by callbacks. The editor shim explicitly says the global table becomes readonly after sandboxing; registration therefore happens during bootstrap. Avoid creating globals inside hooks.

Use dot calls for the recovered host functions, as the shim does:

```lua
ctx.editor.log("Hello")
```

A colon call inserts an extra first argument. Do not change it to `ctx.editor:log("Hello")` unless a future official signature requires a receiver.

Use `nil` for absence and `false` for a boolean false value. An omitted table field is not the same as a serialized JSON null. Luau arrays conventionally start at 1; map coordinates have separate rules. The editor diagnostics explicitly use map coordinates starting at 0.

The upstream [sandbox documentation](https://luau.org/sandbox/) removes unrestricted file/process facilities and native package loading. U2U also has a sandbox step and execution/memory budget fields. The precise exposed library set, module-loading support and budget values in each U2U host were not recovered. Do not assume filesystem access, HTTP access, `require`, C# reflection, Unity objects or npm packages are available.

## Game plugins: files and installation

The catalog constants establish `luau`, `plugins`, `plugins.json`, `.luau` and `.locale.json`. Diagnostics explicitly name `luau/plugins`.

Expected layout (**reconstructed**):

```text
MyProject/
  game.rmu2uproject
  data/
  luau/
    plugins/
      Example.luau
      Example.locale.json
    plugins.json
```

The placement of `plugins.json` next to `plugins/` is inferred from the `ResolvePluginsJsonPath`/`ResolvePluginsRoot` catalog design and directory constants; its exact path should be confirmed from a project created by a plugin-enabled build. The script directory itself is explicit in diagnostics. A locale file is optional unless your plugin relies on it; its JSON schema remains unknown.

Expected configuration entry (**reconstructed**, not a recovered complete JSON schema):

```json
[
  {
    "name": "Example",
    "status": true,
    "description": "A development example",
    "parameters": {
      "Enabled": "true",
      "Amount": "5"
    }
  }
]
```

`name`, `status`, `description` and `parameters` are recovered keys. A missing name is diagnosed. The entry-array representation, boolean status and string-valued parameter representation are consistent with the configuration/value-codec names but have not been validated by executing this loader. Prefer configuration written by the plugin manager over hand-editing JSON. Whether `name` includes a subdirectory or extension, and how case is treated, must be confirmed in the target build.

Installation workflow for a **plugin-enabled build**:

1. Make a copy of a project and keep the plugin's original installation instructions.
2. Place the U2U `.luau` file under the project's plugin directory, along with any companion locale/assets files in their required locations.
3. Open the plugin manager if the build exposes it. Discover/select the plugin, enable it, configure parameters and apply/save.
4. Restart the game test or use a documented reload control. Merely editing a script does not prove that the VM reloaded it.
5. Confirm that a simple hook runs before adding game-state mutations.

The metadata contains manager controls named Apply, OK, Cancel, status toggles and parameter editors. It does not establish an exact English menu path in this demo. If the manager is unavailable, that is a build limitation; this guide does not propose binary patching to enable it.

## Game plugin annotations

Recovered parser types include `P2dPluginAnnotationParser`, `P2dPluginParamDef`, `P2dPluginCommandDef` and `P2dPluginStructDef`. Parser method names include `ParseMainBody`, `ParseStructBody`, `ApplyParamTag`, `ApplyCommandTag`, locale ranking and a JSDoc-gutter stripper. Stored delimiters are `--[[` and `]]`. A diagnostic explicitly shows the struct marker `--[[~struct~Name: ]]`.

### A basic header

**Reconstructed example:** the colon-style main marker and tags below follow the recovered parser vocabulary and familiar RPG Maker conventions. Individual tag dispatch behavior was not decompiled. Treat the header as a candidate to validate, not a certified grammar.

```lua
--[[:
@plugindesc Example development plugin
@author Your Name

@param Enabled
@text Enabled
@type boolean
@default true

@param Amount
@text Amount
@type number
@min 0
@max 100
@default 5

@help
Explain installation, behavior, dependencies and compatible builds here.
]]
```

`plugindesc`, `author`, `param`, `text`, `type`, `default`, `min`, `max`, `decimals`, `desc`, `help`, `command`, `arg`, `option`, `value`, `dir`, `parent`, `base`, `orderAfter`, `orderBefore` and `require` all occur as literals. **Their presence alone does not establish that every item is accepted as an annotation tag**, its case sensitivity, multiplicity or scope. Do not infer a dependency resolution algorithm just from `base` or ordering names.

### Parameter types and serialization

The demo contains UI/value-codec evidence for scalar values, arrays, structures, database record selectors, file selection, multiline strings and Luau text. `multiline_string` and `luau` are stored type-name constants. `TryParseArrayType`, `TryParseStructType`, `EncodeArray`, `EncodeStruct` and `TokenToValueString` are recovered implementation names.

| Candidate type | Evidence and limit |
|---|---|
| `string`, `number`, `boolean` | Literal names and scalar value machinery exist; precise coercion rules unknown |
| `select`, `combo` | Literal names and option UI exist; exact annotation contract unverified |
| `file` | File picker and directory fields exist; path/address rules unverified |
| `actor`, `class`, `skill`, `item`, `weapon`, `armor`, `enemy`, `state`, `switch`, `variable`, `common_event`, `animation`, `tileset` | Matching DB/reference machinery exists; validate accepted spelling per type |
| `multiline_string`, `luau` | Explicit stored type constants; execution of Luau text is not implied |
| `T[]` | Array codec exists; this suffix spelling is a reconstruction |
| `struct<Name>` | The `struct<` literal and struct codec support this form; exact parsing rules unverified |
| Custom type | Resident editor shim accepts a nonempty type name and matches it case-insensitively |

Reconstructed structure header:

```lua
--[[~struct~Reward:
@param Amount
@type number
@default 1
]]
```

Complex parameters may travel as JSON encoded inside strings. Do not assume a saved array or structure is already a Luau table. The recovered runtime provides `ctx.plugin.parameters`, `ctx.plugin.typedParameters` and `ctx.plugin.parseValue`, but their full argument and return contracts were not recovered. Keep raw and typed representations distinct until those contracts are confirmed. Check absent values, false, zero, empty strings and malformed JSON separately.

Locale-aware annotation blocks are suggested by `PreferredLocale`, `LocaleRank`, `IsPreferredLocale` and a stored `ja` constant. Their exact block syntax, locale precedence and fallback rules remain unknown.

## Game plugin lifecycle and hooks

`on` and `off` are recovered names. An embedded self-test registers `on('tick', function(x) ... end)`, establishing the two-argument registration pattern in a test host. The runtime has dispatcher, listener-count and hook-owner machinery. This does **not** establish every production hook's callback signature or whether unknown hook IDs are accepted.

Use the following as a deliberately small **reconstructed smoke test**:

```lua
local updates = 0

on("game.update", function()
    updates += 1
    if updates == 1 then
        print("Example: first game.update received")
    end
end)
```

The callback ignores its arguments and returns no value. This avoids inventing a `deltaTime` field or a payload schema. `print` binding machinery exists, but the output location has not been verified in the demo. See [examples/game/Example.luau](examples/game/Example.luau).

### Initialization timing

Several recovered diagnostics are unusually specific:

- At plugin top level and `game.boot`, game services may not yet be connected.
- Game state reads may return `nil`; writes may be ignored.
- Some operations should wait until `map.loaded` or a plugin command.
- Other diagnostics explicitly recommend the first `game.update` or a plugin command.
- In live play, the first `map.loaded` may not reach Luau. Do not make it your only initialization path.
- `ctx.i18n.setLocale` is not wired at top level/`game.boot` and can return false there.

Keep top-level code focused on local setup and registration. Delay game-state work until a suitable context is active. If you use a first-update guard, remember it is once per plugin VM load, not necessarily once per new game or map. Reset the guard on an appropriate lifecycle event only after confirming that event's semantics.

### Hook families

The complete recovered spelling list is in [API-INDEX.md](API-INDEX.md). Main families include:

| Family | Recovered examples | Contract status |
|---|---|---|
| Game | `game.boot`, `game.start`, `game.update`, `game.canGameOver`, `game.localeChanged` | Names verified; arguments and return rules unknown |
| Map | `map.beforeLoad`, `map.loaded`, `map.canPass`, `map.tileFlags`, `map.regionEnter`, `map.regionLeave` | Names verified; coordinate/payload contracts unknown |
| Events | `event.started`, `event.finished`, `event.parallelTick`, `event.create` | Names verified |
| Scenes | `scene.beforeChange`, `scene.changed` | Names verified |
| Persistence | `save.before`, `save.after`, `load.after` | Names verified; not a proven save-state API |
| Actors/input | `actor.param`, `actor.traitObjects`, `input.map`, `player.moveByInput` | Names verified |
| Text/UI | `text.escape`, `text.convert`, `message.charAdvance`, `picture.click`, `sprite.click` | Names verified |
| Inventory/menu | `inventory.gain`, `menu.commands`, `menu.commandOk` | Names verified |
| Battle | Turn/action hooks, damage/hit/evasion/critical hooks, command-list hooks | Names verified; require battle context where applicable |

The host contains three hook-point kinds: **Notify**, **Filter** and **Gate**. Names alone do not prove which kind applies to a particular hook. A notification may ignore return values; a filter may require a replacement value; a gate may require a boolean. Guessing can silently change game behavior. Do not adapt the smoke-test callback into a damage or passability override without recovering that hook's contract.

Registration order, priority, duplicate handling, `off` arguments, error propagation and filter chaining are unknown for runtime hooks. The editor's error-isolation rules below must not be assumed to apply to game hooks.

## Game plugin APIs and state

The generated API index lists every public `ctx.namespace.method` name found as an exact metadata literal. It is a **name inventory**, not a complete SDK: bindings without such literals may be missed. Methods supplied by an external core script may also be absent.

| Namespace | Intended area indicated by recovered names |
|---|---|
| `ctx.game` | Variables, switches, timers, system flags and script evaluation |
| `ctx.db`, `ctx.meta` | Database records and metadata |
| `ctx.actor`, `ctx.party`, `ctx.inventory` | Actors, party progression, gold, equipment and inventory |
| `ctx.map`, `ctx.event`, `ctx.player` | Map identity, event instances, movement and transfer |
| `ctx.battle`, `ctx.battler`, `ctx.action` | Battle state, actions and battlers |
| `ctx.command` | The active event interpreter, branches, waits and common-event calls |
| `ctx.audio`, `ctx.effect`, `ctx.screen` | Audio, animation, pictures, camera and screen effects |
| `ctx.input` | Input polling and key/button queries |
| `ctx.scene`, `ctx.ui`, `ctx.sprite`, `ctx.text` | Scene navigation, windows, sprites, drawing and text conversion |
| `ctx.plugin`, `ctx.parameter`, `ctx.manifest` | Plugin values/state and core manifest/parameter access |
| `ctx.config`, `ctx.i18n` | User options and localization |

These descriptions summarize names, not independently tested functionality. In particular, `ctx.parameter`/`ctx.manifest` coexist with core-script manifest classes; do not assume they are interchangeable with a game plugin's annotations.

### Three different kinds of state

| State | Evidence | Development rule |
|---|---|---|
| Local runtime state | Luau closures; VM load/reload machinery | Useful for caches and counters; do not expect save persistence |
| User configuration | `ctx.config.get/set/registerOption` | Register options before use; do not use options as save-slot progression |
| Save-bound plugin state | `ctx.plugin.getState/setState`; diagnostic mentions `u2uPluginState` | Use the documented mechanism when available; getter/setter signatures and automatic persistence timing are not recovered |

`u2uPluginState` is mentioned in an error message. Its presence is not proof of an independently callable global API. Do not invent calls to it.

Recovered plugin-state diagnostics reject empty state names, JSON null, NaN/infinity, and buffer/non-UTF-8 string representations associated with the reserved key `$u2u`. The metadata contains JSON serialization machinery. A conservative design is plain string keys, finite numbers, booleans, UTF-8 strings, dense arrays and plain nested objects, with a schema version field. Whether arbitrary Luau tables are accepted directly, or JSON text must be supplied, is unknown. Functions, threads, cycles and engine objects should not be assumed serializable.

When reading old state, validate its shape and supply defaults. Put migration logic behind a version field. Test save/load in a fresh process; a local table surviving a scene switch is not proof that it was saved.

### Configuration and localization

Recovered configuration diagnostics establish:

- Unknown option keys are rejected unless registered first.
- Duplicate registration keeps the first option.
- Some options are boolean, integer percentages `0..100`, or selected IDs.
- A definition default must be boolean, number or string.
- Some definitions use `options` entries shaped like `{ id, label }`.
- `labelKey` is ignored when registered outside plugin top level because the host cannot determine the owning translation table.

These rules do not establish the complete `registerOption` table shape, required fields or its argument count.

For localization, an explicit diagnostic requires obtaining a plugin-bound table at top level:

```lua
local L = ctx.i18n.table()
```

Retain `L` in closures. Calling `ctx.i18n.table()` inside a hook is explicitly rejected. `L.t(key, { name = value })` appears in a diagnostic, and `has` is a recovered helper. The sidecar file schema, missing-key behavior, placeholder rules and locale fallback order remain unknown. Do not fabricate a `.locale.json` file based on unrelated RPG Maker versions.

### UI and drawing

Recovered names cover custom scenes/windows, list activation, gauges, text, rectangles, sprites, tweening and sprite sheets. Explicit validators establish some accepted values:

- A UI definition's scene can be `title`, `map`, `menu`, `battle`, `gameover`, `shop` or `plugin:<id>`.
- A parent can be `screen`, `picture` or `character`.
- A background can be `window`, `dim` or `none`.
- A blend string can be `normal`, `add`, `multiply` or `screen`.
- Text style alignment can be `left`, `center`, `right`, or numeric `0`, `1`, `2` in some call paths.
- Text style font size is validated within `0..512`, outline within `-1..64`, and maximum width as nonnegative.
- Sprite-sheet options include a nonempty `sheet`, positive integer `frameW`/`frameH`, and integer `frames`.

Those validation strings are shared metadata and are not mapped to every consuming call. They do not constitute complete `createWindow`, `sprite.create`, `sprite.drawText` or `registerScene` signatures. No working custom-menu template can be certified from this evidence alone.

### Context restrictions

Methods can exist but return empty defaults or do nothing when their subsystem is absent. The index preserves diagnostics such as `no active battle`, `no active event`, `no map loaded`, `player runtime not bound` and `inventory state not integrated`.

Do not call event-interpreter controls from a generic update hook just because `ctx.command` exists. Do not use battle actions before a battle starts. Several host calls also reject non-main-thread access. A manually created coroutine is not a way around host execution-context checks.

## Game plugin commands

The demo clearly contains **command definition and command-editing support**:

- `P2dPluginCommandDef`, command/argument annotations and defaults.
- Event command fields named plugin name, command name, command text and arguments.
- An event-command editor that looks up enabled plugins and command definitions.

Candidate annotation (**reconstructed and untested**):

```lua
--[[:
@plugindesc Command metadata example
@command GiveReward
@text Give reward
@arg Amount
@type number
@default 5
]]
```

**The public handler-registration API was not recovered.** No literal named `registerCommand` or `onCommand` was found. That does not prove such helpers are absent: an external core script could define them. Do not paste `PluginManager.registerCommand` from MZ or invent `ctx.plugin.registerCommand`.

The annotation example above describes candidate editor metadata only. It does not make `GiveReward` executable. Before implementing commands, obtain the target build's core scripts or official command-registration example and confirm:

1. The registration function and required plugin/command identifiers.
2. Whether argument values arrive as strings or typed values.
3. The event context available during the call.
4. Whether callbacks may yield, reserve a wait, or call common events.
5. How errors affect the calling event and how duplicate registrations behave.

This is the principal missing contract preventing a fully executable game-command tutorial from this demo alone.

## Editor plugins: files and manifests

Recovered directory constants are `luau`, `editorPlugins` and `manifest.json`. Discovery distinguishes DLC/group folders from plugin folders and detects duplicate IDs. A diagnostic explicitly requests this layout:

```text
MyProject/
  luau/
    editorPlugins/
      MyTools/
        SelectionInspector/
          manifest.json
          main.luau
```

`U2U/EditorPlugins` is also stored as a **bundled source path** used by an installer. It should not be confused with the project destination. No populated bundled plugin directory was found in this installation.

Reconstructed manifest:

```json
{
  "id": "example.selection-inspector",
  "name": "Selection Inspector",
  "version": "0.1.0",
  "main": "main.luau",
  "author": "Your Name",
  "description": "Reports the current map selection.",
  "resident": false
}
```

| Field | Recovered meaning and limits |
|---|---|
| `id` | Discovery checks duplicate plugin IDs. Exact allowed characters, case rules and requiredness are unknown. Use a stable namespaced ID. |
| `name` | Display-name machinery exists, including a raw name. Localization/fallback behavior is unknown. |
| `version` | Used by bundled-install version checks. Semantic-version comparison rules are unknown. |
| `main` | Script path. An explicit validator requires resolution inside the plugin folder. Empty/missing script paths are errors. |
| `author`, `description` | Recovered manifest properties; optionality not established. |
| `resident` | Resident/nonresident classification exists. Exact default if omitted is unknown; examples specify it explicitly. |

Field names are supported by manifest properties and DTO identifiers, but the full parser was not decompiled. All example manifests supply every recovered field to reduce ambiguity. Keep `main` simple and relative; do not use `../` to escape the plugin folder.

### Command versus resident plugins

The runner and diagnostics establish a nonresident command path. It can reject execution during live play, while another plugin runs, with no active map/editor host, after a project switch, or when the runner is not connected in that build.

The resident host loads plugins, tracks registrations, sends hooks and hosts parameter editors. Its lifecycle includes reload, shutdown, cancellation and rebuilding a poisoned VM. Exact menu labels and the controls that request reload were not recovered. Restarting the relevant editor session is a safer manual test than assuming hot reload.

## Editor plugin walkthrough

The [Selection Inspector example](examples/editor/SelectionInspector/main.luau) uses only recovered no-argument read methods plus the exact `log(string)` pattern visible in the shim. Its manifest is a reconstructed nonresident manifest.

```lua
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
```

The script deliberately tolerates an unexpected return shape. `id` and `type` are supported by selection/list-parts diagnostics; the rest of the payload is not assumed. A command may be rejected before its main script is reached if no project/map is active.

In a plugin-enabled build:

1. Copy the example folder beneath `luau/editorPlugins/MyTools/` in a disposable project.
2. Reopen/rescan the project using the supported editor-plugin control, if present.
3. Open a map, select a part and invoke the discovered tool.
4. Inspect the editor log for the output.
5. Repeat with no selection and after changing maps.

A missing tool in this demo is not evidence of a Luau syntax error. The discovery menu or runner may be unavailable.

## Editor hooks

The following contract is **recovered implementation** from embedded shim L65:

```lua
onEditor(hookId, handler)
```

`hookId` must be a string and `handler` a function. The shim accepts exactly these hook IDs:

| Hook | Meaning indicated by name | Important limit |
|---|---|---|
| `project.opened` | A project has opened | Payload fields beyond `hook` are not established |
| `project.closed` | A project has closed | Do not assume an active map is available |
| `map.opened` | A map has opened | Payload schema not established |
| `liveplay.before` | Before live play | Map-dependent API access may be suppressed by the host |
| `liveplay.after` | After live play | Refresh stale editor handles before reuse |

Only `payload.hook` is directly verified in the shim. Host-side field writers exist, but full hook payloads were not reconstructed. Do not invent `payload.projectPath`, `payload.mapId` or other fields.

```lua
onEditor("map.opened", function(payload)
    ctx.editor.log("Received " .. tostring(payload.hook))
end)
```

Unknown hook IDs are ignored and warned once per ID. Multiple handlers are stored in insertion order and invoked in that order by this shim. Each is called through `pcall`; one failure is reported without stopping subsequent handlers. Callback return values are ignored. There is no public editor unregistration helper in the recovered shim.

Registrations are stamped with the currently loading plugin ID. If a plugin fails during loading, rollback removes its hook handlers and custom parameter-editor registrations. This does not prove that arbitrary changes to maps or external state are rolled back.

Use a resident manifest for tools that register hooks. Do not register hooks on every event: doing so can accumulate handlers. Register once while the plugin loads.

## Custom parameter editors and picking

This is the most fully recoverable extension point in the demo. The embedded shim installs:

```lua
ctx.editor.registerParamEditor({
    type = "YourType",
    open = function(request) ... end,
    render = function(value) ... end,
    validate = function(value) ... end,
})
```

### Registration contract

| Member | Required? | Recovered behavior |
|---|---|---|
| `type` | Yes | Nonempty string; stored and looked up in lowercase |
| `open` | Yes | Function, invoked in a host-managed coroutine with the request |
| `render` | No | Function; gets the value and may return a display string |
| `validate` | No | Function; returns truthy for valid, or false/nil plus an optional message |

Duplicate type registrations warn and the later registration wins. This differs from configuration options, where the first registration wins. Namespace custom type names to avoid collisions.

The shim looks up the type at `request.def.type`. Other request fields may be supplied by the C# host, but this guide does not establish their names or types.

### Open and return values

`open(request)` runs inside the shim's coroutine. When it completes:

- A **string** return is the candidate replacement value.
- `nil` or any nonstring return gives no replacement value; without a pending pick this is treated as cancellation by the host.
- An error is caught and converted to a message.

Returning a table, even one containing valid coordinates, will not commit a value through this shim. Serialize to a string appropriate for your custom parameter. Empty string is still a string; use `nil` to cancel.

`render(value)` is called under `pcall`. Only a string return is accepted; errors and nonstrings produce no custom display string. `validate(value)` is also protected. A truthy first result passes; otherwise the second result supplies an error message if it is a nonempty string. A thrown error causes validation failure.

The precise timing of host validation, default rendering, committing and undo is outside the shim and remains unverified.

### Map picking

The shim exposes:

```lua
ctx.editor.pick.position(opts)
ctx.editor.pick.event(opts)
ctx.editor.pick.region(opts)
```

These helpers are allowed **only inside the active, host-managed `open` coroutine**. Calling one from a normal editor hook, at top level, or from a coroutine you create yourself throws an error.

The helper requests the host's pick UI and yields. The host later resumes the same coroutine with a result. Do not spin-wait, call `coroutine.resume` yourself or run another UI loop. The supported `opts` fields, result shape and cancel sentinel were not recovered. Native completion methods mention positions, event IDs/event UIDs and regions; they do not by themselves establish Luau field names.

Conceptual flow:

```text
parameter UI opens
  -> host starts open(request)
  -> open calls ctx.editor.pick.position(opts)
  -> shim yields; host starts map picking
  -> host resumes open with its result
  -> open returns a serialized string, or nil to cancel
  -> host handles the candidate value
```

The host has a diagnostic for a second parameter editor opening while another is awaiting a pick. Shutdown/cleanup can cancel a suspended coroutine. Stale resume tokens fail without resurrecting a completed session. Keep parameter-editor work short and handle cancellation gracefully.

### A useful starter without guessed pick fields

[Map Target Editor](examples/editor/MapTargetEditor/main.luau) registers a custom type, validates a `map:x:y` string and returns no replacement from `open`. It is an intentional **cancel-only scaffold** until the picker result contract is confirmed. Its comments show where to add picking later. It tests registration/render/validation without guessing result fields.

A proposed runtime annotation that consumes it would use `@type ExampleMapTarget`. The custom registration accepts that name; whether the annotation parser passes an unknown type through to the resident editor requires integration testing in a plugin-enabled build.

## Editor map APIs, IDs and undo

Exact recovered names appear in the API index. This table explains the supporting evidence without supplying invented signatures:

| API | Evidence-based role | Contract status |
|---|---|---|
| `getCurrentMap` | Query the active map | Name and host payload writers recovered; full return table unknown |
| `listMaps` | List maps with stable map UIDs | Diagnostics identify `.id` as an integer map UID; some entries may have nil ID |
| `getMapInfo`, `openMap` | Query/open by map UID | Integer map-UID diagnostics recovered; exact argument packaging unknown |
| `listPresets` | List placeable presets | Canonical IDs use `category/name` |
| `listParts`, `getSelection` | Inspect placed parts and selection | Returned `.id` is an `iid` session ID; `.type` can identify a set part |
| `placePart`, `placeParts` | Place preset instances | Preset/parent validation and batch machinery recovered; full request schemas unknown |
| `removePart` | Remove placed parts | Part ID diagnostics exist; argument packaging unknown |
| `paintGround`, `paintGroundCells`, `paintGroundRect` | Paint terrain | Map bounds, cell batches, layers and tileset identifiers appear in validation/binding machinery |
| `setPartFlags` | Change part flags | Explicit table-call example recovered |
| `setPartSubTileOffset` | Change sub-tile placement | Requires IDs to belong to an open undo group when grouped |
| `beginUndoGroup`, `endUndoGroup` | Group edits for undo | Explicit begin-call example and non-reentrancy checks recovered |
| `checkLuau` | Check Luau text | Name only; input/return contract unknown |
| `log` | Write an editor message | The shim demonstrates a single string argument |

### Do not mix identifier types

| Identifier | What the evidence says | Rule |
|---|---|---|
| Editor map `.id` | Integer **map UID**, from `listMaps` | Do not substitute a filename number such as `001` |
| Part `.id` | `iid:...` session identity from `listParts`, `getSelection` or placement results | Re-query after opening/changing maps or rebuilding the editor session |
| Preset canonical ID | `category/name`, from `listPresets` | Do not substitute a part instance ID |
| Set/group part ID | A selected/listed part with type `P2dSetPartModel` | Only use as a parent where that API allows it |
| Runtime event/map identity | Separate UID/GUID/resolver machinery | Do not assume an editor part ID is a runtime event ID |

Parts can be nested. The metadata contains ancestor traversal and effective-view-state composition. Some placement diagnostics reject a nested parent or a parent that is not a set/group part. Do not assume every selected part is an acceptable parent.

### Bounds and placement restrictions

Recovered validators require nonnegative coordinates and coordinates inside the map, with 0-based bounds. A separate validator restricts `z` to `-1..999`; its exact consuming API was not mapped. `placePart` and batch `placeParts` explicitly reject nonzero rotation in the SV2 path. That is a build/path restriction, not a claim that the entire engine has no rotation support.

Batch counts are capped: `kMaxPlacePartsCount` and `kMaxPaintCellsCount` exist. The numerical values were not recovered. Do not invent a limit; start with small batches and handle reported failures. Atomicity of a multi-step map edit is unknown.

### Undo

The following call shape appears literally in diagnostics:

```lua
ctx.editor.beginUndoGroup({ "iid:...", "iid:...", label = "My edit" })
```

An empty array of part IDs is rejected. Groups cannot be nested/reentered. Ending a group without one open is rejected. During a grouped sub-tile-offset change, a target ID outside the group is rejected.

Another explicit diagnostic demonstrates:

```lua
ctx.editor.setPartFlags({ "iid:...", "iid:...", swingByWind = true })
```

The IDs above are placeholders, not runnable IDs. Do not paste them into an active project. Fetch current IDs first. Other supported flag names and their behavior require confirmation.

If the target build confirms that `endUndoGroup()` takes no arguments, use a protected cleanup pattern: open the group, perform the edit under `pcall`, close the group even after failure, then report the error. The no-argument end signature is plausible from the name but is not directly established by a call in the recovered source, so no executable mutation example is supplied here.

The binding contains `CleanupDanglingUndoGroup` and `RequireNoOpenUndoGroup`. This supports cleanup and restrictions, **not transaction rollback**. Closing a group does not necessarily reverse edits already made. Read/query APIs and map switching may also be restricted while a group is open. Test undo and redo explicitly on a disposable project.

## Errors and troubleshooting

### Structured editor errors

The editor has five stored error-kind strings:

| Kind | Practical interpretation |
|---|---|
| `invalid_params` | An argument or request field is invalid |
| `out_of_range` | A value, coordinate or count is outside accepted bounds |
| `not_found` | A referenced map, part or preset cannot be resolved |
| `precondition_failed` | The current editor/project/map/undo state does not allow the call |
| `internal` | Host-side failure |

The shim's error formatter explicitly accepts table errors, preferring `.message`, then `.kind`; it also handles ordinary strings. A `.hint` property exists in the host exception machinery, but its exact Lua exposure is not proven. Do not assume `tostring(errorTable)` contains a useful message.

```lua
local function errorText(err)
    if type(err) == "table" then
        return tostring(err.message or err.kind or "Editor API error")
    end
    return tostring(err)
end
```

### Common problems

| Symptom or diagnostic | What to check |
|---|---|
| No plugin controls/tools appear | Demo/build availability first, then discovery layout and manifest |
| Main script missing | `main` spelling, relative path and file existence |
| Main must resolve inside plugin folder | Remove path traversal and put the script inside its own folder |
| Duplicate plugin ID | Give each editor plugin a unique, stable manifest ID |
| No active map/editor host | Open the intended project/map; runner may be unavailable in this build |
| Cannot run during live play | Stop live play before invoking a nonresident editor command |
| Another plugin is running | Let it finish; avoid parallel command execution |
| Read returns nil/empty or writes do nothing at boot | Move work to a supported later game context |
| No active event/battle | Use the appropriate event or battle context |
| Unknown editor hook is ignored | Use one of the five exact supported IDs |
| Picker says it must be inside `open` | Call it only in the host-started parameter-editor coroutine |
| Picker editor returns no change | Return a string; a table or number is not accepted by the shim |
| Another parameter editor awaits a pick | Complete or cancel it before opening another |
| Part/map not found after map change | Re-query IDs; distinguish map UID, instance ID and preset ID |
| Rotation rejected | Use zero in the SV2 placement path |
| Undo group already open/no group open | Pair begin/end and avoid nesting |
| Localization table rejected in callback | Obtain `local L = ctx.i18n.table()` at plugin top level |
| Configuration key is unknown | Register it first; use the proper save-state mechanism for progression |
| State serialization rejects null/NaN/buffer | Normalize values and validate your state schema |

Metadata includes print/warning/error bindings, editor logging and player log prefixes. The exact output window and disk-log location were not established. Avoid inventing an engine-specific log path. Use the host's documented log UI when available.

## Testing and distribution

### Before writing a feature

1. Record the editor build and plugin API/core-script version if exposed.
2. Verify that a plugin-enabled build can discover and execute the smallest example.
3. Keep a disposable project with a small map and known data records.
4. Capture logs and the precise call that fails.
5. Confirm function signatures before adding persistent changes.

### Game plugin checks

- Enable/disable the plugin and confirm that behavior follows the manager state.
- Test cold boot, new game, transfer, scene transitions and return to title.
- Test live play and exported player separately; they can have different host wiring.
- Test save/load after restarting the process, plus an older save schema.
- Test missing/invalid parameters, false/zero values and unavailable database records.
- For hooks, test the specific notify/filter/gate contract and interaction with a second plugin.
- For battle/event APIs, verify behavior with and without the required active context.
- Log once or on meaningful changes; avoid per-frame log spam.

### Editor plugin checks

- Test project open/close, map switch, empty selection and nested/group parts.
- Test a missing/duplicate manifest ID and a missing main file.
- Check resident reload for duplicated hooks and stale part IDs.
- Test parameter validation, display, string return, cancellation and project close during a pick.
- Check undo and redo for every mutation tool, including an error halfway through.
- Test live-play entry/exit and restrictions on nonresident commands.
- Preserve a project copy before batch terrain/part changes.

### Packaging

Ship scripts, manifests, needed assets, a README, a plugin license, compatible build/API versions, installation paths, parameter/command descriptions and any migration notes. Separate game and editor components clearly. Document whether the editor companion is required to edit settings or only improves authoring.

Use a unique namespace for editor manifest IDs, custom parameter types, game state keys, scene IDs and configuration keys. Keep display names editable without changing stable identifiers. Do not redistribute this demo's native DLLs or an extracted proprietary bootstrap as part of your plugin.

The examples in this guide use the [MIT license](examples/LICENSE). That covers only the newly authored example code, not RPG Maker U2U, its assets or the recovered identifiers. Export/deployment compatibility was not tested.

## Porting MV/MZ plugins

The official producer overview says existing MV/MZ plugins need porting. Their JavaScript APIs do not transfer automatically. Translate behavior and data contracts before translating syntax.

| MV/MZ pattern | U2U direction | Evidence limit |
|---|---|---|
| JavaScript `.js` plugin | Luau `.luau` game plugin | File extension recovered |
| `PluginManager.parameters(...)` | Investigate `ctx.plugin.parameters`/`typedParameters` | Exact signatures unknown |
| `PluginManager.registerCommand(...)` | Obtain U2U's command-registration contract | No equivalent proven here |
| `$gameVariables`/`$gameSwitches` | Investigate `ctx.game` getters/setters | Names recovered, signatures unknown |
| `$gameParty` | Investigate `ctx.party`/`ctx.inventory` | Context and signature checks needed |
| Prototype monkey patching | Use supported hooks and host APIs | Officially a different extension model |
| PIXI/DOM/CSS rendering | Investigate `ctx.ui`, `ctx.sprite`, `ctx.screen` | No direct browser/PIXI contract recovered |
| Editor hacks | A separate editor plugin | Editor host, manifest and lifecycle differ |

Do not assume that JavaScript-to-Luau conversion alone preserves parameter encoding, database indices, map/event IDs, scene timing, save behavior or rendering semantics.

## Missing contracts and next steps

This guide is as complete as the inspected demo supports, but **it cannot be a complete executable SDK**. The following need official definitions, an accessible core-script bundle or native-code analysis followed by runtime validation:

| Missing contract | Why it matters |
|---|---|
| Production runtime hook callback signatures and kinds | Correctly implementing filters/gates and reading payloads |
| Game command-handler registration | Making annotation-defined commands executable |
| Full `ctx` argument/return signatures | Safely calling the recovered name inventory |
| Exact annotation grammar and supported type list | Predictable parameter and command UI |
| Definitive runtime config path/schema | Reliable automatic installation |
| State setter/getter representation and save integration | Persistent plugin data |
| Module loading and library availability | Structuring multi-file plugins |
| Locale sidecar schema/fallback rules | Shipping translated plugins |
| Complete editor request/result tables | Placement, painting, map info and picking |
| Actual budgets, batch limits and reload guarantees | Performance and lifecycle design |
| Export rules and API compatibility policy | Shipping a game with supported plugins |

For the next investigation, obtain the exact build's `CoreScript/manifest.json` and source bundle if the product makes them available. Metadata contains core-bundle loading, project core-copying and version-check machinery, but this installation did not provide a loose source bundle at the inspected paths. Do not create a fictitious core manifest to compensate.

An official SDK or working sample should override a reconstruction in this guide. Preserve the confidence labels when sharing this document so inferred examples do not become mistaken for official contracts.

## Evidence and reproducibility

Local sources:

| Source | Used for |
|---|---|
| `RPGU2U_Demo_Data/il2cpp_data/Metadata/global-metadata.dat` | Version-39 literal table, identifier names, embedded editor shim and diagnostics |
| `GameAssembly.dll` | Presence of the compiled game/editor assembly; no complete native decompilation performed |
| `RPGU2U_Demo_Data/Plugins/x86_64/LuauCAbi.dll` | Presence of the native Luau C ABI runtime |
| `RPGU2U_Demo_Data/StreamingAssets/U2U/BuildInfo/buildinfo.json` | Build date and commit |
| `U2U_editor_licenses.md`, Luau section | Bundled Luau version and license attribution |
| Unity `.assets` files | Checked TextAssets for loose/bundled plugin documentation; no Luau SDK/sample found |

The extractor uses only Python's standard library. It understands this build's v39 offset/size/count header and literal offset array; it explicitly rejects other versions/layouts. Literal indices in this guide are build-specific and are not file line numbers.

```text
python3 tools/extract_reference.py "/path/to/RPGツクールU2U Demo"
```

Run that command from this documentation directory, or supply the script's absolute path. It writes `reference.json`, `evidence.json` and `API-INDEX.md` beside the guide. The installation is read only. `reference.json` records source SHA-256 hashes for comparison after updates. It does not attempt to execute plugins or recover native method bodies.

Notable evidence anchors:

| Anchor | Fact |
|---|---|
| L65 | Complete embedded editor shim: hooks, parameter editors, picker coroutine restrictions and rollback |
| L887–L890 | Top-level/boot host timing warnings and first-live-play-map warning |
| L1462 | Editor `main` must resolve inside its plugin folder |
| L19461 | Explicit `beginUndoGroup` table-call shape |
| L20441 | `ctx.i18n.table()` must be called at plugin top level |
| L22922–L22923 | Explicit `luau/plugins` folder references |
| L24862 | Explicit `setPartFlags` table-call shape |
| L27309 | `<DLC>/<plugin>/manifest.json` editor layout diagnostic |
| L30481 | Explicit structure annotation marker |

External primary references:

- [RPG Maker U2U producer plugin overview, October 2026](https://steamcommunity.com/app/4856440/allnews/) — broad architecture only; the news feed can change.
- [Developer response on demo limitations, 21 October 2026](https://guild.rpgmakerofficial.com/t/topic/3380?tl=en) — availability caveat, not a per-API matrix.
- [Luau language syntax](https://luau.org/syntax/) — language reference; check against bundled 0.723.
- [Luau sandbox design](https://luau.org/sandbox/) — upstream constraints, not a complete U2U host policy.

### Validation performed for this documentation

The local metadata layout and offsets were validated, the API inventory was regenerated, and the example manifests were parsed as JSON. Documentation links and HTML generation were checked. **No example was executed inside U2U, no game export was tested, and no complete Luau type declarations were recovered.**
