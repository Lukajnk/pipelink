# Cight

Monitor your CI/CD pipelines from the terminal.

![Demo](https://raw.githubusercontent.com/Lukajnk/cight/main/media/cight_demo.gif)

## Features

- **Real-time job monitoring** - watch pipeline jobs update live in your terminal
- **GitLab & GitHub support** - works with both platforms, auto-detects which one
- **Multiple display modes** - table, compact, emoji, or minimal single-line view
- **Desktop notifications** - get notified when your pipeline finishes
- **Project management** - save projects and switch between them easily
- **Zero config start** - just run `cight` in any git repo with CI/CD

## Installation
```bash
curl -fsSL https://raw.githubusercontent.com/Lukajnk/cight/v1.0.0/install.sh -o cight_install.sh
less cight_install.sh
bash cight_install.sh    
rm cight_install.sh
```

Run with `sudo bash install.sh` for system wide install

### One-liner
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Lukajnk/cight/v1.0.0/install.sh)
```

## Dependencies
- `git`
- `curl`
- `jq`

## Quick Start

```bash
# Run in any git repo with a .gitlab-ci.yml or .github/workflows/
cd your-project

# First run will prompt for your access token
cight
```

## Usage

```
cight [command] [arguments]
```

### Commands

| Command | Description |
|---------|-------------|
| `run` | run a project (default command if project exists in directory) |
| `add` | add a new project (default command if no project in directory) |
| `list` | list all saved projects |
| `open` | open pipeline in browser |
| `edit` | edit file with default editor |
| `help` | show help |

### Arguments

## Project arguments

| Short flag | Long flag | Description |
|------------|-----------|-------------|
| `-d` | `--directory` | specify project directory (leaving empty uses working directory) |
| `-n` | `--name` | specify project name |
| `-p` | `--platform` | specify git platform |
| `-t` | `--token` | specify personal access token |
| `-b` | `--branch` | specify branch in project |

## Display arguments

| Short flag | Long flag | Description | Default value |
|------------|-----------|-------------|---------|
| `-C` | `--clear` | clear screen on start | false |
| `-l` | `--link` | display pipeline URL | false |
| `-g` | `--gitinfo` | show git commit info | false |
| `-m` | `--monitor` | display job monitoring | true |
| `-o` | `--once` | display jobs only once | false |
| `-s` | `--small` | compact emoji mode jobs | false |
| `-e` | `--emoji` | emoji mode 🔥 | false |
| `-O` | `--open` | open pipeline when done | false |
| `-T` | `--table` | show table instead of column | true |
| `-N` | `--notify` | desktop notify when done | false |
| `-c` | `--color` | colored mode | true |
| `-i` | `--interval` | jobs monitor interval | 5 seconds |

### Examples

```bash
# Monitor current directory's pipeline
cight

# Monitor with git info in emoji mode
cight -ge

# Compact mode with desktop notifications
cight -sN

# Monitor a saved project by name
cight myProject

# List all saved projects
cight list
```

## Getting Tokens

### GitLab

1. Go to GitLab → Settings → Access tokens → Add new token
2. Give the token a name, e.g. 'cight_token'
3. Check the `read_api` scope and create token
4. Copy the `glpat-...` token immediately, GitLab will not show it again

### GitHub

1. Go to GitHub → Settings → Developer Settings → Personal Access Tokens → Tokens (classic)
2. Create token with `repo` and `workflow` scopes
3. Copy the `ghp_...` token

## Config Files

| File | Purpose |
|------|---------|
| `~/.config/cight/projects` | Saved projects |
| `~/.config/cight/config` | Global defaults |
| `.cight_config` | Per-project config (in repo root) |

Edit with:
```bash
cight edit projects      # saved projects
cight edit globalconfig  # global defaults
cight edit config        # project config
```
