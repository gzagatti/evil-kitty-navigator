# Evil-Kitty-Navigator

This package was modified from [evil-tmux-navigator](https://github.com/keith/evil-tmux-navigator) to make Vim-like navigation keys work seemlesly inside of [Kitty](https://github.com/kovidgoyal/kitty) when using Emacs evil mode

Install this package with your favourite Emacs package manager. Then require it in your `~/.emacs` with:

```lisp
(require 'navigate)
```

In addition to that, follow the instructions in [vim-kitty-navigator](https://github.com/knubie/vim-kitty-navigator) to install the required kittens. You will also need to modify the [`pass_key.py`](https://github.com/knubie/vim-kitty-navigator/blob/8d9af030c8a74cdda6ab9a510d9a13bca80e8f9b/pass_keys.py#L40) such that it can recognize when you are inside of an Emacs session:

```python
# pass_keys.py#L40
-  vim_id = args[4] if len(args) > 4 else "n?vim"
+  vim_id = args[4] if len(args) > 4 else "(n?vim|emacs)"
```
