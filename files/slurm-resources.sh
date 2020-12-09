#!/bin/sh

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  echo "This script calls ansible-playbook to update the slurm configuration"
  echo "You can add options such as:"
  echo ""
  echo "- Restart SLURM (for changes to take affect): -e restart_slurm=true"
  echo "- Restart SLURM only on changes: -e restart_on_change=true"
  echo "- Change the maximum cpus allowed: -e slurm_max_cpus=2"
  echo "- Change the verbosity with: -vv"
  exit 0
fi

/usr/bin/ansible-playbook /etc/slurm-llnl/update-playbook.yml $@
