#!/bin/sh

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  echo "This script calls ansible-playbook to update the slurm configuration"
  echo "You can change the maximum cpus allowed by adding '-e slurm_max_cpus=2'"
  echo ""
  /usr/bin/ansible-playbook --help
  exit 0
fi

/usr/bin/ansible-playbook /etc/slurm-llnl/update-playbook.yml $1
