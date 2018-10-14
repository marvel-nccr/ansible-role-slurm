[![Build Status](https://travis-ci.org/marvel-nccr/ansible-role-slurm.svg?branch=master)](https://travis-ci.org/marvel-nccr/ansible-role-slurm)

# Ansible Role: marvel-nccr.slurm

An Ansible role that installs the [slurm](https://slurm.schedmd.com/) workload manager on Ubuntu.

## Installation

`ansible-galaxy install marvel-nccr.slurm`

**NOTE!** It is important that the hostname is properly set in the machine
(both with `hostname <HOSTNAME>` and in the `/etc/hosts/` file, in the line with the IP address (e.g. in docker this line should read `172.17.0.2 <HOSTNAME>`, where `<HOSTNAME>` should be replaced with the hostname, and should match the variable `slurm_hostname` (default value: `qmobile`).

## Role Variables

See `defaults/main.yml`

## Example Playbook

```
- hosts: machines
  roles:
  - role: nccr-marvel.slurm
```

## Tests

This role uses [Molecule](https://molecule.readthedocs.io/en/latest/#) and
Docker for tests. Once Docker is installed, run tests using

```bash
pip install -r requirements.txt
molecule test
```

## License

MIT

## Contact

Please direct inquiries regarding Quantum Mobile and associated ansible roles to the [AiiDA mailinglist](http://www.aiida.net/mailing-list/).
