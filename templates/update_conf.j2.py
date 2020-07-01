#!{{ ansible_python_interpreter | default('/usr/bin/python') }}
from __future__ import print_function

from difflib import context_diff
import json
import re
import subprocess


def update_cpus(hostname, partition_name, conf_file="/etc/slurm-llnl/slurm.conf"):
    # read cpu information (linux only)
    data = subprocess.check_output(["lscpu", "--json"])
    # convert from string
    data = json.loads(data)
    # convert from list
    data = {entry["field"]: entry["data"] for entry in data["lscpu"]}
    # get required data
    thread_per_core = data["Thread(s) per core:"]
    cores_per_socket = data["Core(s) per socket:"]
    sockets = data["Socket(s):"]
    # cpus = sockets * cores_per_socket * thread_per_core
    cpus = data["CPU(s):"]
    # create replacement lines
    lines = open(conf_file).read().splitlines()
    new_lines = []
    found_nodes = False
    in_nodes = False
    for line in lines:
        if line.startswith("# COMPUTER NODES START"):
            if found_nodes:
                raise IOError("'# COMPUTER NODES START' found multiple times")
            found_nodes = True
            in_nodes = True
        elif line.startswith("# COMPUTER NODES END"):
            if not in_nodes:
                raise IOError("'# COMPUTER NODES END' found before start")
            in_nodes = False
            new_lines.extend(
                [
                    "# COMPUTER NODES START",
                    "NodeName={0} Sockets={1} CoresPerSocket={2} ThreadsPerCore={3} State=UNKNOWN".format(
                        hostname, sockets, cores_per_socket, thread_per_core
                    ),
                    "PartitionName={0} Nodes={1} Default=YES MaxTime=INFINITE State=UP MaxNodes=1 MaxCPUsPerNode={2}".format(
                        partition_name, hostname, cpus
                    ),
                    "# COMPUTER NODES END",
                ]
            )
        elif not in_nodes:
            new_lines.append(line)

    # check for errors
    if not found_nodes:
        raise IOError("'# COMPUTER NODES START' not found")
    if in_nodes:
        raise IOError("'# COMPUTER NODES END' not found")

    # overwrite file if changes found
    if lines != new_lines:
        print(
            "computer resources changed:\n"
            + "\n".join(
                context_diff(lines, new_lines, fromfile="before", tofile="after")
            ),
        )
        with open(conf_file, "w") as handle:
            handle.write("\n".join(new_lines))
    else:
        print("computer resources unchanged")


if __name__ == "__main__":
    update_cpus("{{ slurm_hostname }}", "{{ slurm_partition_name }}")
