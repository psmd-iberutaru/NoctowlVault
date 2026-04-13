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
# Rsync Overview

Rsync is a powerful command-line tool to copy files from different (Linux) machines, either locally or over a network. Often, its primary use case is to ensure that two directories are considered synced. Over more common tools like `scp` or `sftp`, the syncing of `rsync` does proper differing of the syncing directories and has a lot of different flags for different options. Here, we list the common flag usages, assuming some general familiarity with `scp` or `rsync` syntax; but a good typical default is:

```shell
rsync -avhzP ./source ./destination
```

This copies the source to the destination in archive mode (retaining permissions, subdirectories, and other metadata), with added compression, and with verbose output in a human readable form. 

#### Remote Servers

Rsync is primarily for remote syncing (hence its name), so it should be no surprise that it is easy to sync between remote servers using it.

```shell
rsync [options]  user1@eastremote:/path/to/src  user2@westremost:/path/to/dest
```

With the options provided of course, by other sections in this post.

## Test (Dry) Run

A dry run is a test, checking what a script would do without actually doing anything. In the case of `rsync` dry runs are used to ensure the copying is correct. Otherwise, an incorrect copy may then entail the careful deletion of incorrectly copied files.

```shell
rsync [options] -v --dry-run ./source ./destination
```

Optionally, the `-n` can be used as a more terse flag, though I prefer the explicitness otherwise. Moreover, being verbose is helpful to the idea of a dry run: making sure everything is correct.

## Transfer Progress

Knowing the transfer progress can be done with two flags in two different ways with `rsync`:
- `--progress`: Provides transfer information for the entire transfer.
- `--info=progress2`: Provides transfer on a per-file basis.

There is also the `-P` flag, but this flag is just an alias for `--progress --partial`, where `--partial` is useful to save partially transferred files so the transfer may be resumed if needed.

## Destination File (Postponed) Deletion

If files are not present in the source directory, but are present in the destination, if specific flags are in place, the destination files may be deleted to ensure the synchronicity of the two directories. By default, `rsync` typically does not delete files (but it does overwrite them). When the files are deleted (before, after, etc.) is something that can be controlled by flags. 

```shell
rsync [options] --delete ./source ./destination
```

The `--delete` flag deletes the files in the destination directory which do not exist in the source, with `rsync` assuming the best method. The specific method can specified by the following flags instead of the `--delete` flag:
- `--del` or `--delete-during`: Delete extra destination files during the transfer as the files are being copied. This is typically the fastest and more efficient option, especially for large transfers.
- `--delete-before`: Delete extra destination files before the transfer starts.
- `--delete-after`: Delete extra destination files after the transfer finishes.
- `--delete-delay`: During the transfer, extra destination files are marked for deletion, but the deletion only occurs after the transfer.
Files can also be excluded from deletion using `--delete-excluded`.

Typically, I am partial to `--delete-after` (and sometimes `--delete-delay`) for server-to-server transfers. Often, during transfers, especially those which are slow or likely to be interrupted a lot, I prefer to make sure that all of the files are copied properly before deleting data at the destination.

## Data Backup and Archiving

For cases when data is being backed up or archived from a source directory to a destination directory, it may be important to keep different versions of files in the backup destination directory. Typically `rsync` would overwrite the files but we can specify 

```shell
rsync -avhzP --backup --backup-dir=/path/to/backup  ./source  ./destination
```

Here, should there be any files in the source destination which conflict with the destination (such as an updated file), then the old file in the destination will be moved to the backup directory specified instead of getting overwritten. Though the backup directory can be anything, it being a date of the transfer is probably decent practice; and keeping it close with the original destination is probably a good idea.

Also, instead of using an entire directory for the duplicate copies, a file extension can be used to indicate the older destination file. This suffix extension can be specified by the `--suffix` flag.

```shell
rsync -avhzP --backup --suffix="_old"  ./source  ./destination
```

## Copying Files (No Syncing)

Sometimes, a synchronized destination directory is not what is wanted. There are cases where files should be copied, but the file system meta information (like permissions and read times) are not needed. This is not always common, but when copying between different file systems (i.e. between Window's NTFS and Linux's ext4), this type of copy is helpful as file system specifics are not included in the copy. This can be done in `rsync`:

```shell
rsync -rlvhzc --mkpath --open-noatime --info=progress2 ./source ./destination
```


## Legacy Systems

Rsync, when communicating between servers, utilizes `ssh` connections.  As `ssh` is a security conservative package, older and weaker connection parameter algorithms are not enabled by default. This can be a problem for `rsync` as if `ssh` cannot make a remote connection, no files can be transferred. 

In order to allow `ssh` to make a connection, additional parameters need to be passed to it via the `rsync` parameter `-e`. Two common parameters which may need changing are the host key algorithm and the key exchange algorithm. Additional algorithms for these can be specified by the following.

```shell
rsync -e "ssh -oHostKeyAlgorithms=+key-algo -oKexAlgorithms=+exchange-algo" ./source ./destination
```

More detail on options that can be passed to `ssh`, including more detailed information on the connection parameter algorithm matching, can be found in our `ssh` informational: [STAR Liner - Common SSH Flags](STAR%20Liner/STAR%20Liner%20-%20Common%20SSH%20Flags.md). 



___
Created: 2025-12-31
Last Updated: 2025-12-31