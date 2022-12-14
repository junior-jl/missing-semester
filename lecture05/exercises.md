# Exercises Lecture 05

## Job control

### 1. From what we have seen, we can use some `ps aux | grep` commands to get our jobs’ pids and then kill them, but there are better ways to do it. Start a `sleep 10000` job in a terminal, background it with `Ctrl-Z` and continue its execution with `bg`. Now use `pgrep` to find its pid and `pkill` to kill it without ever typing the pid itself. (Hint: use the `-af` flags).

Answer:

```bash
sleep 10000
```

After pressing `Ctrl-Z`:

```
[1]+  Stopped                 sleep 10000
```

```bash
bg
```

```
[1]+ sleep 10000 &
```

```bash
pgrep -af sleep
```

```
100 sleep 10000
```

```bash
pkill -f sleep
```

```
[1]+  Terminated              sleep 10000
```

### 2. Say you don’t want to start a process until another completes. How would you go about it? In this exercise, our limiting process will always be `sleep 60 &`. One way to achieve this is to use the `wait` command. Try launching the sleep command and having an `ls` wait until the background process finishes.

However, this strategy will fail if we start in a different bash session, since wait only works for child processes. One feature we did not discuss in the notes is that the `kill` command’s exit status will be zero on success and nonzero otherwise. `kill -0` does not send a signal but will give a nonzero exit status if the process does not exist. Write a bash function called `pidwait` that takes a pid and waits until the given process completes. You should use `sleep` to avoid wasting CPU unnecessarily.

Answer:

The first part of the question is done by:

```bash
sleep 60 &
wait $! && ls
```

The function:

```bash
#!/bin/bash

pidwait() {
	while kill -0 $1 2>/dev/null; do
		sleep 1
	done
	ls -l
}
```

`2>/dev/null` is used to send the STDERR to `/dev/null`.

Now, after `source pidwait.sh`:

```bash
sleep 15 &
pidwait $!
```

## Terminal multiplexer

### 1. Follow this tmux [tutorial](https://www.hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/) and then learn how to do some basic customizations following these steps.

Answer: -

## Aliases

### 1. Create an alias `dc` that resolves to `cd` for when you type it wrongly.

Answer:

```bash
alias dc=cd
```

### 2. Run `history | awk '{$1="";print substr($0,2)}' | sort | uniq -c | sort -n | tail -n 10` to get your top 10 most used commands and consider writing shorter aliases for them. Note: this works for Bash; if you’re using ZSH, use `history 1` instead of just `history`.

Answer:

Output of `history | awk '{$1="";print substr($0,2)}' | sort | uniq -c | sort -n | tail -n 10`:

```
     14 git stash
     14 jobs -l
     15 echo $z
     18 sh test1.sh
     24 vim example.sh
     25 shellcheck example.sh
     27 cat network_parameters.md
     32 vim q3.sh
     35 sh q3.sh
     50 ls
```

Aliases:

```bash
	alias l=ls
	alias ç=echo
	alias sch=shellcheck
```
