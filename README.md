# one-tap-open

If you use Claude Code in the Claude desktop app, you've probably hit this: Claude tells you a file is at `C:\Users\you\Videos\render.mp4`, the path looks like a link, you click it, and nothing happens. The file pane only opens files inside the session's folder, so anything outside it is a dead link. A lot of people have reported it; [#73338](https://github.com/anthropics/claude-code/issues/73338) and [#94446](https://github.com/anthropics/claude-code/issues/94446) are still open, and a pile of others were closed as duplicates.

The desktop app already puts a **Run** button on single-line shell code blocks. This plugin makes Claude use that: when it hands you a file outside the session folder, it gives you a one-line block like

```powershell
ii "C:\Users\you\Videos\render.mp4"
```

You tap Run and the file opens in your default app. On macOS it uses `open`, on Linux `xdg-open`. I've tested it on Windows; if something's off on Mac or Linux, open an issue. Files inside the session folder still get normal links.

## Code files open in your editor

For code and text files, it opens them in your editor at the right line instead, for example `code -g "C:\repo\app.py:42"`. It works with VS Code, Cursor, Windsurf, Zed, Sublime Text and IntelliJ (`idea`), as long as the editor's command-line launcher is installed.

You don't have to set anything up. At session start it checks which of those editors you have. If there's one, it uses that. If there are several, Claude asks you once the first time it opens a code file and remembers your answer in `~/.one-tap-open.json`. To change it later, run `/one-tap-open:editor` or just tell Claude.

## Install

In Claude Code:

```
/plugin marketplace add Neclode/one-tap-open
/plugin install one-tap-open@one-tap-open
```

Start a new session (or `/clear`) and it's active.

## How it works

It's one SessionStart hook that adds a short rule (about 500 tokens) to the session's context, plus one line saying which editor to use. Read [rule.md](rule.md) and the two scripts in [hooks/](hooks); that's the whole plugin. It only applies in the desktop app, since the terminal CLI and the web don't have a Run button.

## Safety

You're tapping Run on a command Claude wrote, so the rule is strict: the open command plus one quoted absolute path, nothing chained, no pipes, and no flags except the editor's own go-to-line flag. Still, glance at the block before you tap it, same as any command.

## When to uninstall

Once the desktop app opens out-of-folder links itself, you don't need this anymore:

```
/plugin uninstall one-tap-open@one-tap-open
```

MIT licensed.
