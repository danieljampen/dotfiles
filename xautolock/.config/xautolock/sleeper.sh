#!/bin/bash

# Determine if the system should sleep => check if lockscreen is up, what only happens 
# if the system is indeed idle
should_sleep() {
    if pgrep -u $UID -x i3lock; then
	return 0
    fi
    return 1
}

# main()
if should_sleep; then
     echo sleeping...
     systemctl suspend
else
     echo not sleeping...
fi
