# Aliases

alias ls="exa"
alias la="exa -al"
alias lp="exa -alh"
alias clear="clear && exec zsh"

# Welcome Message

echo "\e[43m\e[0;37mWelcome Back \e[1;32mBenitzCoding\e[0;37m!"

# ZSH Theme & Plugins

plugins=(
    zsh-syntax-highlighting
    zsh-autosuggestions
    web-search
)

# ZSH_THEME="common"

source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.powerlevel10k/powerlevel10k.zsh-theme

export PATH="/Users/beni/.deta/bin:$PATH"

# Transfer.sh

transfer(){ if [ $# -eq 0 ];then echo "No arguments specified.\nUsage:\n transfer <file|directory>\n 
... | transfer <file_name>">&2;return 1;fi;if tty -s;then file="$1";file_name=$(basename "$file");if [ 
! -e "$file" ];then echo "$file: No such file or directory">&2;return 1;fi;if [ -d "$file" ];then 
file_name="$file_name.zip" ,;(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" 
"https://transfer.sh/$file_name"|tee /dev/null,;else cat "$file"|curl --progress-bar --upload-file "-" 
"https://transfer.sh/$file_name"|tee /dev/null;fi;else file_name=$1;curl --progress-bar --upload-file 
"-" "https://transfer.sh/$file_name"|tee /dev/null;fi;}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
