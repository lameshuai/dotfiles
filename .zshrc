# Path{

    PATH="/usr/local/bin:/usr/bin:/bin"   		# Setting Path
    export PATH
    export ZSH=$HOME/.oh-my-zsh		 			# Path to your oh-my-zsh installation.

# }

# Theme{

    ZSH_THEME="ys"			 				    # See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

# }

# Option{

    # CASE_SENSITIVE="true"		  				# Using case-sensitive completion
    # HYPHEN_INSENSITIVE="true"           		# Using hyphen-insensitive completion
	# DISABLE_AUTO_UPDATE="true"				# Disable bi-weekly auto-update checks
	# export UPDATE_ZSH_DAYS=13					# Changing how often to auto-update (in days)
	# DISABLE_LS_COLORS="true"					# Disable colors in ls
	# DISABLE_AUTO_TITLE="true"					# Disable auto-setting terminal title
	# ENABLE_CORRECTION="true"					# Enable command auto-correction
	# COMPLETION_WAITING_DOTS="true"			# Display red dots whilst waiting for completion
	# DISABLE_UNTRACKED_FILES_DIRTY="true"		# Disable marking untracked files

# }

# Plugins{

	plugins=(
  	  git										# This plugin adds many useful aliases and functions.
	  extract									# Supports a wide variety of archive filetypes
	  vundle									# Vim plugins manager
	  zsh-syntax-highlighting					# Systax-highlight
	)
	source $ZSH/oh-my-zsh.sh 		  			# Reading the command of the oh-my-zsh.sh
# }

