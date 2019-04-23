Example of Coq Plugin using Dune
--------------------------------

Hi all, this repository contains a template for writing a Coq plugin
using the Dune build system. It showcases a few advanced features such
as linking to C code or to external libraries.

The current version requires:
- Dune 1.10 (or the `master` branch of Dune if you are reading this
  before 1.10 was released)
- Coq 8.10 [the [v8.9 branch](https://github.com/ejgallego/coq-plugin-template/tree/v8.9)
  has a version that will work with Coq 8.9]

See [Coq Dune documentation](https://dune.readthedocs.io/en/latest/coq.html) for
more help.

## See also

https://github.com/coq/coq/tree/master/doc/plugin_tutorial , which
already includes `dune` files for their ML part.

## How to build

```
$ dune build
```

and the rest of regular Dune commands, to test

```
$ dune exec -- coqtop -R _build/default/theories MyPlugin
```

this will be improved soon.

## Composing with Coq

You can symlink the Coq >= 8.10 sources in your plugin tree and you
will get a composed build, with some caveats:

- you should run `make -f Makefile.dune voboot]`
- you should call Coq's configure with the a correct install path

this will be improved soon so things work out of the box.

## Linking with external libraries

If your plugin depends on an external OCaml library, Coq will fail to
load it as it doesn't know about this dependency.

This should be fixed in Coq hopefully soon, see [Coq's
issue](https://github.com/coq/coq/issues/7698).

Meanwhile, you need to manage the dependency chain manually; imagine
you want to depend on `z3`, then in your `(library ...)` stanza you
want to add:
```lisp
  (libraries coq.vernac z3)
```
That is cool, and your plugin will now be able to link to `z3`,
however, when dynamically loading it, you must ensure that the `z3`
modules have been linked.

To do so manually, load the `z3` plugin in your `Test.v` file:
```
Declare ML Module "z3ml".
Declare ML Module "example_plugin".
```
We are almost there! A last thing you need to do is to workaround a Coq Dune bug and
add z3 to the list of dependencies of your theory:
```
 (libraries z3 my-plugin.plugin))
```
and that's all!

A last step to make things work in the concrete case of `z3` is to
update the `LD_LIBRARY_PATH` as the OPAM package is buggy, usually this will do:
```
export LD_LIBRARY_PATH=~/.opam/coq.dev/lib/z3:$LD_LIBRARY_PATH
```

## Caveats

- Coq's linker cannot track dependencies properly, thus YMMV when
  linking against 3rd party libs, see
- `coqdep` emits some warnings that should be hard failures, we
  recommend you treat them as such.
