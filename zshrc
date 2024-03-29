# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit
zstyle ':completion:*' menu select=2

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad

# history settings
setopt histignoredups
HISTFILE=~/.zsh_history
HISTSIZE=14096
SAVEHIST=14096

ulimit -n 2560

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# use vim as the visual editor
export VISUAL='vim'
export EDITOR=$VISUAL

# load thoughtbot/dotfiles scripts
export PATH="$HOME/.bin:$PATH"

# mkdir .git/safe in the root of repositories you trust
export GOPATH=$HOME/src/go

# add heroku cli
export PATH="$PATH:/usr/local/heroku/bin"
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

[[ -s /Users/melanie/.autojump/etc/profile.d/autojump.sh ]] && source /Users/melanie/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Android React Native setup
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

# aliases
source ~/.aliases

# load env variables with direnv
# eval "$(direnv hook $0)"
eval "$(direnv hook zsh)"

# Prompt
GIT_THEME_PROMPT_DIRTY=" ${red}✗"
GIT_THEME_PROMPT_CLEAN=" ${bold_green}✓"
GIT_THEME_PROMPT_PREFIX=" ${green}|"
GIT_THEME_PROMPT_SUFFIX="${green}|"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="𐌣"
ZSH_THEME_GIT_PROMPT_BEHIND="ↆ"
ZSH_THEME_GIT_PROMPT_CURRENT="="

parse_git_dirty() {
  if command git diff-index --quiet HEAD 2> /dev/null; then
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  else
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  fi
}

show_upstream() {
  upstream_state=''
  current=true
  ahead_count=$(git rev-list @{upstream}.. --count 2> /dev/null)
  if [ $ahead_count ] && (( $ahead_count > 0 )); then
    upstream_state="%{$fg[yellow]%}$ZSH_THEME_GIT_PROMPT_AHEAD${ahead_count}%{$reset_color%}"
    current=false
  fi

  behind_count=$(git rev-list HEAD..@{upstream} --count 2> /dev/null)
  if [ $behind_count ] && (( $behind_count > 0 )); then
    upstream_state="$upstream_state %{$fg[yellow]%}$ZSH_THEME_GIT_PROMPT_BEHIND${behind_count}%{$reset_color%}"
    current=false
  fi

  if $current; then
    upstream_state="%{$fg[green]%}$ZSH_THEME_GIT_PROMPT_CURRENT%{$reset_color%}"
  fi

  echo $upstream_state
}

# adds the current branch name in green
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo " [%{$fg_bold[magenta]%}${ref#refs/heads/}%{$reset_color%} $(parse_git_dirty) $(show_upstream)]"
  fi
}

aws_vault_info() {
  if [ $AWS_VAULT ]; then
    echo "[$AWS_VAULT] "
  fi
}

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# expand functions in the prompt
setopt PROMPT_SUBST

# prompt
export PS1='$(aws_vault_info)[%{$fg_bold[blue]%}%~%{$reset_color%}]$(git_prompt_info)'$'\n''%{$fg[green]%}→%{$reset_color%} '

# VS Code setup to use "code" in command line
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"


export PATH="$PATH:$HOME/bin"
. $HOME/.asdf/asdf.sh

echo -e '
. /Users/melanievanderlugt/.asdf/asdf.sh' >> ~/.bash_profile
echo -e '
. /Users/melanievanderlugt/.asdf/completions/asdf.bash' >> ~/.bash_profile

# WSGR
function t() {
    if [ -n "$TEST_COMMAND" ]
    then
        eval $TEST_COMMAND
    elif [ -f test.sh ]
    then
        ./test.sh
    else
        bundle exec bench
    fi
}

PATH=$HOME/.subscript/bin:$PATH

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Vroom support 5/6/22
export PATH=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home/bin:$PATH

PATH=$PATH:$HOME/Library/Android/Sdk/emulator
PATH=$PATH:$HOME/Library/Android/Sdk/tools
PATH=$PATH:$HOME/Library/Android/Sdk/tools/bin
PATH=$PATH:$HOME/Library/Android/Sdk/platform-tools
export ANDROID_HOME=$HOME/Library/Android/

export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export PATH="/usr/local/opt/postgresql@13/bin:$PATH"

export PATH=/usr/local/bin:/usr/local/sbin:~/bin:$PATH

export COMPOSER_ALLOW_SUPERUSER=1; composer show;
export PATH="${HOME}/.pyenv/shims:${PATH}"
