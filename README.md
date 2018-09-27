[![Build Status](https://travis-ci.org/marvel-nccr/ansible-role-slurm.svg?branch=master)](https://travis-ci.org/marvel-nccr/ansible-role-slurm)

# Ansible Role: marvel-nccr.slurm

An Ansible role that installs the [slurm](https://slurm.schedmd.com/) workload manager on Ubuntu.

## Installation

`ansible-galaxy install marvel-nccr.slurm`

## Role Variables

See `defaults/main.yml`

## Example Playbook

  - hosts: servers
    roles:
    - role: marvel-nccr.slurm

## License

MIT

## Contact

Please direct inquiries regarding Quantum Mobile and associated ansible roles to the [AiiDA mailinglist](http://www.aiida.net/mailing-list/).
