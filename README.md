[![CI](https://github.com/marvel-nccr/ansible-role-slurm/workflows/CI/badge.svg)](https://github.com/marvel-nccr/ansible-role-slurm/actions)
[![Galaxy](https://img.shields.io/badge/Galaxy-marvel--nccr.slurm-blue)](https://galaxy.ansible.com/marvel-nccr/slurm)

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

## Code style

Code style is formatted and linted with [pre-commit](https://pre-commit.com/).

```bash
pip install pre-commit
pre-commit run -all
```

## Deployment

Deployment to Ansible Galaxy is automated *via* GitHub Actions.
Simply tag a release `vX.Y.Z` to initiate the CI and release workflow.
Note, the release will only complete if the CI tests pass.

## License

MIT

## Contact

Please direct inquiries regarding Quantum Mobile and associated ansible roles to the [AiiDA mailinglist](http://www.aiida.net/mailing-list/).
