# Terminal

My zsh config: oh-my-zsh, Powerlevel10k, fzf, eza, bat, zoxide. No shell history or personal paths.

| File | Restore to |
| --- | --- |
| `zshrc` | `~/.zshrc` |
| `zshenv` | `~/.zshenv` |
| `zprofile` | `~/.zprofile` |
| `p10k.zsh` | `~/.p10k.zsh` |

## Install on a new Mac

For an agent: run these in order. Each step is safe to rerun.

```sh
REPO=~/Code/tools/skills

# 1. Homebrew (expected at /opt/homebrew)
command -v brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# 2. Tools zshrc runs at startup, and the prompt's font
brew install git fzf fd eza bat zoxide thefuck jenv
brew install --cask font-meslo-lg-nerd-font

# 3. oh-my-zsh (keep the current zshrc; step 6 replaces it), theme, plugins, fzf-git
[ -d ~/.oh-my-zsh ] || RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
C=~/.oh-my-zsh/custom
[ -d $C/themes/powerlevel10k ] || git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $C/themes/powerlevel10k
[ -d $C/plugins/zsh-autosuggestions ] || git clone https://github.com/zsh-users/zsh-autosuggestions $C/plugins/zsh-autosuggestions
[ -d $C/plugins/zsh-syntax-highlighting ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $C/plugins/zsh-syntax-highlighting
[ -d ~/fzf-git.sh ] || git clone https://github.com/junegunn/fzf-git.sh.git ~/fzf-git.sh

# 4. bat theme
mkdir -p "$(bat --config-dir)/themes"
curl -fsSL -o "$(bat --config-dir)/themes/tokyonight_night.tmTheme" https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme
bat cache --build

# 5. Back up existing config, then copy these files into place
ts=$(date +%s)
for f in zshrc zshenv zprofile p10k.zsh; do
  [ -f ~/.$f ] && cp ~/.$f ~/.$f.bak.$ts
  cp "$REPO/terminal/$f" ~/.$f
done

# 6. Verify: must start without errors
zsh -i -c 'echo ok'
```

Then tell the user to set the terminal font to **MesloLGS Nerd Font** and open a new terminal.

## Optional tools

`zshrc` skips these when they are missing. Install only what the user needs.

| Tool | Install |
| --- | --- |
| Rust | `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \| sh -s -- -y --no-modify-path` |
| nvm | `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh \| bash` |
| Conda | `brew install --cask miniforge` (expects `~/miniforge3`) |
| Docker | `brew install --cask docker` |
| bun | `curl -fsSL https://bun.sh/install \| bash` |
| kubectl, terraform, go | `brew install kubernetes-cli terraform go` |
| Google Cloud SDK | Install to `~/google-cloud-sdk` from cloud.google.com/sdk |

## Update this backup

```sh
REPO=~/Code/tools/skills
cp ~/.zshrc "$REPO/terminal/zshrc"; cp ~/.zshenv "$REPO/terminal/zshenv"; cp ~/.zprofile "$REPO/terminal/zprofile"
grep -vE '^\s*(#|$)' ~/.p10k.zsh > "$REPO/terminal/p10k.zsh"
grep -nEi "$(whoami)|api[_-]?key|token|secret|passw" "$REPO/terminal"/{zshrc,zshenv,zprofile}
```

The last command should print nothing. Check anything it prints before committing.
