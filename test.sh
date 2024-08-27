selected=$(fd . ~/p --min-depth 1 --max-depth 1 --type d | fzf)
selected_name=$(basename "$selected" | tr . _)
zellij_running=$(pgrep zellij)

session_exists=$(zellij list-sessions | grep $selected_name 2> /dev/null)

if [[ -z $zellij_running ]] || [[ -z $session_exists ]]; then
#   cd $selected
    zellij --session $selected_name options --default-cwd $selected
    exit 0
fi
#
zellij attach --create $selected_name 
