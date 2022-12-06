# Exercises Lecture 04

### 1. Take this short [interactive regex tutorial](https://regexone.com/).

Answer:

```
- Lesson 1 - abc
- Lesson 1.5 - 123
- Lesson 2 - ...\.
- Lesson 3 - [cmf]an
- Lesson 4 - [^b]og
- Lesson 5 - [A-C][n-p][a-c]
- Lesson 6 - waz{3,5}up
- Lesson 7 - aa+b*c+
- Lesson 8 - \d* files? found\?
- Lesson 9 - \d+\.\s+abc
- Lesson 10 - ^Mission: successful$
- Lesson 11 - ^(file_.+).pdf$
- Lesson 12 - ([A-Z][a-z]{2} (\d{4}))
- Lesson 13 - (\d+)x(\d+)
- Lesson 14 - I love (cats|dogs)
- Lesson 15 - .*
```

### 2. Find the number of words (in `/usr/share/dict/words`) that contain at least three `a`s and don’t have a `'s` ending. What are the three most common last two letters of those words? `sed`’s `y` command, or the `tr` program, may help you with case insensitivity. How many of those two-letter combinations are there? And for a challenge: which combinations do not occur?

Answer: TODO!
```
cat /usr/share/dict/words | grep "^(.*?a.*?){3}[^(\'s)]$"
```

### 3. To do in-place substitution it is quite tempting to do something like `sed s/REGEX/SUBSTITUTION/ input.txt > input.txt`. However this is a bad idea, why? Is this particular to `sed`? Use `man sed` to find out how to accomplish this.

Answer: TODO!

### 4. Find your average, median, and max system boot time over the last ten boots. Use `journalctl` on Linux and `log show` on macOS, and look for log timestamps near the beginning and end of each boot. On Linux, they may look something like:

```
Logs begin at ...
```
and

```
systemd[577]: Startup finished in ...
```

Answer: WSL doesn't permit this. TODO when in CentOS. But it's probably something that starts with

```
journalctl 
 | grep "systemd\[\d+\]: Startup finished in"
 | tail -n10
```

### 5. Look for boot messages that are not shared between your past three reboots (see `journalctl’s -b` flag). Break this task down into multiple steps. First, find a way to get just the logs from the past three boots. There may be an applicable flag on the tool you use to extract the boot logs, or you can use `sed '0,/STRING/d'` to remove all lines previous to one that matches `STRING`. Next, remove any parts of the line that always varies (like the timestamp). Then, de-duplicate the input lines and keep a count of each one (`uniq` is your friend). And finally, eliminate any line whose count is 3 (since it was shared among all the boots).

Answer: Same as previous question

### 6. Find an online data set like this one, this one, or maybe one from here. Fetch it using curl and extract out just two columns of numerical data. If you’re fetching HTML data, pup might be helpful. For JSON data, try jq. Find the min and max of one column in a single command, and the difference of the sum of each column in another.

Answer: TODO!
