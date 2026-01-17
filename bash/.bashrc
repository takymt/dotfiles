# exit early for non-interactive shells to avoid unwanted output
case $- in
    *i*) ;;
      *) return;;
esac

HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth  # ignore duplicates and commands starting with space

# update COLUMNS and LINES after terminal resize
shopt -s checkwinsize

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi
