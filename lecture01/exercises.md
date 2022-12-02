# Exercises Lecture 01

### 1. For this course, you need to be using a Unix shell like Bash or ZSH. If you are on Linux or macOS, you don’t have to do anything special. If you are on Windows, you need to make sure you are not running cmd.exe or PowerShell; you can use Windows Subsystem for Linux or a Linux virtual machine to use Unix-style command-line tools. To make sure you’re running an appropriate shell, you can try the command `echo $SHELL`. If it says something like `/bin/bash` or `/usr/bin/zsh`, that means you’re running the right program.

Answer: 
```
echo $SHELL
```
Output:
```
/bin/bash
```

### 2. Create a new directory called `missing` under `/tmp`.

Answer: 
```
mkdir /tmp/missing
```


### 3. Look up the `touch` program. The `man` program is your friend.

Answer: 
```
man touch
```
Output:
```
TOUCH(1)                                    User Commands                                   TOUCH(1)

NAME
       touch - change file timestamps

SYNOPSIS
       touch [OPTION]... FILE...

DESCRIPTION
       Update the access and modification times of each FILE to the current time.

       A FILE argument that does not exist is created empty, unless -c or -h is supplied.

       A  FILE argument string of - is handled specially and causes touch to change the times of the
       file associated with standard output.

       Mandatory arguments to long options are mandatory for short options too.

       -a     change only the access time

       -c, --no-create
              do not create any files

       -d, --date=STRING
              parse STRING and use it instead of current time

       -f     (ignored)

       -h, --no-dereference
              affect each symbolic link instead of any referenced file (useful only on systems  that
              can change the timestamps of a symlink)

       -m     change only the modification time

       -r, --reference=FILE
              use this file's times instead of current time

       -t STAMP
              use [[CC]YY]MMDDhhmm[.ss] instead of current time

       --time=WORD
              change  the  specified  time:  WORD is access, atime, or use: equivalent to -a WORD is
              modify or mtime: equivalent to -m

       --help display this help and exit

       --version
              output version information and exit

       Note that the -d and -t options accept different time-date formats.

DATE STRING
       The --date=STRING is a mostly free format human readable date string such  as  "Sun,  29  Feb
       2004  16:21:42  -0800"  or  "2004-02-29 16:21:42" or even "next Thursday".  A date string may
       contain items indicating calendar date, time of day, time zone, day of week,  relative  time,
       relative  date,  and  numbers.  An empty string indicates the beginning of the day.  The date
       string format is more complex than is easily documented here but is fully  described  in  the
       info documentation.

AUTHOR
       Written by Paul Rubin, Arnold Robbins, Jim Kingdon, David MacKenzie, and Randy Smith.

REPORTING BUGS
       GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
       Report touch translation bugs to <https://translationproject.org/team/>

COPYRIGHT
       Copyright  ©  2018 Free Software Foundation, Inc.  License GPLv3+: GNU GPL version 3 or later
       <https://gnu.org/licenses/gpl.html>.
       This is free software: you are free to change and redistribute it.  There is NO WARRANTY,  to
       the extent permitted by law.

SEE ALSO
       Full documentation at: <https://www.gnu.org/software/coreutils/touch>
       or available locally via: info '(coreutils) touch invocation'

GNU coreutils 8.30                         September 2019                                   TOUCH(1)
```


### 4. Use `touch` to create a new file called `semester` in `missing`.

Answer: 
```
touch /tmp/missing/semester
```


### 5. Write the following into that file, one line at a time:

```
#!/bin/sh
curl --head --silent https://missing.csail.mit.edu
```

Answer: 
```
echo \#\!/bin/sh > /tmp/missing/semester
echo 'curl --head --silent https://missing.csail.mit.edu' >> /tmp/missing/semester
```


### 6. Try to execute the file, i.e. type the path to the script (`./semester`) into your shell and press enter. Understand why it doesn’t work by consulting the output of `ls` (hint: look at the permission bits of the file).

Answer: 
```
./semester
```
Output:
```
-bash: ./semester: Permission denied
```

The output of `ls -l` shows the following string as permissions `-rw-r--r--`. It means that no user has permission to execute the file.

### 7. Run the command by explicitly starting the `sh` interpreter, and giving it the file semester as the first argument, i.e. `sh semester`. Why does this work, while `./semester` didn’t?

Answer: 
`sh semester` calls the program `sh` with the argument `semester`, interpreting the file.

### 8. Look up the `chmod` program (e.g. use `man chmod`).

