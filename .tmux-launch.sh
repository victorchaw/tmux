#!/bin/bash

# Explicitly set the PATH so the script can find Homebrew installations
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

SESSION="main"

# Check if the session already exists quietly
if ! tmux has-session -t $SESSION 2>/dev/null; then
  # Create a new session and split
  tmux new-session -d -s $SESSION
  tmux split-window -h -t $SESSION

  # Send 'nvim' to the Right pane
  tmux send-keys -t $SESSION 'nvim' C-m
fi

# Attach to the session. The script will "pause" here while you are inside tmux.
tmux attach-session -t $SESSION

# THE MAGIC TRICK:
# When you detach (Ctrl-b d), the line above finishes.
# The command below instantly replaces the ending script with a fresh, normal shell.
# The '-l' flag ensures it loads all your usual aliases and themes.
exec $SHELL -l
