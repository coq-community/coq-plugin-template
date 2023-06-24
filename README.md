# Coq Plugin Template using Dune

[![Docker CI][docker-action-shield]][docker-action-link]

[docker-action-shield]: https://github.com/coq-community/coq-plugin-template/workflows/Docker%20CI/badge.svg?branch=v8.17
[docker-action-link]: https://github.com/coq-community/coq-plugin-template/actions?query=workflow:"Docker%20CI"

Template repository writing a plugin in [OCaml](https://ocaml.org) for the
[Coq](https://coq.inria.fr) proof assistant using the [Dune](https://dune.build)
build system. It showcases a few advanced features such as linking to C code or
to external libraries.

## Meta

- License: [Unlicense](LICENSE) (change to your license of choice)
- Compatible Coq versions: 8.17.1 or later
- Additional dependencies:
  - [Dune](https://dune.build) 3.8.2 or later
- Coq namespace: `MyPlugin`

## Building instructions

To install dependencies via [opam](https://opam.ocaml.org/doc/Install.html):
```shell
$ opam install dune.3.8.2 coq.8.17.1
```

To build the plugin when all dependencies are installed:
```shell
$ dune build
```

The plugin can be tested manually:
```shell
$ dune coq top theories/Test.v

Welcome to Coq 8.17.1               

Coq < Require Import MyPlugin.
[Loading ML file my_plugin.cmxs (using legacy method) ... done]

Coq < CallC.
Toplevel input, characters 0-6:
> CallC.
> ^^^^^^
Warning: 546
```

See also the [Dune documentation](https://dune.readthedocs.io/en/latest/) for more help,
and the [official tutorial](https://github.com/coq/coq/tree/master/doc/plugin_tutorial)
for writing Coq plugins in the Coq repository which already includes `dune` files
for the OCaml parts.

## Releasing opam packages

You can use [`dune-release`](https://github.com/tarides/dune-release) to
automatically release opam packages.

For that, you need to update the included `.opam` file, and configure
your Github tokens as described in the documentation of `dune-release`.
