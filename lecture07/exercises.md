# Exercises Lecture 07

### 1. Use `journalctl` on Linux or `log show` on macOS to get the super user accesses and commands in the last day. If there aren’t any you can execute some harmless commands such as `sudo ls` and check again.

Answer: I will answer when I install a VM.

### 2. Do this hands on `pdb` tutorial to familiarize yourself with the commands

Answer: 

```
git clone https://github.com/spiside/pdb-tutorial
```

### 3. Install `shellcheck` and try checking the following script. What is wrong with the code? Fix it. Install a linter plugin in your editor so you can get your warnings automatically.

```bash
#!/bin/sh
## Example: a typical script with several problems
for f in $(ls *.m3u)
do
  grep -qi hq.*mp3 $f \
    && echo -e 'Playlist $f contains a HQ file in mp3 format'
done
```

Answer: `shellcheck` is already installed.

```bash
shellcheck example.sh
```

![image](https://user-images.githubusercontent.com/69206952/206267267-233ae5da-e5cf-41b5-b624-1797357c1f86.png)

The links provided in the image are very helpful. To solve the issues:

- On line 3, `$(ls *.m3u)` to just `*.m3u`;
- On line 5, `hq.*mp3 $f` to `"hq.*mp3" "$f";
- On the first line, change `sh` to `bash`;
- On line 6, change the single quotes to double quotes.

### 4. (Advanced) Read about reversible debugging and get a simple example working using `rr` or `RevPDB`.

Answer: TODO!
