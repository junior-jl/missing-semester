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

### 5. Here are some sorting algorithm implementations. Use `cProfile` and `line_profiler` to compare the runtime of insertion sort and quicksort. What is the bottleneck of each algorithm? Use then `memory_profiler` to check the memory consumption, why is insertion sort better? Check now the inplace version of quicksort. Challenge: Use `perf` to look at the cycle counts and cache hits and misses of each algorithm.

Answer:

```bash
python3 -m cProfile -s tottime sorts.py 1000 | grep -E "quick|insertion|tottime"
```

outputs

```
   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
33690/1000    0.063    0.000    0.093    0.000 sorts.py:23(quicksort)
34148/1000    0.051    0.000    0.062    0.000 sorts.py:32(quicksort_inplace)
     1000    0.019    0.000    0.019    0.000 sorts.py:11(insertionsort)
```

To use `line_profiler`, add `@profile` before the definition of the methods. In Ubuntu, install the profiler with `sudo apt install python3-line-profiler`. The output of `kernprof -vl sorts.py` is:

```
Wrote profile results to sorts.py.lprof
Timer unit: 1e-06 s

Total time: 0.316998 s
File: sorts.py
Function: insertionsort at line 10

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
    10                                           @profile
    11                                           def insertionsort(array):
    12                                           
    13     26130      10633.0      0.4      3.4      for i in range(len(array)):
    14     25130      10174.0      0.4      3.2          j = i-1
    15     25130      11081.0      0.4      3.5          v = array[i]
    16    225906     101890.0      0.5     32.1          while j >= 0 and v < array[j]:
    17    200776      88277.0      0.4     27.8              array[j+1] = array[j]
    18    200776      83388.0      0.4     26.3              j -= 1
    19     25130      11136.0      0.4      3.5          array[j+1] = v
    20      1000        419.0      0.4      0.1      return array

Total time: 0.101665 s
File: sorts.py
Function: quicksort at line 22

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
    22                                           @profile
    23                                           def quicksort(array):
    24     33486      18985.0      0.6     18.7      if len(array) <= 1:
    25     17243       8590.0      0.5      8.4          return array
    26     16243       8579.0      0.5      8.4      pivot = array[0]
    27     16243      24446.0      1.5     24.0      left = [i for i in array[1:] if i < pivot]
    28     16243      24961.0      1.5     24.6      right = [i for i in array[1:] if i >= pivot]
    29     16243      16104.0      1.0     15.8      return quicksort(left) + [pivot] + quicksort(right)

Total time: 0.274894 s
File: sorts.py
Function: quicksort_inplace at line 31

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
    31                                           @profile
    32                                           def quicksort_inplace(array, low=0, high=None):
    33     33700      16371.0      0.5      6.0      if len(array) <= 1:
    34        39         18.0      0.5      0.0          return array
    35     33661      14781.0      0.4      5.4      if high is None:
    36       961        450.0      0.5      0.2          high = len(array)-1
    37     33661      14868.0      0.4      5.4      if low >= high:
    38     17311       6960.0      0.4      2.5          return array
    39                                           
    40     16350       7199.0      0.4      2.6      pivot = array[high]
    41     16350       7370.0      0.5      2.7      j = low-1
    42    124357      56760.0      0.5     20.6      for i in range(low, high):
    43    108007      49803.0      0.5     18.1          if array[i] <= pivot:
    44     56455      24903.0      0.4      9.1              j += 1
    45     56455      28694.0      0.5     10.4              array[i], array[j] = array[j], array[i]
    46     16350       9408.0      0.6      3.4      array[high], array[j+1] = array[j+1], array[high]
    47     16350      14954.0      0.9      5.4      quicksort_inplace(array, low, j)
    48     16350      14788.0      0.9      5.4      quicksort_inplace(array, j+2, high)
    49     16350       7567.0      0.5      2.8      return array
```

With this, we can see that the bottlenecks are the rows with more time percentage (usually the loops and array accessing lines).

Installing the memory_profiler with `sudo apt-get install python3-memory-profiler`. Something went wrong with the operation of the profiler using the command ``python3 -m memory_profiler sorts.py`.


### 6. Here’s some (arguably convoluted) Python code for computing Fibonacci numbers using a function for each number.

```python
#!/usr/bin/env python
def fib0(): return 0

def fib1(): return 1

s = """def fib{}(): return fib{}() + fib{}()"""

if __name__ == '__main__':

    for n in range(2, 10):
        exec(s.format(n, n-1, n-2))
    # from functools import lru_cache
    # for n in range(10):
    #     exec("fib{} = lru_cache(1)(fib{})".format(n, n))
    print(eval("fib9()"))
```

Put the code into a file and make it executable. Install prerequisites: `pycallgraph` and `graphviz`. (If you can run `dot`, you already have GraphViz.) Run the code as is with `pycallgraph graphviz -- ./fib.py` and check the `pycallgraph.png` file. How many times is `fib0` called?. We can do better than that by memoizing the functions. Uncomment the commented lines and regenerate the images. How many times are we calling each `fibN` function now?

Answer:

```bash
pycallgraph graphviz -- ./fib.py
```

![pycallgraph](https://user-images.githubusercontent.com/69206952/206306078-dc0aabe3-6a8d-4023-b7cf-d5590f5975da.png)

`fib0` is called 21 times.

After uncommenting the lines:


![pycallgraph](https://user-images.githubusercontent.com/69206952/206306547-21d2f099-ef5b-44db-b790-054a91285693.png)


### 7. A common issue is that a port you want to listen on is already taken by another process. Let’s learn how to discover that process pid. First execute `python -m http.server 4444` to start a minimal web server listening on port `4444`. On a separate terminal run `lsof | grep LISTEN` to print all listening processes and ports. Find that process pid and terminate it by running `kill <PID>`.

Answer:

```bash
python3 -m http.server 4444
```

```
Serving HTTP on 0.0.0.0 port 4444 (http://0.0.0.0:4444/) ...
```

The command `lsof | grep LISTEN` is not working. But since the focus is to kill the process by the PID, I executed

```bash
python -m http.server 4444 &
```

Because of the & symbol, it executes in the background. Now, executing `jobs -l`:

![image](https://user-images.githubusercontent.com/69206952/206311573-c85b8d88-fe0a-4b27-97ba-75fd45630f56.png)

```bash
kill 19464
```

```
[3]+ 19464 Terminated              python3 -m http.server 4444
```

### 8. Limiting processes resources can be another handy tool in your toolbox. Try running `stress -c 3` and visualize the CPU consumption with `htop`. Now, execute `taskset --cpu-list 0,2 stress -c 3` and visualize it. Is stress taking three CPUs? Why not? Read `man taskset`. Challenge: achieve the same using `cgroups`. Try limiting the memory consumption of `stress -m`.

Answer:

```bash
stress -c 3
```

![image](https://user-images.githubusercontent.com/69206952/206312450-e350d339-13a4-4487-b595-bb0833d6256c.png)

```bash
taskset --cpu-list 0,2 stress -c 3
```

![image](https://user-images.githubusercontent.com/69206952/206312635-a07cda25-7b85-4458-8696-068496958172.png)

