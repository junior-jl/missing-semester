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

### 2. ake a look at the various ways to specify version requirements for dependencies in Rust’s build system. Most package repositories support similar syntax. For each one (caret, tilde, wildcard, comparison, and multiple), try to come up with a use-case in which that particular kind of requirement makes sense.

Answer:

- Caret: `^1.2.3` means that it is mandatory to have the 1.2.3 version.
- Tilde: specifies a minimal version, so `~1.2.3` means that you need a version greater or equal to 1.2.3 and lesser than 1.3.0; `~1.2` needs a greater or equal version to 1.2.0 andd lesser than 1.3.0.
- Wildcard: `1.*` allows any version from 1.0.0 to 2.0.0 (but not 2.0.0).
- Comparison: `>= 1.2.0` is saying that you need a greater version than 1.2.0; `= 1.2.3` needs the 1.2.3 version exactly. Pretty straightforward.
- Multiple: comparison requirements separated by commas, specifies a range of requirements.

### 3. Git can act as a simple CI system all by itself. In `.git/hooks` inside any git repository, you will find (currently inactive) files that are run as scripts when a particular action happens. Write a `pre-commit` hook that runs `make paper.pdf` and refuses the commit if the `make` command fails. This should prevent any commit from having an unbuildable version of the paper.

Answer: TODO!

### 4. Set up a simple auto-published page using GitHub Pages. Add a GitHub Action to the repository to run `shellcheck` on any shell files in that repository (here is one way to do it). Check that it works!

Answer: TODO! Publish this repo as a GitHub Page.

### 5. Build your own GitHub action to run `proselint` or `write-good` on all the `.md` files in the repository. Enable it in your repository, and check that it works by filing a pull request with a typo in it.

Answer: TODO!
