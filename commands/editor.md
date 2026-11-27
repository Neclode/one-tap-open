---
description: Choose which editor one-tap-open uses for code files
---

Help the user pick the editor that one-tap-open opens code files in.

1. Take the list of found editors from the "This machine" part of the one-tap-open context. If it isn't there, check which of these are on PATH: code, cursor, windsurf, zed, subl, idea.
2. Ask the user which one to use, offering the found editors as choices (plus "none: use the OS default").
3. Write their answer with your file-writing tool to the settings file named in that context (`~/.one-tap-open.json`, as an absolute path) as `{"editor": "<name>"}`. For "none", delete that file instead.
4. Confirm in one line. It applies from now on in this session and in new ones.
