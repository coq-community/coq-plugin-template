# Template for Coq Plugins using Dune

This repository contains a template for writing a plugin for the
[Coq](https://coq.inria.fr) proof assistant using the [Dune](https://dune.build)
build system. It showcases a few advanced features such as linking to C code or
to external libraries.

The current version is tested with:

- Dune 2.5
- Coq 8.14

Minimal historical requirements are Coq 8.9 and Dune 1.10, but they
are not supported anymore. See template history / branches for
changes at your own risk.

See the [Dune documentation](https://dune.readthedocs.io/en/latest/) for more help.

## See also

The [official tutorial](https://github.com/coq/coq/tree/master/doc/plugin_tutorial)
for writing Coq plugins in the Coq repository, which already includes `dune` files
for OCaml parts.

## How to build

```shell
$ dune build
```
and the rest of the regular Dune commands. To test your library, you can use

```shell
$ dune exec -- coqtop -R _build/default/theories MyPlugin
```

## Releasing OPAM packages

You can use
[`dune-release`](https://github.com/ocamllabs/dune-release) to
automatically release OPAM packages.

For that, you need to update the included `.opam` file, and configure
your Github tokens as described in the documentation of `dune-release`.

## Linking with external libraries

If your plugin depends on an external OCaml library, Coq will fail to
load it as it doesn't know about this dependency.

This should be fixed in Coq hopefully soon, see [Coq's
issue](https://github.com/coq/coq/issues/7698).

Meanwhile, you need to manage the dependency chain manually; imagine
you want to depend on `z3`, then in your `(library ...)` stanza you
will want to add:
```lisp
(libraries coq-core.vernac z3)
```
That works, and your plugin will now be able to link to `z3`.
However, when dynamically loading it, you must ensure that the `z3`
modules have been linked.

To do so manually, load the `z3` plugin in your `Test.v` file:
```
Declare ML Module "z3ml".
Declare ML Module "example_plugin".
```
We are almost there! The last thing you need to do is to workaround a Coq Dune bug and
add `z3` to the list of dependencies of your Coq theory:
```lisp
(libraries z3 coq-my-plugin.plugin)
```
and that's all!

A last step to make things work in the concrete case of `z3` is to
update the `LD_LIBRARY_PATH` as the OPAM package is buggy, usually this will do:
```
export LD_LIBRARY_PATH=~/.opam/coq.dev/lib/z3:$LD_LIBRARY_PATH
```

## Caveats

- Coq's linker cannot track dependencies properly, thus YMMV when
  linking against 3rd party libraries.
- `coqdep` emits some warnings that should be hard failures, we
  recommend you treat them as such.