# User Configuration{

	# Color {

	autoload colors
	colors
	for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
	eval _$color='%{$terminfo[bold]$fg[${(L)color}]%}'
	eval $color='%{$fg[${(L)color}]%}'
	(( count = $count + 1 ))
	done
	FINISH="%{$terminfo[sgr0]%}"

	# }

    # Setopt {

		export EDITOR=nvim						# Default editor
		export VISUAL=nvim						# Viusal vim
 		export GIT_EDITOR=nvim					# Git default editor
		export XMODIFIERS="@im=ibus"			# Typewriting
		export QT_MODULE=ibus
		export GTK_MODULE=ibus
		export HISTSIZE=10000					# Number of historical records
		export SAVEHIST=10000					# The number of record entries after the cancellation of the
		export HISTFILE=~/.zhistory				# Historical records
		setopt INC_APPEND_HISTORY				# Write a historical record in an additional way
		setopt HIST_IGNORE_DUPS					# If the commands of continuous input are the same, only one in the history record is retained
		setopt EXTENDED_HISTORY					# Add a timestamp to the command in the history record
		setopt AUTO_PUSHD						# The history of the CD command is enabled, and CD -[TAB] enters the history path
		setopt PUSHD_IGNORE_DUPS				# The same historical path is only one
		setopt HIST_IGNORE_SPACE				# Adding a space before the command does not add this command to a record file
		setopt INTERACTIVE_COMMENTS    			# Allow use of annotations in interactive mode rkj-repos
		setopt AUTO_CD							# Enable automatic CD, enter the directory name back into the directory
		setopt complete_in_word					# Extensions path
		setopt AUTO_LIST						# Auto completion
		setopt AUTO_MENU						# Auto completion menu
		setopt MENU_COMPLETE					# Select the menu item will direct completion
		setopt EXTENDED_GLOB					# Global setting
		setopt correctall						# Grammar check
		autoload compinstall
		autoload -U compinit
		zmodload zsh/mathfunc
		autoload -U zsh-mime-setup
		zsh-mime-setup
		compinit
		limit coredumpsize 0					# Forbidden coredumpsize
		WORDCHARS='*?_-[]~=&;!#$%^(){}<>'		# The following characters are considered as part of the word

    # }

    # Completion {

		#Completion caching
		#zstyle ':completion::complete:*' use-cache on
		#zstyle ':completion::complete:*' cache-path .zcache
		#zstyle ':completion:*:cd:*' ignore-parents parent pwd

        #Completion Options
		zstyle ':completion:*' verbose yes
		zstyle ':completion:*' menu select
		zstyle ':completion:*:*:default' force-list always
		zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'

		zstyle ':completion:*:match:*' original only
		zstyle ':completion::prefix-1:*' completer _complete
		zstyle ':completion:predict:*' completer _complete
		zstyle ':completion:incremental:*' completer _complete _correct
		zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

		#Path Expansion
		zstyle ':completion:*' expand 'yes'
		zstyle ':completion:*' squeeze-shlashes 'yes'
		zstyle ':completion::complete:*' '\\'

		#GNU Colors
		eval $(dircolors -b)
		export ZLSCOLORS="${LS_COLORS}"
		zmodload zsh/complist
		zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
		zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

		#Correction of case and case
		zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

		#Error correction
		zstyle ':completion:*' completer _complete _match _approximate
		zstyle ':completion:*:match:*' original only
		zstyle ':completion:*:approximate:*' max-errors 1 numeric

		#kill Completion
		compdef pkill=kill
		compdef pkill=killall
		zstyle ':completion:*:*:kill:*' menu yes select
		zstyle ':completion:*:*:*:*:processes' force-list always
		zstyle ':completion:*:processes' command 'ps -au$USER'

		#Group matches and Describe
		zstyle ':completion:*:matches' group 'yes'
		zstyle ':completion:*' group-name ''
		zstyle ':completion:*:options' description 'yes'
		zstyle ':completion:*:options' auto-description '%d'
		zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
		zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
		zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
		zstyle ':completion:*:corrections' format $'\e[01;32m -- %d (errors: %e) --\e[0m'

		#cd ~ Complete order
		zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'

		#Custom completion
		#Complete  ping
		zstyle ':completion:*:ping:*' hosts 192.168.1.{1,50,51,100,101} www.google.com

		#Complete ssh scp sftp ...
		#zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

    # }

	# Alias {

		alias cp='cp -i'
		alias mv='mv -i'
		alias rm='rm -i'
		alias ls='ls -F --color=auto'
		alias ll='ls -al'
		alias grep='grep --color=auto'
		alias la='ls -a'
		alias srzsh='source ~/.zshrc'
		alias vizsh='nvim ~/.zshrc'
		alias vitml='nvim ~/.tmux.conf.local'

	# }

	# Bindkey {

		#Insert sudo before the command
		sudo-command-line() {
		[[ -z $BUFFER ]] && zle up-history
		[[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
		zle end-of-line
		}
		zle -N sudo-command-line
		#Define the shortcut key:[Esc] [Esc]
		bindkey "\e\e" sudo-command-line

		#[Esc][h] man A brief description of the current command
		alias run-help >&/dev/null && unalias run-help
		autoload run-help

		#Path alias Enter the corresponding path as long as cd ~xxx
		hash -d E="/etc/"
		hash -d D="/home/kyle/下载"

		#The cursor at the beginning of the completion "cd "
		user-complete(){
		case $BUFFER in
		"" )                       # Empty line insert "cd "
		BUFFER="cd "
		zle end-of-line
		zle expand-or-complete
		;;
		"cd --" )                  # "cd --" Replace "cd -"
		BUFFER="cd -"
		zle end-of-line
		zle expand-or-complete
		;;
		"cd +-" )                  # "cd +-" Replace "cd -"
		BUFFER="cd -"
		zle end-of-line
		zle expand-or-complete
		;;
		* )
		zle expand-or-complete
		;;
		esac
		}
		zle -N user-complete
		bindkey "\t" user-complete

	# }

	# Command highlighting interface{

		TOKENS_FOLLOWED_BY_COMMANDS=('|' '||' ';' '&' '&&' 'sudo' 'do' 'time' 'strace')
		recolor-cmd() {
		region_highlight=()
				colorize=true
				start_pos=0
				for arg in ${(z)BUFFER}; do
				((start_pos+=${#BUFFER[$start_pos+1,-1]}-${#${BUFFER[$start_pos+1,-1]## #}}))
				((end_pos=$start_pos+${#arg}))
				if $colorize; then
					colorize=false
					res=$(LC_ALL=C builtin type $arg 2>/dev/null)
					case $res in
						*'reserved word'*)   style="fg=magenta,bold";;
						*'alias for'*)       style="fg=cyan,bold";;
						*'shell builtin'*)   style="fg=yellow,bold";;
						*'shell function'*)  style='fg=green,bold';;
						*"$arg is"*)
							[[ $arg = 'sudo' ]] && style="fg=red,bold" || style="fg=blue,bold";;
						*)                   style='none,bold';;
				esac
				region_highlight+=("$start_pos $end_pos $style")
				fi
				[[ ${${TOKENS_FOLLOWED_BY_COMMANDS[(r)${arg//|/\|}]}:+yes} = 'yes' ]] && colorize=true
				start_pos=$end_pos
				done
		}
		check-cmd-self-insert() { zle .self-insert && recolor-cmd }
		check-cmd-backward-delete-char() { zle .backward-delete-char && recolor-cmd }
		zle -N self-insert check-cmd-self-insert
		zle -N backward-delete-char check-cmd-backward-delete-char

	# }

# }
