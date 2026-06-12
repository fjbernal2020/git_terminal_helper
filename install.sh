#!/bin/bash
# install.sh simplificado

SCRIPT_NAME="git_helper.py"
INSTALL_PATH="/usr/local/bin/g"

# Instalar dependencias
pip3 install --user rich prompt_toolkit

# Copiar el ejecutable
if [ -f "$SCRIPT_NAME" ]; then
    sudo cp "$SCRIPT_NAME" "$INSTALL_PATH"
    sudo chmod +x "$INSTALL_PATH"
    echo "✅ Script installed as 'g'. Configs will be at ~/.config/git-terminal-helper/"
else
    echo "❌ Error: $SCRIPT_NAME not found."
    exit 1
fi
