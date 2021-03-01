---
title: "cran-comments.md"
author: "Ricardo Correia"
date: "01/03/2021"
---

## Test environments
* local ubuntu 20.04 LTS install, R 4.0.2
* ubuntu 16.04 (on travis-ci), R 4.0.0
* mac os x 10.13 (on travis-ci) R 4.0.2
* x86_64-w64-mingw32 (on Appveyor) R 4.0.0

## R CMD check results
There were no ERRORs, WARNINGs. 

There was 1 NOTE:

* checking CRAN incoming feasibility ... NOTE
  Maintainer: 'Ricardo Correia <rahc85@gmail.com>'

  I believe this is just an informative note

## Corrections implemented since last version:
* Included API names in single quotes in title and description
* Wrapped examples in \dontrun instead of quotes
* Implemented Authors@R field to declare Author and Maintainer
