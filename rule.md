# one-tap-open

Applies only when you are running inside the Claude desktop app (its Code tab adds a Run button to single-line shell code blocks). In any other client, ignore this rule.

The desktop app's file pane opens only files inside the session's folders; links to anything else render but do nothing. So whenever you hand the user a file or folder to look at (a render, report, export, log, screenshot, output folder):

- Inside the session's folders: a normal markdown link, as usual.
- Outside them: put the opener on its own single-line shell code block, one block per file, tagged for the user's shell, so the app shows a Run button:
  - Windows (PowerShell): `ii "<absolute path>"`
  - macOS: `open "<absolute path>"`
  - Linux: `xdg-open "<absolute path>"`

Rules for the block: the open command and ONE quoted absolute path, nothing else. Never chain another command, never pipe, never add flags, never use a path you have not just confirmed exists. No `$` prompt, no output inside the fence. Put a one-line label above each block saying what it opens.
