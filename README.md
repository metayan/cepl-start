Simple CEPL project to start with.

### To install
```
cd ~/quicklisp/local-projects/
git clone https://github.com/metayan/cepl-start
sbcl --eval "(ql:register-local-projects)" --quit
```

### Then, to run:
Start SLIME in Emacs and
```
(ql:quickload :cepl-start)
```
or from a shell
```
sbcl --eval "(ql:quickload :cepl-start)"
```

If two or more displays are connected, the second display is used in full-screen.
Handled in `helpers.lisp`.