Answer: 
```
man chmod
```
Output:
```
CHMOD(1)                                                User Commands                                               CHMOD(1)

NAME
       chmod - change file mode bits

SYNOPSIS
       chmod [OPTION]... MODE[,MODE]... FILE...
       chmod [OPTION]... OCTAL-MODE FILE...
       chmod [OPTION]... --reference=RFILE FILE...

DESCRIPTION
       This  manual  page documents the GNU version of chmod.  chmod changes the file mode bits of each given file according
       to mode, which can be either a symbolic representation of changes to make, or an octal number  representing  the  bit
       pattern for the new mode bits.

       The  format  of a symbolic mode is [ugoa...][[-+=][perms...]...], where perms is either zero or more letters from the
       set rwxXst, or a single letter from the set ugo.  Multiple symbolic modes can be given, separated by commas.

       A combination of the letters ugoa controls which users' access to the file will be changed: the user who owns it (u),
       other users in the file's group (g), other users not in the file's group (o), or all users (a).  If none of these are
       given, the effect is as if (a) were given, but bits that are set in the umask are not affected.

       The operator + causes the selected file mode bits to be added to the existing file mode bits of each file;  -  causes
       them to be removed; and = causes them to be added and causes unmentioned bits to be removed except that a directory's
       unmentioned set user and group ID bits are not affected.

       The letters rwxXst select file mode bits for the affected users: read (r), write (w), execute (or search for directo‐
       ries)  (x),  execute/search  only if the file is a directory or already has execute permission for some user (X), set
       user or group ID on execution (s), restricted deletion flag or sticky bit (t).  Instead of one or more of these  let‐
       ters,  you can specify exactly one of the letters ugo: the permissions granted to the user who owns the file (u), the
       permissions granted to other users who are members of the file's group (g), and the permissions granted to users that
       are in neither of the two preceding categories (o).

       A  numeric mode is from one to four octal digits (0-7), derived by adding up the bits with values 4, 2, and 1.  Omit‐
       ted digits are assumed to be leading zeros.  The first digit selects the set user ID (4) and set group ID (2) and re‐
       stricted  deletion  or  sticky  (1) attributes.  The second digit selects permissions for the user who owns the file:
       read (4), write (2), and execute (1); the third selects permissions for other users in the  file's  group,  with  the
       same values; and the fourth for other users not in the file's group, with the same values.

       chmod  never  changes the permissions of symbolic links; the chmod system call cannot change their permissions.  This
       is not a problem since the permissions of symbolic links are never used.  However, for each symbolic link  listed  on
       the  command  line,  chmod changes the permissions of the pointed-to file.  In contrast, chmod ignores symbolic links
       encountered during recursive directory traversals.

SETUID AND SETGID BITS
       chmod clears the set-group-ID bit of a regular file if the file's group ID does not match the user's effective  group
       ID or one of the user's supplementary group IDs, unless the user has appropriate privileges.  Additional restrictions
       may cause the set-user-ID and set-group-ID bits of MODE or RFILE to be ignored.  This behavior depends on the  policy
       and functionality of the underlying chmod system call.  When in doubt, check the underlying system behavior.

       For  directories  chmod preserves set-user-ID and set-group-ID bits unless you explicitly specify otherwise.  You can
       set or clear the bits with symbolic modes like u+s and g-s.  To clear these bits for directories with a numeric  mode
       requires an additional leading zero, or leading = like 00755 , or =755

RESTRICTED DELETION FLAG OR STICKY BIT
       The  restricted  deletion flag or sticky bit is a single bit, whose interpretation depends on the file type.  For di‐
       rectories, it prevents unprivileged users from removing or renaming a file in the directory unless they own the  file
       or  the  directory;  this  is  called the restricted deletion flag for the directory, and is commonly found on world-
       writable directories like /tmp.  For regular files on some older systems, the bit saves the program's text  image  on
       the swap device so it will load more quickly when run; this is called the sticky bit.

OPTIONS
       Change the mode of each FILE to MODE.  With --reference, change the mode of each FILE to that of RFILE.

       -c, --changes
              like verbose but report only when a change is made

       -f, --silent, --quiet
              suppress most error messages

       -v, --verbose
              output a diagnostic for every file processed

       --no-preserve-root
              do not treat '/' specially (the default)

       --preserve-root
              fail to operate recursively on '/'

       --reference=RFILE
              use RFILE's mode instead of MODE values

       -R, --recursive
              change files and directories recursively

       --help display this help and exit

       --version
              output version information and exit

       Each MODE is of the form '[ugoa]*([-+=]([rwxXst]*|[ugo]))+|[-+=][0-7]+'.

AUTHOR
       Written by David MacKenzie and Jim Meyering.

REPORTING BUGS
       GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
       Report chmod translation bugs to <https://translationproject.org/team/>

COPYRIGHT
       Copyright  ©  2018  Free  Software  Foundation, Inc.  License GPLv3+: GNU GPL version 3 or later <https://gnu.org/li‐
       censes/gpl.html>.
       This is free software: you are free to change and redistribute it.  There is NO WARRANTY, to the extent permitted  by
       law.

SEE ALSO
       chmod(2)

       Full documentation at: <https://www.gnu.org/software/coreutils/chmod>
       or available locally via: info '(coreutils) chmod invocation'

GNU coreutils 8.30                                     September 2019                                               CHMOD(1)
```

### 9. Use chmod to make it possible to run the command `./semester` rather than having to type `sh semester`. How does your shell know that the file is supposed to be interpreted using `sh`?

Answer: 
```
chmod u+x semester
```
This line gives the user that owns the file permission to execute it. The shell knows to use `sh` because of the first line `#!/bin/sh`. It means that the file will be interpreted by `sh`, which is located at `/bin/sh`



### 10. Use `|` and `>` to write the “last modified” date output by semester into a file called `last-modified.txt` in your home directory.

Answer: 
```
./semester | head -n4 | tail -n1 > ~/last-modified.txt
```
The line I want is the fourth, `head` is used to get the first 4 lines of output and `tail` is used to get the last of the four. After that `>` is used to output that into the `~/last-modified.txt` file, that is created in the home (~) directory.


### 11. Write a command that reads out your laptop battery’s power level or your desktop machine’s CPU temperature from `/sys`. Note: if you’re a macOS user, your OS doesn’t have sysfs, so you can skip this exercise.

Answer: 
```
cat /sys/class/power_supply/battery/charge_counter
```
Output:
```
2971
```