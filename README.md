[![Build Status](https://travis-ci.org/deekayen/ansible-role-nessus-agent.svg?branch=master)](https://travis-ci.org/deekayen/ansible-role-nessus-agent)

Nessus Agent
============

Ansible role for installing and configuring Nessus Agent.

https://galaxy.ansible.com/deekayen/nessus-agent/

Role Variables
--------------

- `nessus_agent_key`: Key used for linking with Nessus host. This is blank by default and should be set.

- `nessus_agent_group`: Host group this agent should be added to when linking with Nessus host.

- `nessus_agent_host`: Nessus host to link with (default: `cloud.tenable.com`).

- `nessus_agent_port`: Nessus host port (default: `443`).

- `nessus_download_page`: The main download page to scrape for a download token.

    https://www.tenable.com/products/nessus/agent-download

- `nessus_linux_tmp`: /tmp

- `nessus_windows_temp`: "C:\\Temp"

- `nessus_version`: 7.0.3

Example Playbook
----------------

    - hosts: all
      become: yes
      roles:
         - role: ansible-role-nessus-agent
           nessus_agent_key: xxxxxxxxx
           tags: nessus-agent

License
-------

BSD 3-Clause
