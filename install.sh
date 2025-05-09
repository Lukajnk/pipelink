#!/usr/bin/env bash

set -e

SCRIPT_URL="https://gitlab.com/lukajnk/pipelink/-/raw/main/pipelink"
SCRIPT_NAME="pipelink"

function install_user() {
    USER_BIN="$HOME/bin"
    mkdir -p "$USER_BIN"
    echo "🔧 Installing pipelink to $USER_BIN/$SCRIPT_NAME..."

    curl -fsSL "$SCRIPT_URL" -o "$USER_BIN/$SCRIPT_NAME"
    chmod +x "$USER_BIN/$SCRIPT_NAME"

    # Ensure $HOME/bin is in PATH
    if ! echo "$PATH" | grep -q "$USER_BIN"; then
        shell_rc="$HOME/.bashrc"
        [[ -n "$ZSH_VERSION" ]] && shell_rc="$HOME/.zshrc"

        echo 'export PATH="$HOME/bin:$PATH"' >> "$shell_rc"
        echo "📌 Added $USER_BIN to PATH in $shell_rc. Restart your shell or run: source $shell_rc"
    fi

    echo "✅ pipelink installed to $USER_BIN/$SCRIPT_NAME"
}

function install_system() {
    SYSTEM_BIN="/usr/.local/bin"

    echo "🔧 Installing pipelink to $SYSTEM_BIN/$SCRIPT_NAME..."

    if ! mkdir -p "$SYSTEM_BIN" 2>/dev/null; then
        echo "⚠️  No write access to $SYSTEM_BIN. Falling back to user install..."
        install_user
        return
    fi

    if ! curl -fsSL "$SCRIPT_URL" -o "$SYSTEM_BIN/$SCRIPT_NAME"; then
        echo "❌ Failed to download script."
        exit 1
    fi

    chmod +x "$SYSTEM_BIN/$SCRIPT_NAME"
    echo "✅ pipelink installed to $SYSTEM_BIN/$SCRIPT_NAME"
}

if [[ "$1" == "--user" ]]; then
    install_user
else
    install_system
fi

echo "👉 Run 'pipelink --help' to get started."