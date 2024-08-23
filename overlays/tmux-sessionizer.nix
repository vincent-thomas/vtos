{ outputs }:
final: _prev: {
  tmux-sessionizer = outputs.packages.${final.system}.tmux-sessionizer;
}

