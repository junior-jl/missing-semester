# Exercises Lecture 02

### 1. Read man `ls` and write an `ls` command that lists files in the following manner

- Includes all files, including hidden files
- Sizes are listed in human readable format (e.g. 454M instead of 454279954)
- Files are ordered by recency
- Output is colorized
A sample output would look like this:

```
 -rw-r--r--   1 user group 1.1M Jan 14 09:53 baz
 drwxr-xr-x   5 user group  160 Jan 14 09:53 .
 -rw-r--r--   1 user group  514 Jan 14 06:42 bar
 -rw-r--r--   1 user group 106M Jan 13 12:12 foo
 drwx------+ 47 user group 1.5K Jan 12 18:08 ..
```

Answer:

```
ls -altch --color
```

(a) lists hidden files, (l) uses a long list format, (h) is the human readable option, (c) sorts the list by time (with -lt) and (--color) colorize the output.

Output:

```
total 160K
drwxr-xr-x 1 junior junior 4.0K Dec  2 19:01 missing-semester
-rw-r--r-- 1 junior junior   21 Dec  2 18:42 last-modified.txt
drwxr-xr-x 1 junior junior 4.0K Dec  2 18:42 .
-rw------- 1 junior junior  22K Dec  2 16:37 .viminfo
-rw------- 1 junior junior  20K Dec  2 16:07 .bash_history
-rw-r--r-- 1 junior junior    0 Dec  2 16:07 .motd_shown
-rw-r--r-- 1 junior junior    4 Dec  2 14:58 teste2.txt
-rw-r--r-- 1 junior junior    4 Dec  2 14:58 teste.txt
drwxr-xr-x 1 junior junior 4.0K Dec  2 14:55 .tldr
drwxr-xr-x 1 junior junior 4.0K Dec  2 14:38 .npm
drwxr-xr-x 1 junior junior 4.0K Dec  2 14:38 .config
drwxr-xr-x 1 junior junior 4.0K Nov 13 19:16 netsquid-pt-br
-rw------- 1 junior junior 5.0K Nov  9 14:39 .python_history
-rw-r--r-- 1 junior junior  21K Nov  8 19:36 grafico.png
drwxr-xr-x 1 junior junior 4.0K Nov  8 19:34 .cache
-rw-r--r-- 1 junior junior   55 Oct  6 01:23 .gitconfig
drwxr-xr-x 1 junior junior 4.0K Sep 27 23:40 studying-quantum-computing
drwx------ 1 junior junior 4.0K Jun 21 22:19 .local
-rw-r--r-- 1 junior junior 2.1K Jun 21 16:25 0telepsimples.py.save
-rw-r--r-- 1 junior junior 2.3K Jun 21 14:43 1entidadesPingPong.py
-rw-r--r-- 1 junior junior 2.1K Jun 21 14:01 0telepsimples.py
-rw------- 1 junior junior  964 Jun 21 12:25 example_tp.py
-rw-r--r-- 1 junior junior   79 Jun 20 21:53 qubits1.py
-rw-r--r-- 1 junior junior  20K Jun 20 19:08 fig.png
-rw-r--r-- 1 junior junior  17K Jun 20 19:07 telp.py
-rw-r--r-- 1 junior junior 3.0K Jun 20 16:44 pingpongtutorial.py
-rw-r--r-- 1 junior junior  717 Jun 19 23:27 pingpong.py
-rw-r--r-- 1 junior junior   22 Jun 19 22:01 hello.py
-rw-r--r-- 1 junior junior    0 Jun 19 21:24 .sudo_as_admin_successful
drwxr-xr-x 1 junior junior 4.0K Jun 19 21:23 .landscape
-rw-r--r-- 1 junior junior  807 Jun 19 21:23 .profile
-rw-r--r-- 1 junior junior  220 Jun 19 21:23 .bash_logout
-rw-r--r-- 1 junior junior 3.7K Jun 19 21:23 .bashrc
drwxr-xr-x 1 root   root   4.0K Jun 19 21:23 ..
```

### 2. Write bash functions `marco` and `polo` that do the following. Whenever you execute `marco` the current working directory should be saved in some manner, then when you execute `polo`, no matter what directory you are in, `polo` should `cd` you back to the directory where you executed marco. For ease of debugging you can write the code in a file `marco.sh` and (re)load the definitions to your shell by executing `source marco.sh`.

Answer:

```
#!/bin/usr/env bash
marco () {
        cur=$(pwd)
        export cur
}

polo () {
        cd $cur
```
