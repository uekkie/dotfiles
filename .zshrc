# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(git rails)
source "$ZSH/oh-my-zsh.sh"

# Directory jumping
eval "$(jump shell --bind=z)"

# Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# mise: Ruby, Python, Node.js and related tools
eval "$(/opt/homebrew/bin/mise activate zsh)"

# PostgreSQL
export PGDATA="$HOMEBREW_REPOSITORY/var/postgres"

# Node.js package managers
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# MySQL 8.0
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"

# fzf
eval "$(fzf --zsh)"

# ghq + fzf: Ctrl-]でリポジトリを選択して移動
function ghq-fzf() {
  local src=$(ghq list | fzf --preview "ls -laTp $(ghq root)/{} | tail -n+4 | awk '{print \$9\"/\"\$6\"/\"\$7 \" \" \$10}'")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^]' ghq-fzf

# Claude Code
alias claude="$HOME/.claude/local/claude"

# pipx-installed commands
export PATH="$PATH:$HOME/.local/bin"

# npmサプライチェーン攻撃対策: npxは使わずpnpm dlxを使う
alias npx='echo "don'"'"'t use npx"'
