# Docker
This is a repositopry of various docker files used on various projects and for different clients.

# Projects
This is a small listing of some of the more useful or interesting projects.

## sshd-min
This is a very small (Alpine) linux distro that allows SSH connections. It is used as a jump host of sorts, to more easily access other containers running on the host. SSH is helpful in that it allows Windows users to attach with Putty and run curses-based applications.

## sshd
This builds an Ubuntu 16.04 image which listens for SSH connections. It is designed to be a simple Linux environment to develop and test scripts in a Windows environment. It is much faster than setting up a complete VM and in some cases obviates the need of installin a VM manager. This is again helpful in that VM managers like Virtual Box cannot run with Hyper-V enabled which Docker requires. So this gives you the ability to run a Linux environment on Windows with just Docker.

Using volumes with this image will be helpful as it will allow you to persist and share data.

## ansible-control
This build creates an Ansible control node on Ubuntu . It listens to SSH connections and has Ansible installed to allow an operator to develop and test playbooks in a Docker environment. All that is needed for a remote node to be managed by this images in Python 2.x installed and the ability to accept SSH connections.See [ansible-node](#ansible-node)

## ansible-node
This builds an image which with Python 2.x and listens to SSH connections allowing it to be managed by Ansible. The goal of this image is to provide the operator a way to test playbooks and other scripts completely within Docker. See [ansible-control](#ansible-control).

## ansible-ping
This builds an image which will ping ansible remote nodes. This allows systems without Ansible installed to perform a *ping* of remote hosts. It is expected to be run from *nix Docker systems and to have an inventory file names `hosts` in the current working directory. Optionally, if an `ansible.cfg` file is in the current working directory, it will be used for the *ping* command.
