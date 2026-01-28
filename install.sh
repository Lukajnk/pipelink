#!/usr/bin/env bash

script_url="https://raw.githubusercontent.com/Lukajnk/cight/tags/v1.0.0/cight"

# sudo install
if [[ -n "$SUDO_USER" ]]; then

	install_directory="/usr/local/bin"
	user_home="$(eval echo ~"$SUDO_USER")"
	config_directory="$user_home/.config/cight"

	[[ -d "$install_directory" ]] || { echo "error: directory '$install_directory' missing, exiting" ; exit 1; }

	echo "cight will be installed in '$install_directory' and usable by all users, to install for current user only run script without sudo"
	read -r -p "continue install? [y/N]: " user_choice < /dev/tty
	case "$user_choice" in
		[Yy][Ee][Ss]|[Yy]) ;;
		*) echo "aborting installation" ; exit 1 ;;
	esac

# user install
else

	install_directory="$HOME/bin"
	config_directory="$HOME/.config/cight"

	echo "cight will be installed in '$install_directory' and usable by current user only, to install for all users run script with sudo"

	read -r -p "continue install? [y/N]: " user_choice < /dev/tty

	case "$user_choice" in
		[Yy][Ee][Ss]|[Yy])
			;;
		*)
			echo "aborting installation"
			exit 1
			;;
	esac

	mkdir -p "$install_directory" || { echo "error: failed to make directory '$install_directory', exiting" ; exit 1; }
fi

config_file="$config_directory/config"
projects_file="$config_directory/projects"
cight_path="$install_directory/cight"

echo "creating config files at '$config_directory'"
mkdir -p "$config_directory" || echo "warning: failed to make config directory '$config_directory'"

if [[ -d "$config_directory" ]]; then

	chmod 700 "$config_directory" || echo "warning: failed to set permissions of config directory '$config_directory' to 700"
	touch "$config_file" || echo "warning: failed to make config file '$config_file'"
	touch "$projects_file" || echo "warning: failed to make projects file '$projects_file'"
	chmod 600 "$config_file" || echo "warning: failed to set permissions of config file '$config_file' to 600"
	chmod 600 "$projects_file" || echo "warning: failed to set permissions of projects file '$projects_file' to 600"

	if [[ -n "$SUDO_USER" ]]; then
		chown -R "$SUDO_USER:$(id -gn "$SUDO_USER")" "$config_directory" || echo "warning: failed to change ownership of '$config_directory'"
	fi
fi

echo "installing cight to '$install_directory'"

curl -fsSL "$script_url" -o "$cight_path" || { echo "error: failed to download script, exiting" ; exit 1; }

chmod +x "$cight_path" || echo "warning: failed to make '$cight_path' executable"

if [[ ! ":$PATH:" == *":$install_directory:"* ]]; then
	echo "warning: install directory '$install_directory' not in \$PATH, add directory to \$PATH or move cight to another folder"
fi

echo "cight successfully installed to '$cight_path'"
