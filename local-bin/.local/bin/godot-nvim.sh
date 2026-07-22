#!/bin/sh
# godot-nvim PROJECT FILE LINE COL
exec >>/tmp/godot-nvim.log 2>&1
set -x

PROJECT="$1"
FILE="$2"
LINE="${3:-0}"
COL="${4:-0}"
PIPE="$PROJECT/server.pipe"
NVIM_CMD="nvim --listen '$PIPE' '+$((LINE + 1))' '$FILE'"


# 1. nvim server already up -> send it the file
if [ -S "$PIPE" ] && nvim --server "$PIPE" --remote-expr "1" >/dev/null 2>&1; then
  exec nvim --server "$PIPE" --remote-send \
    "<C-\\><C-N>:lua require('godot').open('$FILE', $LINE, $COL)<CR>"
fi

rm -f "$PIPE"

# 2. no tmux server at all -> new terminal, new session
if ! tmux list-sessions >/dev/null 2>&1; then
  exec alacritty -e tmux new-session -c "$PROJECT" "$NVIM_CMD"
fi

# 3. add window to the most recently active session
tmux new-window -c "$PROJECT" "$NVIM_CMD"

# 4. spawn a terminal only if nothing is attached
if [ -z "$(tmux list-clients 2>/dev/null)" ]; then
  exec alacritty -e tmux attach
fi
