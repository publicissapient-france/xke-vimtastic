# xke-vimtastic

## Node project setup

Now that your Vim has been configured you are ready to tackle some file editing and navigation

### You need node

We recommend using [nvm](https://github.com/creationix/nvm) for managing node versions on your system.

It can be installed liked this:

```
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
```
Note: You may have to manually export the `.nvm` directory.

Now you can install node 6 like this:

```
nvm install 6
```

### Install dependencies

```
npm install
```

## The Project: Monumental search engine

This little application lets you search for french monuments by region.

Go ahead and `npm start` it and verify it works ok.

### Navigation

Start by opening up Vim in the current directory.

```
vim .
```

Vim will open up with Nerdtree showing the directory listing. Go into the `src` directory and enter `index.js`

### Extract the search js from index.js

Let's extract some of those functions to a separate source file, call it `momuments.js`.

1. With `index.js` and type `:vnew` to open a new buffer
2. Hit `<tab>` to jump back to `index.js`
3. Cut the functions - look at the relative numbers and enter the required number of lines followed by `dd`   (Ex. `10dd`)
4. `<tab>` back to the new buffer
5. Hit `p` to paste the functions
6. Write the buffer to disk (save) with `:w src/monuments.js`
7. Export the functions like this:

    ```js
    module.exports = {
      findByRegion,
      toHtml,
    }
    ```

8. `<tab>` back to `index.js` and import the extracted functions:

    ```
    const { findByRegion, toHtml } = require('./monuments.js');
    ```

9. Save and close your buffers `:wq` and start the project to verify everything is still working ok.

### Extract the css from index.html

Moving on - index.html contains a mix of html, css and js - let's extract the css first

1. Run `vim .` to open up Nerdtree again.
2. Create a `css` directory under `src/public` - put the cursor on the `public` directory line, hit `m` (for menu) and `a` to "add a childnode". Type `css/` when prompted and don't forget the trailing `/` (otherwise you'll end up with a file)
3. Open `index.html` using Ctrl-P this time. `<Ctrl>+p` and start typing `index` - scroll to `index.html` and open it with `<Enter>`.
4. Open a new buffer `:vnew src/public/css/main.css`
5. `<tab>` back to `index.html` and copy the contents of `<style>` - Make use of the relative lines to see how many you need to cut and enter `<number of lines>dd`
6. `<tab>` over to the css file and `p` to paste content
7. The `<Ctrl>+f` mapping runs `JsBeautify` which corrects the indentation for us
8. `<tab>` back to `index.html` and import our extracted styles

    ```
    <link rel="stylesheet" type="text/css" href="/css/main.css" />
    ```

9. `:wa` to save "all" your open buffers.
10. Run the application again to verify things are still looking good.

### Extract the js from index.html

Next up is the javascript in the body of our html
