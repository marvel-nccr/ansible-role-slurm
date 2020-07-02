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

run_update ()
{
# TODO ideally we would also output stderr to the log file
# but for some reason 2>&1 makes $* in slurm-update-resources also read the log path as a variable
/usr/bin/slurm-update-resources -e update_on_change=false > /var/log/slurm-resources.log
cat /var/log/slurm-resources.log
}

case "$1" in
  start)
    run_update
    ;;
  stop)
    echo "stopped"
    ;;
  restart)
    run_update
    ;;
  try-restart|condrestart)
    run_update
    ;;
  reload)
    run_update
    ;;
  force-reload)
    run_update
    ;;
  status)
    echo "no status to report"
    ;;
  *)
    COMMANDS="start|stop|restart|try-restart|reload|force-reload|status"
    echo "Usage: `basename \"$0\"` ($COMMANDS)" >&2
    exit 2                              # invalid or excess argument(s)
    ;;
esac
