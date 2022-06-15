# Template for Coq Plugins using Dune

This repository contains a template for writing a plugin for the
[Coq](https://coq.inria.fr) proof assistant using the [Dune](https://dune.build)
build system. It showcases a few advanced features such as linking to C code or
to external libraries.

The current version is tested (and requires):

- Dune 2.9
- Coq 8.16

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

or starting with Dune 3.2
```shell
$ dune coq top theories/Test.v
```

## Releasing OPAM packages

You can use
[`dune-release`](https://github.com/ocamllabs/dune-release) to
automatically release OPAM packages.

For that, you need to update the included `.opam` file, and configure
your Github tokens as described in the documentation of `dune-release`.

## Linking with external libraries

Starting with Coq 8.16, Coq will load dependencies of your
plugin. This requires that your plugin is named as a findlib package.

See [Coq documentation](https://coq.github.io/doc/master/refman/proof-engine/vernacular-commands.html#coq:cmd.Declare-ML-Module) for more information.
