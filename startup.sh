#!/bin/bash

test -z "$TMUX" && (tmux attach -t working || tmux new -s working)
