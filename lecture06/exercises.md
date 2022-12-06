# Exercises Lecture 06

### 1. If you don't have any past experience with git, either try reading the first couple chapters of Pro Git or go through a tutorial like Learn Git Branching. As you're working through it, relate Git commands to the data model.

Answer: 

![image](https://user-images.githubusercontent.com/69206952/205943532-2d645757-8ba4-40e4-b538-7cbbc882d942.png)

### 2. Clone the repository for the class website. 
  1. Explore the version history by visualizing it as a graph.
  2. Who was the last person to modify `README.md`? (Hint: use `git log` with an argument).
  3. What was the commit message associated with the last modification to the `collections:` line of `_config.yml`? (Hint: use `git blame` and `git show`).
  
Answer:

```bash
mkdir repo_course_missing_semester
cd repo_course_missing_semester
git clone https://github.com/missing-semester/missing-semester
```

Visualizing the history as a graph:

```bash
cd missing-semester/
git log --all --graph --decorate --oneline
```

![image](https://user-images.githubusercontent.com/69206952/205946840-b08eafd6-1677-4b4a-8e15-a0e484ef92ac.png)

Last person to modify `README.md`: `git log README.md | grep Author | head -n1`

```
Author: Anish Athalye <me@anishathalye.com>
```

Commit message associated with the last modification to the collections: line of `_config.yml`:

```bash
git blame _config.yml
```

![image](https://user-images.githubusercontent.com/69206952/205947956-64a31f96-c676-4451-99c5-61ab9a102a28.png)

```bash
git show a88b4eac
```

![image](https://user-images.githubusercontent.com/69206952/205948222-7e9fedcf-acc3-4e09-9a5a-eecfb9338aa7.png)

### 3. One common mistake when learning Git is to commit large files that should not be managed by Git or adding sensitive information. Try adding a file to a repository, making some commits and then deleting that file from history.

Answer:

Entering another repo and adding some files:

```bash
cd ~/studying-quantum-computing
vim sensitive.txt
vim okfile.txt
git add .
git commit -m 'Add okfile and some sensitive information that shouldnt be commited'
```

Installing bfg:

```bash
sudo apt-get update
sudo apt-get install default-jre
chmod 777 ~/bfg-1.14.0.jar
alias bfg='java -jar ~/bfg-1.14.0.jar'
```

Detaching head to another commit because `bfg` doesn't allow deletion on the HEAD commit (protected).

```bash
git checkout 5a362
```

Deleting sensitive file

```bash
bfg --delete-files sensitive.txt
git checkout main
git push --force
```

```

Using repo : /home/junior/studying-quantum-computing/.git

Found 44 objects to protect
Found 4 commit-pointing refs : HEAD, refs/heads/main, refs/remotes/origin/HEAD, refs/remotes/origin/main

Protected commits
-----------------

These are your protected commits, and so their contents will NOT be altered:

 * commit 5a362aa0 (protected by 'HEAD')

Cleaning
--------

Found 73 commits
Cleaning commits:       100% (73/73)
Cleaning commits completed in 90 ms.

Updating 2 Refs
---------------

        Ref                        Before     After
        ----------------------------------------------
        refs/heads/main          | 08ddf967 | a7b382f8
        refs/remotes/origin/main | 08ddf967 | a7b382f8

Updating references:    100% (2/2)
...Ref update completed in 26 ms.

Commit Tree-Dirt History
------------------------

        Earliest                                              Latest
        |                                                          |
        ...........................................................D

        D = dirty commits (file tree fixed)
        m = modified commits (commit message or parents changed)
        . = clean commits (no changes to file tree)

                                Before     After
        -------------------------------------------
        First modified commit | 08ddf967 | a7b382f8
        Last dirty commit     | 08ddf967 | a7b382f8

Deleted files
-------------

        Filename        Git id
        --------------------------------
        sensitive.txt | b2c3164e (50 B )


In total, 2 object ids were changed. Full details are logged here:

        /home/junior/studying-quantum-computing.bfg-report/2022-12-06/12-23-08

BFG run is complete! When ready, run: git reflog expire --expire=now --all && git gc --prune=now --aggressive
```

The commit doesn't have the sensitive file anymore:

![image](https://user-images.githubusercontent.com/69206952/205954423-f83c9349-7493-4413-b072-cdac669cfae3.png)

### 4. Clone some repository from GitHub, and modify one of its existing files. What happens when you do `git stash`? What do you see when running `git log --all --oneline`? Run `git stash pop` to undo what you did with `git stash`. In what scenario might this be useful?

Answer: This is the content of the file `network_parameters.md` on my repo `studying_quantum_computing` (gathered using `cat network_parameters | clip.exe`:

````
# Nós

- Boolean: end_node
- Boolean: quantico
- Boolean: memoria
- id
- taxa_minima
- ruido_operacoes
- decoerencia
- geracao
- destilaçao
- lat (?)
- long (?)

```py
class No(object):
    def __init__(self, id = '', taxa_minima = 0 , ruido_operacoes = 0, decoerencia = 0, geracao = 1, lat = 0, long = 0, end_node = False,
                 quantico = True, memoria = False):
        self.id = id

    def distanciaEntreNos(self, alvo):
        # import geopy.distance
        coords_1 = (self.lat, self.long)
        coords_2 = (alvo.lat, alvo.long)

        print(geopy.distance.geodesic(coords_1, coords_2).km)
```

# Canais

- Boolean: quantico
- id
- comprimento
- [unidade]
- delay (ms)
- ocupado
- registro_swap

## Netsquid

- Modelo de delay (Q e C)
- Modelo de ruído (Q e C)
- Modelo de perdas (Q e C)
```py
class Canal(object):
  def __init__(self, id, comprimento, quantico = True, unidade = 'km', ocupado = False, registro_swap = []):
    self.id = id
    self.comprimento = comprimento
    self.delay = 3e8/self.comprimento
```
````

Suppose I want to write `blabla` at the end of the file, but I do `echo blabla > network_parameters.md` instead of using `>>`, the file now has only 

```
blabla

```

Now executing,

```bash
git stash
```

```
Saved working directory and index state WIP on main: a7b382f Add ok file and some sensitive information that shouldnt be commited
```

Again, using `cat network_parameters.md | clip.exe`:

````
# Nós

- Boolean: end_node
- Boolean: quantico
- Boolean: memoria
- id
- taxa_minima
- ruido_operacoes
- decoerencia
- geracao
- destilaçao
- lat (?)
- long (?)

```py
class No(object):
    def __init__(self, id = '', taxa_minima = 0 , ruido_operacoes = 0, decoerencia = 0, geracao = 1, lat = 0, long = 0, end_node = False,
                 quantico = True, memoria = False):
        self.id = id

    def distanciaEntreNos(self, alvo):
        # import geopy.distance
        coords_1 = (self.lat, self.long)
        coords_2 = (alvo.lat, alvo.long)

        print(geopy.distance.geodesic(coords_1, coords_2).km)
```

# Canais

- Boolean: quantico
- id
- comprimento
- [unidade]
- delay (ms)
- ocupado
- registro_swap

## Netsquid

- Modelo de delay (Q e C)
- Modelo de ruído (Q e C)
- Modelo de perdas (Q e C)
```py
class Canal(object):
  def __init__(self, id, comprimento, quantico = True, unidade = 'km', ocupado = False, registro_swap = []):
    self.id = id
    self.comprimento = comprimento
    self.delay = 3e8/self.comprimento
```
````

```bash
git log --all --oneline
```
![image](https://user-images.githubusercontent.com/69206952/205957726-b5bd01ee-c58f-4737-b415-8a7f8324faaa.png)

```bash
git stash pop
```

![image](https://user-images.githubusercontent.com/69206952/205957968-3dbd778f-d356-4c10-bf9a-d46252a3c8fa.png)

File:

```
blabla

```

I think the example shows a scenario that this tool might be useful.

### 5. Like many command line tools, Git provides a configuration file (or dotfile) called `~/.gitconfig`. Create an alias in `~/.gitconfig` so that when you run `git graph`, you get the output of `git log --all --graph --decorate --oneline`. Information about `git` aliases can be found here.

Answer:

![image](https://user-images.githubusercontent.com/69206952/205960233-856bf99d-c56e-4203-8ed7-521e72d0f698.png)

![image](https://user-images.githubusercontent.com/69206952/205960323-2cc85cc4-9c50-4040-ac9d-03451049d2c3.png)

### 6. You can define global ignore patterns in `~/.gitignore_global` after running `git config --global core.excludesfile ~/.gitignore_global`. Do this, and set up your global gitignore file to ignore OS-specific or editor-specific temporary files, like `.DS_Store`.

Answer:

Telling git to ignore `clip.exe`:

```bash
git config --global core.excludesfile ~/.gitignore_global
echo clip.exe > ~/.gitignore_global
```

### 7. Fork the repository for the class website, find a typo or some other improvement you can make, and submit a pull request on GitHub.

Answer: TODO!
