# Solargraph::DeadEnd

This gem is a plugin for the Solargraph language server, to report missing do(s) and end(s) using [DeadEnd](https://github.com/zombocom/dead_end) inside your editor!

Any editor that has a solargraph plugin can use it:

(Space)emacs with LSP mode

![emacs shows output from this solargraph plugin. It uses dead_end gem to show you where your code has a broken block](assets/emacs_multiple_errors.png)
 

VSCode with solargraph plugin


![vscode shows output from this solargraph plugin. It uses dead_end gem to show you where your code has a broken block](assets/vscode_no_hover.png)

The highlighted lines should give you a good clue about where the problem lies. If you hover over the error you'll get even more info:

![vscode shows a hover over with even more info from this solargraph plugin. It uses dead_end gem to show you where your code has a broken block](assets/vscode_hover.png)

## Installation
1. [Install solargraph](https://github.com/castwide/solargraph#installation) if you don't have it already.
2. Add this gem:

`gem install solargraph-dead_end`

(or include it in your gemfile if you're using solargraph in bundle mode)

3. Configure your .solargraph.yml:

```
reporters:
- dead_end
...
plugins:
- solargraph-dead_end
```
