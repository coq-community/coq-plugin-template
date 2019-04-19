Example of Coq Plugin using Dune
--------------------------------

Hi all, this repository contains a template for writing a Coq plugin
using the Dune build system. It showcases a few advanced features such
as linking to C code.

The current version requires:
- Dune 1.10 (or the `master` branch of Dune if you are reading this
  before 1.10 was released)
- Coq 8.10 [the [v8.9 branch](https://github.com/ejgallego/coq-plugin-template/tree/v8.9)
  has a version that will work with Coq 8.9]

See [Coq Dune documentation](https://dune.readthedocs.io/en/latest/coq.html) for
more help.

## See also

https://github.com/coq/coq/tree/master/doc/plugin_tutorial , which
includes `dune` files for their ML part.

## How to build

```
$ dune build
```

and the rest of regular Dune commands, to test

```
$ dune exec -- coqtop -R MyPlugin _build/default/theories
```

this will be improved soon.

## Composing with Coq

You can symlink the Coq >= 8.10 sources in your plugin tree and you
will get a composed build, with some caveats:

- you should run `make -f Makefile.dune voboot]`
- you should call Coq's configure with the a correct install path

this will be also greatly improved in the future.

## Caveats

- Coq's linker cannot track dependencies properly, thus YMMV when
  linking against 3rd party libs, see [Coq's issue](https://github.com/coq/coq/issues/7698)
- coqdep emits some warnings that should be hard failures, treat them
  as such.
