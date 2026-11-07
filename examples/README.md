# Example status and installation

All examples are newly authored, reconstructed starters. None has been executed in U2U. 

| Example | What it demonstrates | Unverified parts |
|---|---|---|
| `game/Example.luau` | Local state and a minimal `game.update` hook callback | Production registration/availability, annotation grammar and output location |
| `game/plugins.candidate.json` | Candidate manager configuration | Exact configuration path, schema and name matching |
| `editor/SelectionInspector` | A nonresident command that reads map/selection and logs results | Manifest parsing, runner availability and full query return schemas |
| `editor/MapTargetEditor` | Resident hook/custom type registration, render and validate callbacks | Manifest parsing and integration with runtime parameter annotations |

`MapTargetEditor.open` intentionally cancels. It does not provide a working map picker. The supplied validator checks only the example's own string format, not engine map IDs, map existence or bounds.

For a plugin-enabled build, copy the game script into a disposable project's `luau/plugins/` and use its manager to enable it. Prefer manager-generated configuration over the candidate JSON. Copy editor plugin folders under `luau/editorPlugins/MyTools/`. Confirm these paths with the target build. Restart/rescan using supported controls and inspect logs.

