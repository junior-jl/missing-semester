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

