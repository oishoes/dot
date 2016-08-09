# いろんな設定
export TERM='xterm-256color'
export EDITOR=vim
#bindkey -v  # vim keybind
bindkey -e  # emacs keybind
export LANG=en_US.UTF-8
#export LESSCHARSET=utf-JP
# ビープ音を鳴らさないようにする
setopt no_beep
setopt nolistbeep

# 補完系設定
autoload -U compinit; compinit                  # 補完機能を有効にする
setopt list_packed                              # 補完候補リストを詰めて表示
setopt list_types                               # auto_listの補完候補一覧でファイルの種別をマーク表示
setopt auto_list                                # 保管候補が複数あるときに，一覧表示する
setopt magic_equal_subst                        # =以降の補完
setopt auto_param_keys                          # カッコ対応も自動補完
setopt auto_param_slash                         # ディレクトリ名の保管で末尾の / を自動的に付加
setopt auto_menu                                # 補完キーを押すと順に保管する
setopt print_eight_bit                          # 日本語も正しく表示
setopt complete_aliases                         # alias も補完対象にする
setopt hist_no_store                            # history コマンドは追加しない
setopt always_to_end                            # 保管したら文字列末尾へ移動

# その他便利機能
setopt brace_ccl                # {a-c} を a b cに展開する
setopt auto_cd                  # ディレクトリ名でcdする
setopt pushd_ignore_dups        # ディレクトリスタックに同じディレクトリを追加しないようにする
setopt correct                  # コマンドのスペルチェック
#setopt correct_all              # コマンドライン全てのスペルチェック
setopt no_clobber               # 上書きリダイレクトの禁止
setopt path_dirs                # コマンド名に / が含まれている時PATH中のサブディレクトリを探す

#alias
alias gitst='git status'
alias ls="ls -G -w"
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
alias du="du -h"
alias df="df -h"
alias su="su -l"

# コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
autoload history-search-end # インクリメンタルに追加される
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
setopt share_history        # 履歴を共有する
setopt inc_append_history
setopt hist_ignore_dups     # 直前と同じコマンドは履歴に追加しない
setopt hist_reduce_blanks   # 余分な空白は詰める
setopt hist_ignore_space    # 先頭が空白だったならば履歴に追加しな
setopt hist_verify          # 履歴を呼び出してからも編集可能
setopt extended_history     # 実行時刻，実行時間も履歴に残す

# 色設定
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

# プロンプトの設定
autoload colors
colors

case ${UID} in
0)
    PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %{${fg[red]}%}%n@%m%#%{${reset_color}%} "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    RPROMPT="%{${fg[green]}%}[%~:%T]%{${reset_color}%}"
    ;;
*)
#
## Color
##
DEFAULT=$'%{\e[1;0m%}'
RESET="%{${reset_color}%}"
#GREEN=$'%{\e[1;32m%}'
GREEN="%{${fg[green]}%}"
#BLUE=$'%{\e[1;35m%}'
BLUE="%{${fg[blue]}%}"
RED="%{${fg[red]}%}"
CYAN="%{${fg[cyan]}%}"
WHITE="%{${fg[white]}%}"

#
## Prompt
##
setopt prompt_subst
PROMPT='${RESET}${GREEN}${WINDOW:+"[$WINDOW]"}${RESET}%{$fg_bold[blue]%}${USER}@%m ${RESET}${WHITE}$ ${RESET}'
RPROMPT='${RESET}${WHITE}[${BLUE}%(5~,%-2~/.../%2~,%~)% ${WHITE}]${WINDOW:+"[$WINDOW]"} ${RESET}'

#
# Vi入力モードでPROMPTの色を変える
function zle-line-init zle-keymap-select {
case $KEYMAP in
vicmd)
PROMPT="${RESET}${GREEN}${WINDOW:+"[$WINDOW]"}${RESET}%{$fg_bold[cyan]%}${USER}@%m ${RESET}${WHITE}$ ${RESET}"
;;
main|viins)
PROMPT="${RESET}${GREEN}${WINDOW:+"[$WINDOW]"}${RESET}%{$fg_bold[blue]%}${USER}@%m ${RESET}${WHITE}$ ${RESET}"
;;
esac
zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# 直前のコマンドの終了ステータスが0以外のときは赤くする。
# ${MY_MY_PROMPT_COLOR}はprecmdで変化させている数値。
local MY_COLOR="$ESCX"'%(0?.${MY_PROMPT_COLOR}.31)'m
local NORMAL_COLOR="$ESCX"m

#MYSQL COLOR
export MYSQL_PS1=$'[\e[36m\\R:\\m:\\s\e[0m] \e[32m\\u@\\h:\\p\e[0m \\d\\nmysql> '

# Show git branch when you are in git repository
# http://d.hatena.ne.jp/mollifier/20100906/p1

#autoload -Uz add-zsh-hook
#autoload -Uz vcs_info

#zstyle ':vcs_info:*' enable git svn hg bzr
#zstyle ':vcs_info:*' formats '(%s)-[%b]'
#zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
#zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
#zstyle ':vcs_info:bzr:*' use-simple true

#autoload -Uz is-at-least
#if is-at-least 4.3.10; then
# この check-for-changes が今回の設定するところ
#zstyle ':vcs_info:git:*' check-for-changes true
#zstyle ':vcs_info:git:*' stagedstr "+" # 適当な文字列に変更する
#zstyle ':vcs_info:git:*' unstagedstr "-" # 適当の文字列に変更する
#zstyle ':vcs_info:git:*' formats '(%s)-[%c%u%b]'
#zstyle ':vcs_info:git:*' actionformats '(%s)-[%c%u%b|%a]'
#fi

#function _update_vcs_info_msg() {
#psvar=()
#LANG=en_US.UTF-8 vcs_info
#psvar[2]=$(_git_not_pushed)
#[[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
#}
#add-zsh-hook precmd _update_vcs_info_msg

#function _git_not_pushed()
#{
#if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
#head="$(git rev-parse HEAD)"
#for x in $(git rev-parse --remotes)
#do
#if [ "$head" = "$x" ]; then
#return 0
#fi
#done
#echo "{?}"
#fi
#return 0
#}

#RPROMPT="%1(v|%F${CYAN}%1v%2v%f|)${vcs_info_git_pushed}${RESET}${WHITE}[${BLUE}%(5~,%-2~/.../%2~,%~)% ${WHITE}]${WINDOW:+"[$WINDOW]"} ${RESET}"

;;
esac

[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

PATH=$PATH:/home/shota-oiyama/bin
