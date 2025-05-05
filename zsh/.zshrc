# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
source /opt/ros/humble/setup.zsh
export ROS_DOMAIN_ID=72

export ROS_LOCALHOST_ONLY=1

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/scripts:$PATH"

#Custom Directories

export DOCS="$HOME/Documents"
export DOWN="$HOME/Downloads"
export PERSONAL="$HOME/dev/personal"
export WORK="$HOME/dev/work"
export DOTFILE="$HOME/dotfiles"

ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

#aliases
alias vim=nvim

alias wezterm='flatpak run org.wezfurlong.wezterm'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


