[![CI](https://github.com/marvel-nccr/ansible-role-slurm/workflows/CI/badge.svg)](https://github.com/marvel-nccr/ansible-role-slurm/actions)
[![Ansible Role](https://img.shields.io/ansible/role/30201.svg)](https://galaxy.ansible.com/marvel-nccr/slurm)
[![Release](https://img.shields.io/github/tag/marvel-nccr/ansible-role-slurm.svg)](https://github.com/marvel-nccr/ansible-role-slurm/releases)

# Ansible Role: marvel-nccr.slurm

An Ansible role that installs the [slurm](https://slurm.schedmd.com/) workload manager on Ubuntu.

**NOTE!** It is important that the hostname is properly set in the machine
(both with `hostname <HOSTNAME>` and in the `/etc/hosts/` file, in the line with the IP address (e.g. in docker this line should read `172.17.0.2 <HOSTNAME>`, where `<HOSTNAME>` should be replaced with the hostname, and should match the variable `slurm_hostname` (default value: `qmobile`).

## Installation

`ansible-galaxy install marvel-nccr.slurm`

## Role Variables

See `defaults/main.yml`

## Example Playbook

```yaml
- hosts: servers
  roles:
  - role: marvel-nccr.slurm
```

## Development and testing

This role uses [Molecule](https://molecule.readthedocs.io/en/latest/#) and [Docker](https://www.docker.com/) for tests.

After installing [Docker](https://www.docker.com/):

Clone the repository into a package named `marvel-nccr.slurm` (the folder must be named the same as the Ansible Galaxy name)

```bash
git clone https://github.com/marvel-nccr/ansible-role-slurm marvel-nccr.slurm
cd marvel-nccr.slurm
```

Then run:

```bash
pip install -r requirements.txt  # Installs molecule
molecule test  # runs tests
```

or use tox (see `tox.ini`):

```bash
pip install tox
tox
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
