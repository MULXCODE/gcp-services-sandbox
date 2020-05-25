# Ansible for Windows

## Overview

Provisions a Windows IIS Web Server with a Web Application launched on Port 8080 via Ansible over winrm.

## Prerequisites

1. Create an `AD User` named `ansible` and specify the password.
2. Create a local file, `inventory` with the username set to `ansible` and the password set to the `[YOUR_PASSWORD_HERE]`
3. On the target host, if you are using WINRM over HTTP (Port 5985), then ensure that you run these commands in `PowerShell` as an `Administrator`:

    ```bash
    winrm set winrm/config/service '@{AllowUnencrypted="true"}'
    winrm set winrm/config/service/Auth '@{Basic="true"}'
    netsh advfirewall firewall add rule name="WinRM-HTTP" dir=in localport=5985 protocol=TCP action=allow
    ```

4. Test out ansible connectivity from a Linux Bastion Host

    ```bash
    sudo apt-get install -y telnet ansible python3-pip
    pip3 install pywinrm[credssp]

    ansible -i inventory web -m win_ping
    ```

    Example Response:

    ```bash
    10.10.10.10 | SUCCESS => {
        "changed": false,
        "ping": "pong"
    }
    ```

## Commands

1. Run Module

    ```bash
    ansible -i inventory web -m win_ping
    ```

2. Run Playbook

    ```bash
    ansible-playbook -i inventory web_playbook.yaml
    ```
