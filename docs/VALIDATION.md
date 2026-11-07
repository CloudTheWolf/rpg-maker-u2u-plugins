# Documentation validation

Checked 7 November 2026 against local demo build 2952782.

- Version-39 metadata offset table, count, monotonic offsets and terminal size validated.
- Regenerated 329 unique public ctx API names in 27 groups and 50 runtime hook names.
- Verified recorded SHA-256 hashes against the five local source files.
- Parsed every JSON file, including both editor manifests and the candidate game configuration.
- Parsed both Python tools as Python syntax.
- Checked local Markdown links, HTML links/anchors, unique HTML IDs and balanced code fences.
- Built the offline HTML edition without external scripts or stylesheets.

No Luau compiler/type-check pass was performed. No plugin was executed in U2U, no picker/undo integration was exercised, no export was tested, and the HTML was not visually inspected in a browser. The example game configuration and editor manifests are reconstructed formats, not runtime-validated schemas.
