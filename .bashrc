# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Aliase

# ISO Mounten
alias mountiso='sudo mount -o loop'

# Laptop und externen Bildschirm syncen
alias sync-display="$HOME/sync/bash/commands/sync-display.sh"

# Nur Bildschirm aufnehmen
alias record_screen='ffmpeg -video_size $(command -v xrandr >/dev/null && xrandr | grep "*" | awk "{print \$1}") -framerate 30 -f x11grab -i :0.0 output.mp4'

# Nur Bildschirm und Webcam aufnehmen
alias record_screen_webcam='ffmpeg -video_size $(xrandr | grep "*" | awk "{print \$1}") -framerate 30 -f x11grab -i :0.0 \
    -f v4l2 -i /dev/video0 \
    -filter_complex "[1:v]scale=iw/4:ih/4[cam];[0:v][cam]overlay=W-w-10:H-h-10" \
    -c:v libx264 -preset ultrafast -crf 23 output.mp4'


# Bildschirm, Webcam und Mikrofon aufnehmen
alias record_screen_webcam_mic='ffmpeg -video_size $(xrandr | grep "*" | awk "{print \$1}") -framerate 30 -f x11grab -i :0.0 \
    -f v4l2 -video_size 640x480 -i /dev/video0 \
    -f alsa -i hw:0 \
    -filter_complex "[1:v]scale=320:240[cam];[0:v][cam]overlay=W-w-10:H-h-10" \
    -c:v libx264 -preset ultrafast -crf 23 -c:a aac -b:a 128k output.mp4'

# Nur Bildschirm mit Mikrofon aufnehmen
alias record_screen_mic='ffmpeg -video_size $(xrandr | grep "*" | awk "{print \$1}") -framerate 30 -f x11grab -i :0.0 \
    -f alsa -i hw:0 \
    -c:v libx264 -preset ultrafast -crf 23 -c:a aac -b:a 128k output.mp4'

# Einzelnes Video herunterladen (beste Qualität)
alias ytdl-video='yt-dlp -f "bestvideo+bestaudio/best" -o "%(upload_date)s - %(title).200s.%(ext)s" --restrict-filenames'


# Playlist herunterladen
alias ytdl-playlist='yt-dlp --yes-playlist -o "%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s"'

# Nur Audio als MP3 herunterladen
alias ytdl-mp3='yt-dlp -x --audio-format mp3 --audio-quality 0 -o "%(title)s.%(ext)s"'

# Alle Videos eines Kanals herunterladen
alias ytdl-channel='yt-dlp --yes-playlist -o "%(uploader)s/%(upload_date)s - %(title)s.%(ext)s"'


# Programme beim start
if [[ $- == *i* ]]; then
    neofetch
fi

# SSH Agent starten
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)" > /dev/null
fi

# SSH-Agent persistieren und für alle Terminals nutzbar machen
SSH_ENV="$HOME/.ssh/agent.env"

function start_ssh_agent {
    echo "🔑 Starte neuen ssh-agent..."
    ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
    ssh-add ~/.ssh/id_rsa
}

# Prüfen, ob ein SSH-Agent läuft und wiederverwenden
if [ -f "$SSH_ENV" ]; then
    . "$SSH_ENV" > /dev/null
    if ! pgrep -u "$USER" ssh-agent > /dev/null; then
        start_ssh_agent
    fi
else
    start_ssh_agent
fi