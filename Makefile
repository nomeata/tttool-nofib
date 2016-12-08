#!/bin/bash

all: tttool

./zlib-0.6.1.2/Codec/Compression/Zlib/Stream.hs:
	hsc2hs -D__GLASGOW_HASKELL__=702 ./zlib-0.6.1.2/Codec/Compression/Zlib/Stream.hsc

tttool: ./zlib-0.6.1.2/Codec/Compression/Zlib/Stream.hs **/*.hs
	ghc-head \
	    -XFlexibleInstances \
	    -XMultiParamTypeClasses \
	    -XFunctionalDependencies \
	    -XDeriveDataTypeable \
	    -XFlexibleContexts \
	    -XRankNTypes \
	    -DUNIX -DHAVE_DEEPSEQ  -DINTEGER_GMP \
	    -D'MIN_VERSION_aeson(a,b,c)=1' \
	    -D'MIN_VERSION_unordered_containers(a,b,c)=1' \
	    -D'MIN_VERSION_conduit(a,b,c)=1' \
	    -D'MIN_VERSION_exceptions(a,b,c)=1' \
	    -D'MIN_VERSION_monad_control(a,b,c)=1' \
	    -iaeson-0.11.2.1/ \
	    -iansi-terminal-0.6.2.3/ \
	    -iansi-wl-pprint-0.6.7.3/ \
	    -iattoparsec-0.13.1.0/ \
	    -ibase64-bytestring-1.0.0.1/ \
	    -iconduit-1.2.8/ \
	    -idlist-0.8.0.2/ \
	    -ienclosed-exceptions-1.0.2//src \
	    -ierrors-2.1.3/ \
	    -iexceptions-0.8.3//src \
	    -ihashable-1.2.4.0/ \
	    -iHPDF-1.4.10/ \
	    -iJuicyPixels-3.2.8//src \
	    -ilifted-base-0.2.3.8/ \
	    -immorph-1.0.9//src \
	    -imonad-control-1.0.1.0/ \
	    -imtl-2.2.1/ \
	    -inatural-sort-0.1.2/ \
	    -inatural-sort-0.1.2/lib/ \
	    -iNaturalSort-0.2.1/ \
	    -ioptparse-applicative-0.13.0.0/ \
	    -iparsec-3.1.11/ \
	    -iprimitive-0.6.2.0/ \
	    -irandom-1.1/ \
	    -iresourcet-1.1.8.1/ \
	    -iscientific-0.3.4.9//src \
	    -isplit-0.2.3.1//src \
	    -ispool-0.1/ \
	    -istm-2.4.4.1/ \
	    -itagged-0.8.5//src \
	    -itext-1.2.2.1/ \
	    -itransformers-base-0.4.4//src \
	    -itttool/ \
	    -iunexceptionalio-0.3.0/ \
	    -iunordered-containers-0.2.7.1/ \
	    -ivector-0.11.0.0/ \
	    -iyaml-0.8.21.1/ \
	    -izlib-0.6.1.2/ \
	    -I./aeson-0.11.2.1/include/ \
	    -I./vector-0.11.0.0/include/ \
	    -I./vector-0.11.0.0/internal/ \
	    -I./text-1.2.2.1/include/ \
	    -I./lifted-base-0.2.3.8/include/ \
	    -I./ansi-terminal-0.6.2.3/includes/ \
	    -I./conduit-1.2.8/ \
	    text-1.2.2.1/cbits/*.c \
	    primitive-0.6.2.0/cbits/*.c \
	    hashable-1.2.4.0/cbits/*.c \
	    yaml-0.8.21.1/c/*.c \
	    yaml-0.8.21.1/libyaml/*.c \
	    HPDF-1.4.10/c/*.c \
	    -lz \
	    -itttool-0.7-git \
	    tttool-0.7-git/tttool.hs \
	    -o tttool
clean:
	find \( -name \*.dyn_hi -o \
	     -name \*.dyn_o -o \
	     -name \*.hi -o \
	     -name \*.o \) -delete
	rm -f tttool ./zlib-0.6.1.2/Codec/Compression/Zlib/Stream.hs
