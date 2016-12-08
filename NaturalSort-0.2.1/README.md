# NaturalSort - natural sorting for strings

NaturalSort is a library for sorting strings "naturally", i.e. taking
numerical values into account when comparing textual inputs.

For example, "1" < 10, and "10 bottles of beer" < "100 bottles of beer".

## Getting

* `git pull git://github.com/joachifm/natsort.git`

## Building

The preferred method of building is using [cabal-install]:

    cd natsort
    cabal install

A driver program is also available:

    cabal install -f driver

To run the test suite, do:

    cabal configure -f test
    ./dist/build/test/test

[cabal-install]: http://hackage.haskell.org/package/cabal-install

## Development

To contribute to the project, please create a fork of the [repository].

[repository]: http://github.com/joachifm/natsort

## Licence

NaturalSort is distributed under the terms of the BSD3 license (see COPYING)

## Author(s)

Joachim Fasting \<joachim.fasting@gmail.com\>
