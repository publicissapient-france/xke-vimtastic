# xke-vimtastic

We will first configure your Vim installation

## First backup your existing Vim config

```
mv ~/.vimrc ~/.vimrc.bak
mv ~/.vim ~/.vim.bak
```

## Copy this Vim configuration

```
cp .vimrc ~/.vimrc

```

## Install Vundle

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
## Install Plugins

```
vim +PluginInstall +qall
```

## One last thing...

While editing files in Vim you will be doing a lot of scrolling and in order to make this as fast as possible we recommend you set your key repeat delay to a minimum!

On MacOS you do this by going to `System Preferences... -> Keyboard` and drag both the `Key Repeat` and `Delay Until Repeat` sliders all the way to the right.


## Demystifying .vimrc

Let's have a closer look at the configuration.

```
vim .vimrc
```

First comes the plugins which we let `Vundle` manage, there are lots of plugins available on Github and `Vundle` makes it easy to install new ones.

We set the `mapleader` to `,`. The `mapleader` is used for distinguishing commands from each other as we will see later. This is set to `\` by default.
We then make the `\` map to `,` to give us the option to do both.

The `color` is then set - here we have wrapped it in a try/catch to avoid errors if the plugin is not installed.

#### Try this
The `vim-colorschemes` plugin lets you can switch between a large number of color schemes:

```:colorscheme <TAB>``` and Enter

### Built-in options

There are a large number of Vim options. Perhaps one of the more confusing settings is `relativenumber`. This is however useful to count how many lines we want to copy or delete.

But don't worry you can always `:set norelativenumber` and `:set number` if you want to see the line numbers temporarily.

We set the folding options to some sensible defaults

### Plugin configuration

The `Nerdtree` and `CtrlP` plugins are configured to ignore certain file types and directories to improve performance.

### Custom functions

Vim allows you to define custom functions which in turn can make use of other built-in functions.

Our custom function `SyntasticEslintChecker()` runs `eslint` on every save of the currently open file.
Similarly `EslintFix()` runs `eslint --fix` on the current file.

### Auto commands

Auto commands are invoked on saving a file (writing to a buffer) and we can map it to a specific `FileType`

For example, when saving a `javascript` file we call the `SyntasticEslintChecker()` function


### Mappings

Mappings can be recursive or not, `map` or `noremap` respectively. Additionally they can apply to a certain mode.

- `vmap` is recursive and available in `Visual` mode
- `nnoremap` is a non-recursive mapping which works in `Normal` mode
- `inoremap` is non-recursive and applies to `Insert` mode

and so on ...

The first argument is the key combination, and the second is a combination of keystrokes, commands or a function call.


For example `noremap <tab> <c-w><c-w>` maps the `tab` key to `Ctrl+w Ctrl+w` to switch between buffers.


## Ready to use Vim?

Once you are happy with the configuration, you can try out Vim in a small project

```git checkout node```

[node branch](https://github.com/xebia-france/xke-vimtastic/tree/node)

