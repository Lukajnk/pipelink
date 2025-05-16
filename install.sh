#!/usr/bin/env bash

set -e

script_url="https://gitlab.com/lukajnk/pipelink/-/raw/main/pipelink"

user_home="$(eval echo ~${SUDO_USER:-$USER})"

# root install
script_dir="/usr/local/bin"

# user install
if [[ "$1" == "--user" ]]; then
	script_dir="$user_home/bin"
fi

echo "Installing pipelink to '$script_dir'..."

# make '~/bin' folder
mkdir -p "$script_dir"

# curl 'pipelink' to '~/bin/pipelink'
if ! curl -fssl "$script_url" -o "$script_dir/pipelink"; then
	echo "Failed to download script."
	exit 1
fi

# make '~/bin/pipelink' executable
chmod +x "$script_dir/pipelink"

# ensure '~/bin' is in $PATH
if ! echo "$PATH" | grep -q "$user_home/bin"; then

	if [[ -n "$ZSH_VERSION" ]]; then
		shellrc="$user_home/.zshrc"
	else
		shellrc="$user_home/.bashrc"
	fi

	# add export PATH to shellrc if not already in shellrc
	if ! grep -Fxq 'export PATH="$PATH:$HOME/bin"' "$shellrc"; then
		echo 'export PATH="$PATH:$HOME/bin"' >> "$shellrc"
		echo "Added '$user_home/bin' to PATH in $shellrc. Restart your shell or run 'source $shellrc'"
	fi
fi

echo "Pipelink installed to '$script_dir/pipelink', run 'pipelink --help' to get started"
