---
date: 2025-12-31
author: Sparrow
tags:
  - StarLiner
  - Blog
  - Technology
---

Welcome aboard the [[STAR Liner/STAR Liner - Welcome Briefing|Sparrow STAR Liner]]! A blog where we take a trackless voyage across Space, Technology, Aviation, and other Randomness. Stops are scattered, and we do not have many stations, but we hope you enjoy where you disembark.

___
# Secure Shell - SSH

Secure shell (commonly referred to as [SSH]([ssh.org - SSH (Secure Shell) information](https://ssh.org/))) is arguably the de-facto method of connecting to a remote terminal shell on a remote computer. Its de-facto implementation [OpenSSH](https://www.openssh.org/) is often preinstalled on Windows, MacOS, and Linux systems thus allowing easy connection. Here, we just compile some notes on common SSH flags (and their explanations) for connections.

## Typical SSH Connection

A typical SSH connection is just to connect from a local **client** machine's terminal to a remote **server** machine's terminal. It can be accomplished with: 
```shell
ssh username@remote
```

Where, the `remote` is the remote server machine's address, IP or DNS or otherwise. And, `username` is whatever user you are trying to log in on the remote server.

Typically, when connecting to a machine for the first time, you will be asked to add the machine to the `known_hosts` file. This file stores what is basically an ID of the server (as its public key string among other things). The entries in this store it based on the `remote` address provided; should the same computer be connectable two different ways, two different entries may be needed. The `known_hosts` file mainly exists as a basic protection from man-in-the-middle attacks and impersonators of the server itself. Should the remote server change legitimately (i.e. a reinstalled operating system), then its entry should be removed from the `known_hosts` file and the prompt will add it back in after first connection.

## Changing Port

Sometimes the SSH network port on the server is not the default port 22. Sometimes this is done for [[security through obscurity]], while other times it is for multiple SSH connections and other things. Regardless, you can set the port to connect to using the `-p` flag:
```shell
ssh -p port username@remote
```

See "Port Forwarding" for more information on forwarding ports using SSH.
## X-11 / Graphical Forwarding

SSH is often used just for text-based terminal connections, but, graphical applications can be forwarded over the connection. Both the client and server need to be configured to allow for X-11 forwarding. (X-11 is a common window display server for Linux; though it seems to be slowly being replaced.)

For the client, a simple flag, `-X` for X-11 forwarding will do:
```shell
ssh -X username@remote
```

This option may be made default by setting `FowardX11` to `yes` in the client configuration file (often `~/.ssh/config`). The client needs to also have a running X-11 server; though this is default in most operating systems, a custom third-party program may need to be used (especially for Windows).

For the server, X-11 forwarding must be allowed in the server configuration file by setting `X11Forwarding` to `yes`.  The location of this file depends on the operating system, but generally these are good places to look for it:
- Windows: `%ProgramData%\ssh`
- MacOS: `/private/etc/ssh/sshd_config`
- Linux: `/etc/ssh/sshd_config`
#### Windows X-11 Server

By default, modern Windows 11 systems have a built-in X-11 server for use with WSL. However, seemingly, this X-11 server is built to handle graphical forwarding from the WSL 2 installation. You will be able to forward X-11 windows via this by logging into the remote servers with X-11 forwarding using the Linux WSL 2 install. It is then automatically forwarded from the WSL 2 Linux to the Windows display server.

Otherwise, a third-party program may be needed: A simple X-11 server like [vcxsrv](https://github.com/marchaesen/vcxsrv), or a more all-encompassing solution like [MobaXterm](https://mobaxterm.mobatek.net/) can be installed.

## SSH Keys

SSH has two ways of authenticating the user/client: passwords or cryptographic keys. Passwords are relatively straightforward and need little explanation. However, due to security, most authenticating is done via cryptographic public-private key exchanges. We give a brief user-focused overview based on [How to Create an SSH Key in Linux: Easy Step-by-Step Guide | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-configure-ssh-key-based-authentication-on-a-linux-server).

In order to connect to a server, you need a private and public key pair. OpenSSH makes this easy to generate using `sshkeygen`. The defaults are typically fine. You optionally can add a password to the private key file, and this is suggested though some may not for ease of use.
```shell
sshkeygen
```

Now, in order for you to be able to connect to a server, you need to put your public key on the remote server you wish to connect to. If you are able to log onto the server using password-based authentication, the `ssh-copy-id` function is useful here. This will log you into the remote server, and upload your public key for later use. Afterwards, you are all done.
```shell
ssh-copy-id username@remote
```

Otherwise, you can open the public SSH key which should have content similar to: (RSA keys have longer text but are similar.)
```text
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKtur/4eOu/sNY+5UvXZWv6R4Q63Syz5oAfYbRvJwryE username@local
```

Adding the public key to the `authorized_keys` file (usually `~/.ssh/authorized_keys` in the home `~`  directory of the user you are logging in on the remote server) can be then done by simply by appending the entire public SSH key at the end of the file or by the following (which does the same thing.)
```shell
echo "ssh-ed25519 AAA...wryE username@local" >> ~/.ssh/authorized_keys
```

## Legacy SSH Cryptographic Protocols

Typically, `ssh` implementations only support a small set of modern encryption systems which is applicable for that day-in-age. In older servers, the old encryption algorithms supported then sometimes are enabled by default and are not automatically negotiated with a newer client connection. In order to allow for legacy `ssh` protocols with machines, the client and the server need to agree on the connection parameters. There are four total connection parameters which both machines need to have in common:
- `KexAlgorithms`: The key exchange methods that are used to generate per-connection keys.
- `HostkeyAlgorithms`: The public key algorithms accepted for an SSH server to authenticate itself to an SSH client.
- `Ciphers`: The ciphers to encrypt the connection.
- `MACs`: The message authentication codes used to detect traffic modification.

Client supported algorithms for these parameters can be found using the `-Q` flag:
```shell
ssh -Q cipher       # List client supported ciphers
ssh -Q macs         # List client supported MACs
ssh -Q key          # List client supported public key types
ssh -Q kex          # List client supported key exchange algorithms
```

Server supported algorithms for these parameters can be found using the `-G` flag. Here, we provide the use of `grep` to filter out just the wanted information from the full output.
```shell
# List remote supported ciphers
ssh -G user@remote.host | grep cipher   
# List remote supported MACs
ssh -G user@remote.host | grep macs   
# List remote supported public key types
ssh -G user@remote.host | grep hostkeyalgorithms   
# List remote supported key exchange algorithms
ssh -G user@remote.host | grep kexalgorithms   
```

Should there be no matching protocol for any of the parameters, an `ssh` connection will fail. To temporarily and or enable a specific cipher for both machines to communicate, we can provide it in the connection call.
```shell
ssh [options] 
    -oCiphers=+cipher-name 
    -oMACs=+mac-name 
    -oHostKeyAlgorithms=+hostkey-name 
    -oKexAlgorithms=+key-name
    ...
        user@remote.server

```

If of course there is no listed common cipher installed between both systems, and not just disabled by default, then a connection cannot be done without physical access to the remote system to update `ssh` or by downloading an older version of `ssh` (or just the correct legacy algorithms for the problematic parameter).

## Port Forwarding / Tunneling
Port forwarding is a way to safely redirect network traffic between different machines over a network and ports via SSH. We will cover simple local, remote, and dynamic port forwarding from a user's perspective. More information can be found [SSH Port Forwarding: Local, Remote, and Dynamic Explained | DigitalOcean](https://www.digitalocean.com/community/tutorials/ssh-port-forwarding) 

### Local Port Forwarding
Local port forwarding creates a secure tunnel between your local machine and a remote server. When you set up local port forwarding, you’re essentially creating a secure pathway that takes traffic from a specific port number `inport` on your computer and sends it to a specific port number `outport` on a remote server. Your own computer (i.e. `localhost` is typically `127.0.0.1`, your own machine, which is what `localhost` aliases to) is what is forwarding the traffic here.

You are redirecting traffic from your local machine's port to the remote server's port number. This command is typically run on the client machine.
```shell
ssh -L inport:localhost:outport username@remote
```

### Remote Port Forwarding
Remote port forwarding creates a secure tunnel that routes traffic from a remote server's port number `rport` back to your local machine's port number `lport`. This type of forwarding is particularly useful in scenarios where you need to expose local services to external users or systems. All traffic sent to the remote server's port number `rport` is redirected to the local machine's port number `lport`.

You are connecting to the remote server's port number `rport` and tunneling all of the traffic through SSH and forwarding it to your local machine's port number `lport`. This command is typically run on the client machine to allow for connections to a service on the port number `lport`.
```shell
ssh -R rport:localhost:lport username@remote
```

### Dynamic Port Forwarding
Dynamic port forwarding creates a SOCKS proxy that routes network traffic through a SSH tunnel, effectively anonymizing your connection. This a local SOCKS proxy server on your machine that forwards all traffic through the SSH connection to the remote server, which then makes the actual requests to the internet. The proxy server (not to be confused with the remote server) is configured for the `proxy` port number.
```shell
ssh -D proxy username@remote
```

You are creating a tunnel forwarding all traffic headed to `proxy` through the SSH connection for the `remote` server to proxy. This command is typically run on the client machine to proxy traffic through the `remote` server.

In order for your applications (like services and web browsers), you will need to instruct them to use `localhost:proxy` as the SOCKS proxy. How to do this is beyond this post.





___
Created: 2025-12-31
Last Updated: 2026-01-30