# Prints the one-tap-open rule plus this machine's editor state into the session context.
$root = if ($env:CLAUDE_PLUGIN_ROOT) { $env:CLAUDE_PLUGIN_ROOT } else { Split-Path $PSScriptRoot }
$cfg = Join-Path $HOME ".one-tap-open.json"

Get-Content -Raw (Join-Path $root "rule.md")

$pick = ""
if (Test-Path $cfg) {
    try { $pick = [string](Get-Content -Raw $cfg | ConvertFrom-Json).editor } catch { $pick = "" }
}

$found = @("code", "cursor", "windsurf", "zed", "subl", "idea") |
    Where-Object { Get-Command $_ -ErrorAction SilentlyContinue }

""
"## This machine"
"Settings file: $cfg"
if ($pick -and (Get-Command $pick -ErrorAction SilentlyContinue)) {
    "Chosen editor: $pick"
} elseif (-not $found) {
    "No editor found: open code files with the OS opener like any other file."
} elseif (@($found).Count -eq 1) {
    "Chosen editor: $found (the only one installed)"
} else {
    "Several editors found: $($found -join ' '). None saved yet: ask once (see rule)."
}
