#!/usr/bin/env bash

script_url="https://raw.githubusercontent.com/Lukajnk/cight/v1.0.0/cight"

# Check for curl
command -v curl >/dev/null || { echo "Error: curl is required" ; exit 1; }

# Sudo install
if [[ -n "$SUDO_USER" ]]; then
	install_directory="/usr/local/bin"
	user_home="$(eval echo ~"$SUDO_USER")"
	config_directory="$user_home/.config/cight"
	[[ -d "$install_directory" ]] || { echo "Error: Directory '$install_directory' missing" ; exit 1; }
	echo "Cight will be installed in '$install_directory' and usable by all users"
	echo "To install for current user only, run script without sudo"
	read -r -p "Continue install? [y/N]: " user_choice < /dev/tty
	case "$user_choice" in
		[Yy][Ee][Ss]|[Yy]) ;;
		*) echo "Aborting installation" ; exit 1 ;;
	esac

# User install
else
	install_directory="$HOME/bin"
	config_directory="$HOME/.config/cight"
	echo "Cight will be installed in '$install_directory' and usable by current user only"
	echo "To install for all users, run script with sudo"
	read -r -p "Continue install? [y/N]: " user_choice < /dev/tty
	case "$user_choice" in
		[Yy][Ee][Ss]|[Yy]) ;;
		*) echo "Aborting installation" ; exit 1 ;;
	esac
	mkdir -p "$install_directory" || { echo "Error: Failed to create directory '$install_directory'" ; exit 1; }
fi

config_file="$config_directory/config"
projects_file="$config_directory/projects"
cight_path="$install_directory/cight"

echo "Creating config files at '$config_directory'"
mkdir -p "$config_directory" || echo "Warning: Failed to create config directory '$config_directory'"

if [[ -d "$config_directory" ]]; then
	chmod 700 "$config_directory" || echo "Warning: Failed to set permissions on '$config_directory'"
	touch "$config_file" || echo "Warning: Failed to create config file '$config_file'"
	touch "$projects_file" || echo "Warning: Failed to create projects file '$projects_file'"
	chmod 600 "$config_file" || echo "Warning: Failed to set permissions on '$config_file'"
	chmod 600 "$projects_file" || echo "Warning: Failed to set permissions on '$projects_file'"
	if [[ -n "$SUDO_USER" ]]; then
		chown -R "$SUDO_USER:$(id -gn "$SUDO_USER")" "$config_directory" || echo "Warning: Failed to set ownership on '$config_directory'"
	fi
fi

echo "Installing cight to '$install_directory'"
curl -fsSL "$script_url" -o "$cight_path" || { echo "Error: Failed to download script" ; exit 1; }
chmod +x "$cight_path" || echo "Warning: Failed to make '$cight_path' executable"

if [[ ! ":$PATH:" == *":$install_directory:"* ]]; then
	echo ""
	echo "Warning: '$install_directory' is not in your \$PATH"
	echo "Add it to your shell config or move cight to a directory in your \$PATH"
fi

echo ""
echo "Cight successfully installed to '$cight_path'"
echo "Run 'cight help' to get started"
