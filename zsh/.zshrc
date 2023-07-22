# p10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

### env ###
export TERM=alacritty
export EDITOR=nano
export PAGER=less

export CMAKE_BUILD_PARALLEL_LEVEL=10

export MANGOHUD=1
export MANGOHUD_DLSYM=1
export PIPEWIRE_LATENCY=128/48000
# export PROTON_EAC_RUNTIME="$HOME/.steam/steam/steamapps/common/Proton EasyAntiCheat Runtime"
export SDKMAN_DIR="$HOME/.sdkman"

export ANDROID_HOME=/home/tronfy/Android/Sdk


DISABLE_AUTO_UPDATE=true
### prompt ###
ZSH_THEME="powerlevel10k/powerlevel10k"


### history ###
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000


### plugins ###
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"


### options ###
setopt autocd extendedglob nomatch rc_quotes
unsetopt beep correct correct_all notify

### source/init ###
source ~/.zsh_aliases
source $ZSH/oh-my-zsh.sh
source /usr/share/nvm/init-nvm.sh
eval "$(zoxide init zsh)"
export PATH=$PATH:"$(yarn global bin)"
export PATH="$PATH:$(python3 -m site --user-base)/bin"
export PATH="$PATH:$HOME/.cargo/bin"

# sdkman (must be at the end of the file)
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/home/tronfy/.bun/_bun" ] && source "/home/tronfy/.bun/_bun"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
