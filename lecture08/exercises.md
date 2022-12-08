# Exercises Lecture 08

### 1. Most makefiles provide a target called `clean`. This isn’t intended to produce a file called `clean`, but instead to clean up any files that can be re-built by make. Think of it as a way to “undo” all of the build steps. Implement a `clean` target for the `paper.pdf` `Makefile` above. You will have to make the target phony. You may find the `git ls-files` subcommand useful. A number of other very common make targets are listed here.

Answer:

To install `pdflatex` in Ubuntu, run:

```bash
sudo apt-get install texlive-latex-base
sudo apt-get install texlive-fonts-recommended
sudo apt-get install texlive-fonts-extra
sudo apt-get install texlive-latex-extra
```

The Makefile was:

```Makefile
paper.pdf: paper.tex plot-data.png
	pdflatex paper.tex

plot-%.png: %.dat plot.py
	./plot.py -i $*.dat -o $@
```

`plot.py`:

```python
#!/usr/bin/env python3
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-i', type=argparse.FileType('r'))
parser.add_argument('-o')
args = parser.parse_args()

data = np.loadtxt(args.i)
plt.plot(data[:, 0], data[:, 1])
plt.savefig(args.o)
```

`paper.tex`:

```tex
\documentclass{article}
\usepackage{graphicx}
\begin{document}
\includegraphics[scale=0.65]{plot-data.png}
\end{document}
```

Given the necessary permissions to `plot.py` to be executed, before running make, execute `git add -A` to track the current files. After running `make`, the command `ls | grep paper` returns the following:

```
paper.aux
paper.log
paper.pdf
paper.tex
```

Adding the following lines to `Makefile`:

```Makefile
.PHONY: clean
clean:
	git ls-files -o | xargs rm -f
```

Because `clean` is declared a phony target, everytime `make clean` is executed, `git ls-files -o | xargs rm -f` will be executed. `git ls-files -o` outputs all filenames that are untracked by git. So after running `make clean`, every file that can be recreated by `make` is removed. Now running `ls | grep paper | clip.exe`, the output is only

```
paper.tex
```

