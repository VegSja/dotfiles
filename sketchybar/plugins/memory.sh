#!/usr/bin/env zsh

source "$HOME/.config/sketchybar/colors.sh"

# Get total memory (in MB)
MEM_TOTAL=$(sysctl -n hw.memsize) # In bytes
MEM_TOTAL_MB=$((MEM_TOTAL / 1024 / 1024)) # Convert to MB

# Get memory usage for user and system
MEM_USED=$(vm_stat | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
MEM_FREE=$(vm_stat | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
MEM_WIRED=$(vm_stat | grep "Pages wired down" | awk '{print $4}' | sed 's/\.//')
MEM_INACTIVE=$(vm_stat | grep "Pages inactive" | awk '{print $3}' | sed 's/\.//')
PAGE_SIZE=$(vm_stat | grep "page size of" | awk '{print $8}' | sed 's/\.//')

# Add compressed memory
MEM_COMPRESSED=$(vm_stat | grep "Pages occupied by compressor" | awk '{print $5}' | sed 's/\.//')

# Debugging to print the values
echo "MEM_USED: $MEM_USED, MEM_FREE: $MEM_FREE, MEM_WIRED: $MEM_WIRED, MEM_COMPRESSED: $MEM_COMPRESSED"

# Calculate memory usage (App Memory + Wired Memory + Compressed Memory)
MEM_USED_MB=$(( (MEM_USED + MEM_WIRED + MEM_COMPRESSED) * PAGE_SIZE / 1024 / 1024 ))
MEM_PERCENT=$(( MEM_USED_MB * 100 / MEM_TOTAL_MB ))

# Calculate memory percentage usage with floating-point precision
MEM_PERCENT_USAGE=$(echo "scale=2; $MEM_USED_MB / $MEM_TOTAL_MB" | bc)

# Debug output to check the percentage
echo "MEM_USED_MB: $MEM_USED_MB, MEM_FREE_MB: $MEM_FREE_MB, MEM_PERCENT: $MEM_PERCENT, MEM_TOTAL_MB: $MEM_TOTAL_MB, MEM_PERCENT_USAGE: $MEM_PERCENT_USAGE"

# Find top memory-hogging process
TOPPROC=$(ps axo %mem,ucomm | sort -nr | head -n1 | awk '{printf "%.0f%% %s\n", $1, $2}')

# Set color based on memory usage percentage
COLOR=$WHITE
case "$MEM_PERCENT" in
  [1-5][0-9]) COLOR=$YELLOW ;;
  [6-8][0-9]) COLOR=$ORANGE ;;
  [9-9][0-9]|100) COLOR=$RED ;;
esac

# Send data to SketchyBar
sketchybar --set memory.percent label=$MEM_PERCENT% \
                              label.color=$COLOR    \
           --set memory.top    label="$TOPPROC"     \
           --push memory.percent_usage $MEM_PERCENT_USAGE
