Tenable Nessus Agent
====================

[![CI](https://github.com/deekayen/ansible-role-nessus-agent/actions/workflows/ci.yml/badge.svg)](https://github.com/deekayen/ansible-role-nessus-agent/actions/workflows/ci.yml) [![Project Status: Suspended – Initial development has started, but there has not yet been a stable, usable release; work has been stopped for the time being but the author(s) intend on resuming work.](https://www.repostatus.org/badges/latest/suspended.svg)](https://www.repostatus.org/#suspended)

Install Tenable Nessus Agents and register with a management server.

Tags:

* install
* configure
* unlink

Requirements
------------

Download the Nessus Agent installer from https://www.tenable.com/downloads/nessus-agents and copy it to a local archive server. Tenable does not permit using their servers as a download mirror for automated installations.

For RedHat, the archive server where you host the RPM installer could be a yum repository on a locally hosted [Nexus Repository Manager](https://www.sonatype.com/nexus-repository-oss) or a RedHat Satellite channel. When this role executes, it assumes the repository is already configured and the package would be available via standard `yum install` commands.

For Windows, Nexus also offers Chocolatey/Nuget hosting option for archiving the MSI installer after packaging it for nuget installs.

Role Defaults
-------------

The `nessus_agent_group` variable defaults to either LINUX or WINDOWS, depending on the server it is connected to and can be overridden at runtime.

```
# The key should be overridden at runtime to a base16 string with ~64 characters.
nessus_agent_key: ""
nessus_agent_host: cloud.tenable.com
nessus_agent_port: 443

nessus_unlink: false
```

Role Variables
--------------

```
chocolatey_source: https://nexus.example.com/repository/nuget-hosted/
```

Dependencies
------------

```
- src: deekayen.chocolatey
  when: ansible_os_family == "Windows"
```

Example Playbook
----------------

    - hosts: all

      vars:
        nessus_agent_group: AWS
        nessus_agent_key: 5075742061207265616c206b657920696e7374656164206f6620746869732e00

      roles:
         - deekayen.nessus_agent

Tenable Nessus Agent Chocolatey Package
---------------------------------------

This package wraps the Tenable Nessus Agent msi in a nuget package so that the win_chocolately Ansible module can install it.

Pre-Tasks
---------
1. Install chocolatey within your local PowerShell installation
2. Add your Nuget API key into your chocolatey configuration
`choco apikey -k MYKEY-COPIED-FROM-NEXUS-PROFILE https://nexus.example.com/repository/nuget-hosted/`
3. Download the agent installer msi and store it in the tools subfolder as the name dotNetAgentSteup.Msi
4. Update the tenable-nessus-agent.nuspec <version> element with the specific version of the agent downloads

Create the package
------------------
1. Open PowerShell and navigate to the same folder where the .nuspec file exists
2. Run chocolatey pack command:
`choco pack`
3. You can test this package on a server by either running the the chocolatey commands manually or by using the win_chocolatey Ansible module manually, or through Ansible Tower/AWX adhoc commands.
4. Push the package to the nexus repo
`choco push .\TenableNessusAgent.7.4.3.nupkg -source https://nexus.example.com/repository/nuget-hosted/`

Package Arguments
-----------------

The package takes to arguments which can be passed via Ansible params element on
the the win_chocolatey module

* `/NessusGroups:` - Host group this agent should be added to when linking with Nessus host.
* `/NessusServer:` - Nessus host to link with (default: cloud.tenable.com)
* `/NessusKey:` - Key used for linking with Nessus host. This is blank by default.
