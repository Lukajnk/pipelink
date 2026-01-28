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

## Single line installation
```bash
curl -fsSL https://raw.githubusercontent.com/Lukajnk/cight/tags/v1.0.0/install.sh | bash
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

| Flag | Description | Default |
|------|-------------|---------|
| `-n, --name` | Project name | — |
| `-d, --directory` | Project directory | current dir |
| `-b, --branch` | Branch name | active branch |
| `-p, --platform` | Force gitlab/github | auto-detect |
| `-t, --token` | Access token | — |
| `-i, --interval` | Refresh interval (seconds) | 5 |
| `-g, --gitinfo` | Show commit info | false |
| `-e, --emoji` | Emoji mode 🔥 | false |
| `-s, --small` | Compact single-line | false |
| `-c, --color` | Colored output | true |
| `-T, --table` | Table display | true |
| `-o, --once` | Show once, don't monitor | false |
| `-N, --notify` | Desktop notification | false |
| `-O, --open` | Open browser when done | false |
| `-C, --clear` | Clear screen on start | false |

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

1. Go to GitLab → Settings → Access Tokens
2. Create token with `read_api` scope
3. Copy the `glpat-...` token

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

## Screenshots

![Demo](https://raw.githubusercontent.com/Lukajnk/cight/main/media/picture_1.png)
