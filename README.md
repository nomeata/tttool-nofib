Turning tttool into a benchmark
===============================

The benchmark suite that GHC uses, nofib, is aged and does not contain much
realistic code.

The goal of this project is to take real-world haskell code that uses much of
today’s Haskell ecosystem and turn it into something self-contained that one
can easily build and measure, even with a development compiler, and without
additional help of `cabal` or `stack` (which might not work nicely with GHC
HEAD).

Either this repository will be abandoned, or the code merged into nofib.


Why tttool
---------

 * It is a real-world project that non-developers out there use.
 * It does many different things:
    * Reading and writing binary code with a hand-writen parser
    * Reading and writing yaml
    * Procedurally creating pixel graphics
    * Producing PDF files containing these graphics
 * It exercises the compiler: With all dependencies, without parallelism, on a
   fast 2016 laptop, it takes 5 minutes to compile.

What has been done
------------------

 1. I took tttool (git version `c782f5dc6`), and put it in `tttool-0.7-git`
 2. I unpacked all its (non-boot-library) dependencies (using `cabal unpack`)
 3. I created a command line in `Makefile` that compiles the `tttool` binary
    with all its dependencies in one shot.

    To make this work, the command line consisted of these things

      * Added many `-i` parameters to GHC.
      * Added a few CPP defines on the command line that odd packages needed.
      * Define bogus `MIN_VERSION_foo` defines for packages that I inlines.
      * Added language extensions that some of the inlined packages had specified
        only in the Cabal file, but not in the source file (who does such things?)
      * Added `-I` paramters.
      * Added some of the bundled `.c` files as arguments
      * Added `-lz` (worked better than the included `zlib` C-files which game
	me `-PIC`-related linker errors)
 4. In addition, two files need special treatment:

      * I copied a `Paths_tttool.hs` here
      * `zlib` has one `.hsc` file, which I convert to `.hs` using `hsc2hs` in
	the Makefile
 5. Finally, the directory `patches` contains a bunch of patches that I had to apply:

      * Some missing language pragmas that do not work well when given globally.
      * `scientific` has a `Utils` module that I renamed to avoid a clash with `tttool`’s.
      * Making `vector` compatible with GHC HEAD
      * Removing some features from `tttool` that I do not plan to benchmark

    The patch queue in `patches/` is managed using the command line `quilt`.
    The git repository tracks the patches in their fully applied state (hence
    the meta-data directory `.pc`), so that people can use this directly
    without `quilt`. If you need to modify the patches, please do it with
    `quilt` and ensure that `quilt pop -a; quilt push -a` works without a hitch
    before committing.

What should yet be done
-----------------------

 * Define a the actual benchmark execution command line. This might involve
   creating a custom `main` function that exercises all the above mentioned parts
   of tttool.
 * Maybe: Remove all files from this tree that are not actually used.

   (But maybe keep license information?)

Problems
--------

 * This code contains a lot of C code. Will this be portable enough for a
   benchmark suite?
 * This code contains a lot of CPP. Is this annoying when actually debugging
   performance issues?
 * It takes 5 minutes to compile. Is that too long?

Who
---

Joachim Breitner <mail@joachim-breitner.de>

