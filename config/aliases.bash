## New Aliases
alias service-start='sudo systemctl start '
alias service-stop='sudo systemctl stop '
alias service-status='sudo systemctl status '
alias service-restart='sudo systemctl restart '
alias list-services='systemctl list-units --type=service'
alias list-enabled='systemctl list-unit-files --state=enabled'
alias list-disabled='systemctl list-unit-files --state=disabled'
alias list-running='systemctl list-units --type=service --state=running'

if [ $UID -ne 0 ]; then
    alias reboot='sudo reboot'
    alias update='sudo apt-get update'
    alias upgrade='sudo apt-get upgrade -y'
fi

ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

pget()
{
[[ "$1" =~ name=([a-zA-Z0-9_.]{0,}.mp4) ]]
	downloadfile="${BASH_REMATCH[1]}"
	wget "$1" -O $downloadfile
}


alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status'
alias tag='git tag'
alias newtag='git tag -a'

