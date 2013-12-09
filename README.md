
# TeXdown #


## Presentation ##
TeXdown is an extension of [marked](https://github.com/chjj/marked), a javascript
markdown parser designed to present mathematics like LaTeX.

It includes strictely [markdown specification](http://daringfireball.net/projects/markdown/)
and adds on the one hand gfm - the GitHub markdown extension - and on the other hand
the support of LaTeX maths. Furthermore, it adds the possibility to define environments.


## Basic usage ##
TeXdown uses the web browser to display the document.

To use it, start the local server thanks to nodejs :

```bash
    texdown/$ nodejs server
```

Then you cas visualize your documents in the browser at the url
`http://localhost:3615/document_name` where `document_name` is the name of your document.

Your documents must be stored in the `sources/` directory, in `document_name.td` file.

You just need to save your td file and refresh the page in your browser and that's it !

**/!\ TeXdown has been developped with Google Chrome. Under other web browsers, the behaviour is undefined**

## Syntax ##
### LaTeX ###
LaTeX mathematics must be inserted between `$` symbols. Other way to include maths are
not implemented yet.

To know which LaTeX commands are allowed, *cf* [MathJax documentation](http://docs.mathjax.org/en/latest/)

### Environments ###
You can give a special meaning to a given paragraph by starting it with

```
    // envionment_name
    paragraph core
```

That paragraph will then be displayed as specified in `.env_environment_name` entry
of `style.css`.

If you need to embrace many paragraphs in an environment, you can use the following syntax :

```
    /* envionment_name
    paragraph 1
    
    paragraph 2
    
    */
```

**/!\ Currently, the empty line before `*/` is mandatory.**

Some environments are already defined :

 * definition
 * theoreme
 * propriete
 * proposition
 * lemme
 * corollaire
 * preuve
 * remarque
 * exemple
 * remarques
 * exemples

NB: These are French keywords.

In these environments, in addition to css style, a custom header is added.
Moreover, some of them (definition, theoreme, propriete, proposition, lemme and corollaire)
can handle a custom label, put between parenthesis after the environment keyword :

```
    // theoreme (de Bolzano-Weierstrass)
```


## Customization ##
### Add environnement ###
You can add your own environments.

The easiest way to do that is to add a `.env_envname` entry to `style.css`, but
if you want to add a custom header/footer to the environment, you have to specify
it in the beginning of `texdown.js`, in the `envDeco` declaration :

```js
    var envDeco = {
      // [...]
      envname  : ['Header' , 'Footer']
    };
```

In the header, the keyword `LABEL` will be replaced by the specified label (between
parenthesis) dans the text between `[` and `]` will be hidden when no label is specified.

Typically, `LABEL` will be displayed inside the braces.

### Change page style ###
The entire page is diplayed in a html file so you can customize it *via* the `default.css` file.

You can specify a different style file through two different ways :

 * Add `?style=another_style` at the end of the request to load the page with `another_style.css`.
 * But you can also specify the default style for a given document by inserting an option paragraph like so : `!style=another_style`.
   Then the basic request will display the document with `another_style.css`.

You can also change the `texdown_start.html` and `texdown_end.html` files to have the page frame customized.

### LaTeX commands ###
As specified in MathJax documentation, you can add new LaTeX commands with `MathJax.Hub.Config({TeX:{foo:'bar'}})`.

An example is given in `texdown_end.html`.

## TODO ##
 * Add css handling for printing
 * Translate env names
 * Improve the customization way (editing texdown.js file is bad !)
 * Add LABEL and brace escape in header/footer
 * Add LABEL replacement in footer
 * Add latex block
 * Simplify latex maths redaction



