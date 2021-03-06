#------------------------------
# Prompt
#------------------------------
setprompt () {
# load some modules
autoload -U colors zsh/terminfo # Used in the colour alias below
colors
setopt prompt_subst

# make some aliases for the colours: (coud use normal escap.seq's too)
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
eval PR_$color='%{$fg[${(L)color}]%}'
done
PR_NO_COLOR="%{$terminfo[sgr0]%}"

# Check the UID
if [[ $UID -ge 1000 ]]; then # normal user
eval PR_USER='${PR_RED}%n${PR_NO_COLOR}'
eval PR_USER_OP='${PR_RED}%#${PR_NO_COLOR}'
elif [[ $UID -eq 0 ]]; then # root
eval PR_USER='${PR_RED}%n${PR_NO_COLOR}'
eval PR_USER_OP='${PR_RED}%#${PR_NO_COLOR}'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
eval PR_HOST='${PR_RED}%M${PR_NO_COLOR}' #SSH
else
eval PR_HOST='${PR_RED}%M${PR_NO_COLOR}' # no SSH
fi
# set the prompt
PS1=$'${PR_RED}[${PR_USER}${PR_RED}@${PR_HOST}${PR_RED}][${PR_RED}%~${PR_RED}]${PR_USER_OP} '
PS2=$'%_>'
}
setprompt

