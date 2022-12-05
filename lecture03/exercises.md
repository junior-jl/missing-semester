# Exercises Lecture 03

### 1. Complete `vimtutor`.

Answer:

```
vimtutor
```

After the changes, the file should look something like [this](lecture03/Q1vimtutor.txt).
Lesson 5.3 -> [vimtutor53.txt](lecture03/vimtutor53.txt)

### 2. Download our basic vimrc and save it to `~/.vimrc`. Read through the well-commented file (using Vim!), and observe how Vim looks and behaves slightly differently with the new config.

Answer: -

### 3. Install and configure a plugin: ctrlp.vim.

Answer:

```
mkdir -p ~/.vim/pack/vendor/start
cd ~/.vim/pack/vendor/start; git clone https://github.com/ctrlpvim/ctrlp.vim
```

### 4. To practice using Vim, re-do the Demo from lecture on your own machine.

Answer: [fizz_buzz.py](lecture03/fizz_buzz.py)

### 5. Use Vim for all your text editing for the next month. Whenever something seems inefficient, or when you think “there must be a better way”, try Googling it, there probably is. If you get stuck, come to office hours or send us an email.

Answer: -

### 6. Configure your other tools to use Vim bindings.

Answer: In bash: `set -o vi`

### 7. Further customize your `~/.vimrc` and install more plugins.

Answer: -

### 8. (Advanced) Convert XML to JSON using Vim macros.

Answer: TODO!
