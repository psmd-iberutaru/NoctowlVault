---
date: 2026-02-26
author: Sparrow
tags:
  - StarLiner
  - Blog
  - Tutorial
---

Welcome aboard the [[STAR Liner/STAR Liner - Welcome Briefing|Sparrow STAR Liner]]! A blog where we take a trackless voyage across Space, Technology, Aviation, and other Randomness. Stops are scattered, and we do not have many stations, but we hope you enjoy where you disembark.

___
# Network Time Protocol

It would be redundant to explain a lot about the network time protocol (NTP), the basis of how most computers in the world synchronize to the common time. The [Network Time Protocol](https://en.wikipedia.org/wiki/Network_Time_Protocol) page on Wikipedia will do a much better job than I can here; however, I can provide a brief on the motivations of creating, hosting, and using a personal network time protocol server.

Typically, a computer will periodically query a NTP server to synchronize the times between it and all other computers. The NTP server provided is often a load-balanced pool of NTP servers, typically dependent on the operating system. We provide a very small list of public time servers which are used.

| Scope                                                                                                                                                     | Address                     |
| --------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------- |
| [Microsoft Windows](https://learn.microsoft.com/en-us/windows-server/networking/windows-time-service/Windows-Time-Service-Tools-and-Settings?tabs=config) | `time.windows.com`          |
| Apple MacOS                                                                                                                                               | `time.apple.com`            |
| [Debian Linux](https://wiki.debian.org/Services/NTP%20Pool%20(network%20time%20protocol))                                                                 | `debian.pool.ntp.org`       |
| [NTP Pool Project](https://www.ntppool.org/en/)                                                                                                           | `pool.ntp.org`              |
| Sparrow Servers                                                                                                                                           | `ntp.sparrow-orcinus.space` |

Although these servers provide the time quite accurately, there is no guarantee that more corporate servers are correctly synchronized to each other. Thus, computers using different servers may have different times. Practically, this is irrelevant as it can easily be assumed that all NTP-based servers reference NTP Stratum 0 sources which (by the core assumption of NTP) are all synchronized to each other. The aforementioned problems would really only account for a few to tens of seconds asynchronous offset.

Creating, hosting, and using one's own timeserver is mostly for learning, fun, and the occasional helping of the NTP Pool project itself. Of course, using one's own timeserver also provides more control for the more security minded person. Some large organizations set up their own time servers to ensure that there is not excessive load placed on the NTP system as a whole, and to the most minor of degrees, we do so here as well.

In this post, I often use the NTP server `ntp.digiultsparrow.space`. This is just my personal NTP server; feel free to replace it with your own server, or a pool of servers.
# Configuring a NTP Client

Each different operating system has their own specific ways of being configured so that they can use a different NTP server.

## Linux Client 

Though these instructions are for Debian, any Debian-based operating system will likely work with these instructions. Moreover, RHEL/Fedora-based distributions which use `systemd` will also have practically the same instructions for their different modes, so there is no use repeating what is not needed. We group all of these clients under "Linux" as so.

Debian has many different types of clients, of which, really, only two are relevant for our discussions. The first is `systemd-timesyncd`, the built-in default. Second is `chrony`, a modern and popular third-party implementation of the NTP protocol. Do not use conflicting clients!

#### systemd-timesyncd

This is typically built-in with operating systems with `systemd` and so installation is not really needed. We can check the status of `timesyncd` in different ways. As `timesyncd` is attached to `systemd`, we can get the most basic status information on the service itself via:

```shell
systemctl status systemd-timesyncd
```

More specific, advanced, or verbose status information can be obtained using other commands, in increasing levels of depth.

```shell
timedatectl status
timedatectl timesync-status
timedatectl show-timesync --all
```

In order to configure `timesyncd`, we need to add our time servers to the configuration file. The configuration file is typically stored in `/etc/systemd/timesyncd.conf`. Alternatively, a configuration snippet can be added; this is my personal preference, to add the following file as 
`/etc/systemd/timesyncd.conf.d/sparrow.conf`. You can name the file `sparrow.conf` whatever you want per [timesyncd.conf(5)](https://manpages.debian.org/buster/systemd/timesyncd.conf.5.en.html)

```systemd
[Time]
NTP=ntp.sparrow-orcinus.space
FallbackNTP=time.nist.gov
RootDistanceMaxSec=5
PollIntervalMinSec=32
PollIntervalMaxSec=2048
```

You can change the provided NTP servers (in `NTP=` and `FallbackNTP`) as a space-separated list; the values in there now is just what I personally use.

You can use the following to restart the service and apply the new configuration:
```shell
systemctl restart systemd-timesyncd
```

#### chrony

The `chrony` package contains two main commands: `chronyd` which controls the daemon; and `chronyc`, the command-line interface to monitor the daemon and make various configuration changes as it is running. To install it, just use your package manager for your operating system; below as some examples:
```shell
apt install chrony       # [On Debian/Ubuntu]
yum -y install chrony    # [On older RHEL/Fedora]
dnf -y install chrony    # [On newer RHEL/Fedora]
```

Chrony also integrates with `systemd` and so we can get its status:
```shell
systemctl status chronyd
```

More specific, advanced, or verbose status information can be obtained using other commands.
```shell
chronyc tracking
chronyc sources
chronyc sourcestats
```

In order to configure `chrony`, we need to add our time servers to the configuration file. The configuration file is typically found in `/etc/chrony.conf` or `/etc/chrony/chrony.conf`. 

To add a new server to the list of NTP servers, you can add a line in the configuration file in the right area:
```txt
# If a single server...
server ntp.sparrow-orcinus.space iburst

# ...or if a pool of servers.
pool ntp.sparrow-orcinus.space iburst maxsources 4
```

For NTP pool servers, `maxsources` sets the maximum number of sources that can be used from the pool, the default value is 4.

You can use the following to restart the service and apply the new configuration:
```shell
systemctl restart chronyd.service
```

## Windows 10/11 Client

There are two ways to configure the Windows time server for desktop-based Windows: graphically or via the command line. Generally, the graphical option is likely the best, unless multiple time servers are needed (as the GUI limits it to only one time server).

#### Graphically - Settings

In the Settings menu, under `Time & Language > Date & Time`, scroll to `Sync Now`, and under the drop down menu, there should be an option to change the time server. Change the time server with which ever you need: `ntp.digiultsparrow.space`.

Alternatively, you can just use the search bar to search for something akin to "time server" and get it that way.

#### Command Line - Powershell

Using the command line, we can also set the time servers using `w32tm`. This should also work with CMD, but it is best to be using Powershell anyways. Running the Powershell shell as an administrator is likely required. If the NTP-like service is not started, it can be started with the following command:
```powershell
net start w32time
```

You can check if a NTP time server is reachable by checking the offset from the local time to the server time via the following command:
```powershell
w32tm /stripchart /computer:ntp.digiultsparrow.space /samples:5 /dataonly
```

You can then configure the NTP servers used with the following command, where `/manualpeerlist` is a space-separated list of the NTP servers that you want to add.
```powershell
w32tm /config /manualpeerlist:"ntp.sparrow-orcinus.space" /syncfromflags:manual /update
```

## Mobile Android / Apple iOS




# Configuring a NTP Server

Here, we describe the process of creating and hosting an NTP server. There are two main methods, via `ntpd`/`ntpsec` or via `chrony`. These tutorials describe the creation of a downstream stratum 2 or higher server. As such, we do not deal with the integration of primary sources of time here like GPS or atomic clocks, for that, see [[primary ntp server]]. 

We typically use upstream NTP [stratum 1 servers](https://support.ntp.org/Servers/StratumOneTimeServers) or [stratum 2 servers](https://support.ntp.org/Servers/StratumTwoTimeServers) . You can choose your own servers, and I generally suggest [stratum 2 servers](https://support.ntp.org/Servers/StratumTwoTimeServers), as to alleviate the load from stratum 1 servers. This is the server list I usually use to support `ntp.sparrow-orcinus.space`:
```txt
server time-b.nist.gov             iburst
server tick.usno.navy.mil          iburst
server tock.usno.navy.mil          iburst

server sundial.columbia.edu        iburst
server chronos2.umt.edu            iburst
server ntp-01.caltech.edu          iburst
server rolex.usg.edu               iburst
server ns.nts.umn.edu              iburst
```
## NTPD or NTPsec

First, we need to install NTP. Note that, for the most part, `ntpsec` is just the same as NTP but with additional security enhancements. It is slowly replacing the original NTP implementation by default because of this. However, both are valid implementations. We can install either one using the typical package mangers (Debian provided below).
```shell
apt update
apt install ntp
# Or...
apt install ntpsec
```

We need to ensure that NTP traffic is allowed through the firewall. I am partial to using [`firewalld`](STAR%20Liner%20-%20Firewalld%20Configurations.md). The main port which NTP traffic goes over is `123/udp`. Ensure that the traffic is allowed through whichever firewall you use for your system.

To configure the NTP server, we need to modify the main configuration files.
```shell
# For NTP 
nano /etc/ntp.conf 
# For NTPsec 
nano /etc/ntpsec/ntp.conf
```

In these files, we need to set the upstream servers which we will fetch the time from need to be configured. They should be open access servers. As I frequent the United States, I personally use the following servers.
```txt
server time-b.nist.gov             iburst
server tick.usno.navy.mil          iburst
server tock.usno.navy.mil          iburst

server sundial.columbia.edu        iburst
server chronos2.umt.edu            iburst
server ntp-01.caltech.edu          iburst
server rolex.usg.edu               iburst
server ns.nts.umn.edu              iburst
```

We also need to ensure that the server cannot be used in NTP reflection attacks. This can be done by having the following restriction lines present in the configuration file.
```txt
# By default, exchange time with everybody, but don't allow configuration.
restrict -4 default kod notrap nomodify nopeer noquery limited
restrict -6 default kod notrap nomodify nopeer noquery limited

# Local users may interrogate the ntp server more closely.
restrict 127.0.0.1
restrict ::1
```

Finally, the NTP service can be (re)started using:
```shell
systemctl restart ntp.service
```

## Chrony

Configuring `chrony` as an NTP server mostly just involves adding a single line. We go over, briefly, however, how to add the upstream NTP servers. We can add our up-stream servers by modifying the `chrony` configuration file: `/etc/chrony.conf` or `/etc/chrony/chrony.conf`.

To add a new server to the list of NTP servers, you can add a line in the configuration file in the right area. An NTP server should have at least 5 servers as their upstream. I generally do not prefer the usage of pools as the upstream. As I frequent the United States, I personally use the following servers.
```txt
server ntp.digiutlsparrow.space iburst
```

In order to allow `chrony` to be used as an NTP server, we specify the range of IPs which `chrony` can act as an NTP server for. In the configuration file, you can designate the address subnet range with...
```txt
allow 256.256.256.256/0
```
...or, if you want to allow all connections to use the server (which should be expected if you are using this as a public server), then you can use instead...
```txt
allow all
```

Similarly, you can block address subnet ranges from using the server using:
```txt
deny 256.256.256.256/0
```

Multiple blocks of `allow` and `deny` can be used within the configuration file. The ordering of the addresses and the usage of `all` in conjunction with said ordering affects the configurations. Moreover, inputting partial addresses are valid to describe ranges of IPv4 and IPv6 address. For more information, see [`chrony.conf(5)`](https://chrony-project.org/doc/3.4/chrony.conf.html).

You can use the following to restart the service and apply the new configuration:
```shell
systemctl restart chronyd.service
```


___
Created: 2026-02-26
Last Updated: 2026-02-26