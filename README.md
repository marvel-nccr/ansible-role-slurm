[![CI](https://github.com/marvel-nccr/ansible-role-slurm/workflows/CI/badge.svg)](https://github.com/marvel-nccr/ansible-role-slurm/actions)
[![Ansible Role](https://img.shields.io/ansible/role/30201.svg)](https://galaxy.ansible.com/marvel-nccr/slurm)
[![Release](https://img.shields.io/github/tag/marvel-nccr/ansible-role-slurm.svg)](https://github.com/marvel-nccr/ansible-role-slurm/releases)

# Ansible Role: marvel-nccr.slurm

An Ansible role that installs the [slurm](https://slurm.schedmd.com/) workload manager on Ubuntu (tested on 16.04, 18.04 and 20.04).

The role:

- Installs the slurm packages
- Sets up the slurm configuration (`/etc/slurm-llnl/slurm.conf`) to dynamically use the correct platform resources (hostname, #CPUs, etc), configuring one node (named `$HOSTNAME`) and one partition (named `slurm_partition_name`).
- Adds a `slurm-resources` script and start-up service to automate the initiation of correct platform resources (required if creating a VM image where instances may have different resources)
- Starts the slurm services.

To check the services are running (assuming systemd in use):

```console
$ systemctl --type=service
...
slurmctld.service                  loaded active running Slurm controller daemon
slurmd.service                     loaded active running Slurm node daemon
...
```

To check the slurm node/partition:

```console
$ scontrol show node
$ scontrol show partition
```

This should match the resources given in `lscpu`.

To enable/disable the `slurm-resources` start up service:

```console
$ systemctl enable slurm-resources
```

To alter the resources configuration of slurm directly, you can use e.g.:

```console
$ slurm-resources -e restart_on_change=true -e slurm_max_cpus=2
```

This will update the resources defined for the node, set the maximum CPUs for the partition to 2 (independent of the CPUs available on the node), and restart the slurm services with the updated configuration (if the configuration has changed).

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
