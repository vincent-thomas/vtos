{ pkgs, ... }:
let
  tmuxSessionList = pkgs.writeShellApplication {
    name = "tmux-list-sessions";
    runtimeInputs = with pkgs; [
      fzf
    ];
    text = ''
      tmux switch-client -t "$(tmux list-sessions | awk -F: '{print $1}' | fzf)"
    '';
  };

  tmuxSessionizer = pkgs.writeShellApplication {
    name = "tmux-sessionizer";
    runtimeInputs = with pkgs; [
      fd
      fzf
    ];
    text = ''
      if [[ $# -eq 1 ]]; then
          selected=$1
      else
          selected=$(fd --min-depth 1 --max-depth 1 . '/home/vt' '/home/vt/personal' -x sh -c 'test -d {}/.git && echo {}' | fzf)
      fi

      if [[ -z $selected ]]; then
          exit 0
      fi

      selected_name=$(basename "$selected" | tr . _)
      tmux_running=$(pgrep tmux)

      if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
          tmux new-session -s "$selected_name" -c "$selected"
          exit 0
      fi

      if ! tmux has-session -t="$selected_name" 2> /dev/null; then
          tmux new-session -ds "$selected_name" -c "$selected"
      fi

      tmux switch-client -t "$selected_name"
    '';
  };

in
pkgs.stdenv.mkDerivation {
  name = "tmux-tools";
  src = null;

  # Disable unnecessary phases
  unpackPhase = ":";
  patchPhase = ":";
  configurePhase = ":";

  installPhase = ''
    mkdir -p $out/bin

    cp ${tmuxSessionizer}/bin/tmux-sessionizer $out/bin/
    cp ${tmuxSessionList}/bin/tmux-list-sessions $out/bin/
  '';

}
