#!/bin/bash

echo "🌟 Installing zsh4humans (no exec)…"

# disable exiting script on error
set +e

# temporarily override exit and exec so they don’t kill bootstrap
exit() { return "$1"; }
exec() { echo "⚠️  blocked exec: $*"; }

if command -v curl >/dev/null 2>&1; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
else
  sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
fi

echo "✅ zsh4humans installer finished (exec/exit blocked)."
