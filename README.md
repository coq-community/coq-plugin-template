Example of Coq Plugin using Dune
--------------------------------

Hi all, this repository contains a template for writing a Coq plugin
using the Dune build system. It showcases a few advanced features such
as linking to C code.

Note that the current version requires Dune 1.10 (or the `master`
branch of Dune if you are reading this before 1.10 was released)

See [Coq Dune documentation](https://dune.readthedocs.io/en/latest/coq.html) for
more help.

## See also

https://github.com/coq/coq/tree/master/doc/plugin_tutorial

## How to build

```
$ dune build
```

to test

```
$ dune exec -- coqtop -R _build/default/theories MyPlugin
```

## Composing with Coq

You can symlink the Coq >= 8.10 sources and you will get a composed
build, with some caveats [you should run `make -f Makefile.dune
voboot]`.

## Caveats

- the Coq linker cannot track dependencies properly, thus YMMV when
  linking against 3rd party libs, see #
