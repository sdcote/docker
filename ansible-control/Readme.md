# Ansible Control Node

This creates an Ansible control node from which you can run playbooks and all manner of Ansible fun. Once built, it can be run thusly:

    docker run -d -P -v ansible:/opt/ansible --name ansible --hostname ansible ansible

You can now SSH into the container `root:coyote` and run Ansible.

Note the the above `run` command mounts a volume named `ansible` at `/var/opt/ansible` so you can persist your playbooks and roles.