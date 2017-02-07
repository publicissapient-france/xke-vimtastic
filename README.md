# xke-vimtastic

Now that your Vim has been configured you are ready to tackle some file editing and navigation

## Prerequisites

### You need node

We recommend using [nvm](https://github.com/creationix/nvm) for managing node versions on your system.

It can be installed liked this:

```
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
```
Note: You may have to manually add the `.nvm` directory to your `$PATH`.

Now you can install node 6 like this:

```
nvm install 6
```

### Install dependencies

```
npm install
```

### Alternative with Docker

If you don't want to install Node and you have Docker installed, you can run the project with the following command:
```
docker run -it -p 3000:3000 -v $(pwd):/usr/src/app -w /usr/src/app node:6 npm install && npm start
```

## The Project: Monumental search engine

This little application lets you search for french monuments by region.

Follow along the instructions to discover how you can approach different tasks in Vim

Go ahead and `npm start` it and verify it works ok.

[http://localhost:3000](http://localhost:3000)

### Refactoring

Start by opening up Vim in the current directory.

```
vim .
```

Vim will open up with Nerdtree showing the directory listing. Go into the `src` directory and enter `index.js`

### Extract the search js from index.js

*Remember you can always `<Esc>` `u` to undo when things get messy*

Let's extract some of those functions to a separate source file, call it `momuments.js`.

1. With `index.js` and type `:vnew` to open a new buffer
2. Hit `<tab>` to jump back to `index.js`
3. Cut the functions - look at the relative numbers and enter the required number of lines followed by `dd`   (Ex. `10dd`)
4. `<tab>` back to the new buffer
5. Hit `p` to paste the functions
6. Write the buffer to disk (save) with `:w src/monuments.js`
7. Export the functions like this:

    ```js
    module.exports = {   // Try typing this out using <Ctrl>+n to get autocomplete
      findByRegion,
      toHtml,
    }
    ```

8. `<tab>` back to `index.js` and import the extracted functions:

    ```
    const { findByRegion, toHtml } = require('./monuments.js');
    ```

9. Save and close your buffers `:wq` and start the project to verify everything is still working ok.

#### Eslint
You may have noticed that words get highlighted in red, this is `SyntasticEslint` linting our files as we write our buffer to disk. Go ahead and fix the issues as you move along the steps.

### Extract the css from index.html

Moving on - index.html contains a mix of html, css and js - let's extract the css first

1. Run `vim .` to open up Nerdtree again.
2. Create a `css` directory under `src/public` - put the cursor on the `public` directory line, hit `m` (for menu) and `a` to "add a childnode". Type `css/` when prompted and don't forget the trailing `/` (otherwise you'll end up with a file)
3. Open `index.html` using Ctrl-P this time. `<Ctrl>+p` and start typing `index` - scroll to `index.html` and open it with `<Enter>`.
4. Open a new buffer `:vnew src/public/css/main.css`
5. `<tab>` back to `index.html` and copy the contents of `<style>` - This time use "Visual Line" mode to select the code, `<Shift>+V` and select the style lines, and then `d` to cut.
6. `<tab>` over to the css file and `p` to paste content
7. The `<Ctrl>+f` mapping runs `JsBeautify` which corrects the indentation for us
8. `<tab>` back to `index.html` and import our extracted styles

    ```
    <link rel="stylesheet" type="text/css" href="/css/main.css" />
    ```

9. `:wa` to save "all" your open buffers.
10. Run the application again to verify things are still looking good.

### Extract the js from index.html

Next up is the javascript in the body of our html ... go ahead and extract it to a its' own file in the `src/public/js` directory.

## Working with large files

Let's get the complete file of monuments - change into the data directory and download the file (see README.md)

We need to analyse the contents and make some changes.

1. Open up the file:

    ```
    vim merimee-MH.json
    ```

2. Let Python format the file

    *(Python should be preinstalled if you are using MacOS or a Linux distro)*

    ```
    :%!python -m json.tool
    ```

3. There is an incorrect `REF` for Tour Eiffel, find and replace it with `123456`

    - First find it by typing `/tour eiffel` and `<Enter>`,
    - move the cursor on the existing reference number and type `ciw` to Cut Inner Word
    - replace it with `123456`
    - `<Esc>` to exit insert mode and `:w` to write buffer to disk.

4. Folding

    - Type `zC` to fold all sections
    - Type `zo` to open an individual fold
    - Type `zO` to open all folds
    - Type `za` to toggle folding for one section

### Use the complete monument file in our project

1. With Vim open, hit `<Ctrl>+P` and open `index.js`
2. Replace `firstHundred` by `merimee-MH`, again using `ciw` to replace.
3. Run the application and enjoy searching all french monuments! 🎉

### But the client wants to search by city instead!

1. Find all instances of `region` - `:lvim region src/**`
   - Vim will open the first matching file
2. Type `:lopen` to see the list matches
   - Close with `:q` after inspecting the matches
3. Let's start by replacing the function name in all js files
    - Define that we want to search in all .js files `:arg src/**/*.js`
    - Place the cursor on the `findByRegion` function and type `*` to find all matches in file
    - Type `:argdo %s//findByCity/ge | update` and `<Enter>` to apply command to all files in `args` for the last searched word (`findByRegion`)
4. Next open `index.html` and type `/region` and `<Enter>` to jump to the first match
5. Type `ciw` to delete the word and put Vim in Insert mode. Type `city` and `<Esc>` to exit Insert mode.
6. Type `n` to jump to the next match and `.` to repeat the last command.
7. Let's make that first letter capital
    - Type `b` to go to the beginning of the word and `rC` to replace the first letter with a capital C.
8. Finally we'll find and replace the `REG` field by `COM` in `monuments.js`:
    - Open `monuments.js` using `<Ctrl>+p`
    - Type `:%s/REG/COM/g`
9. Save all your open buffers with `:wa`

## You can now search for monuments by City! ✨

### Jump to declaration

Perhaps one of the most useful features of an IDE is the ability to jump to the declaration of a function.

`ctags` let's you do just that!

1. Run `ctags -R src/**` in the root of the project
    - You should now have a `tags` file
2. Now reopen the project `vim .` and go to `index.js`
3. Place the cursor on `toHtml` and press `<Ctrl>+]`
    - Vim should have opened `monuments.js` with the cursor on the declaration of `toHtml`
4. You can continue further down into other function calls with `<Ctrl>+]`
5. To get back up the call stack you press `<Ctrl>+t`
