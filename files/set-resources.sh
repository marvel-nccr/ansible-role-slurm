#!/bin/sh
### BEGIN INIT INFO
# Provides:          set-resources
# Required-Start:    $remote_fs $syslog 
# Required-Stop:     $remote_fs $syslog 
# X-Start-Before:    slurmctld slurmd
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Set SLURM compute resources
# Description:       Set SLURM compute resources
### END INIT INFO

echo /usr/bin/slurm-update-resources
