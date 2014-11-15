# set xmodmap
if [ -f "$HOME/.Xmodmap" ] ; then
  xmodmap "$HOME/.Xmodmap"
fi

# set alias
alias rm='rm -i'

# set virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh

# set android sdk
export PATH=${PATH}:~/Work/android-sdk-linux/tools:~/Work/android-sdk-linux/platform-tools
