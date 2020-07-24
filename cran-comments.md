---
title: "cran-comments.md"
author: "Ricardo Correia"
date: "23/07/2020"
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
* Corrected leading zeros in package version, now numbered 1.0.1
* Included CRAN template for MIT license using function usethis::use_mit_license()
* Added link to the Google Knowledge Graph API page in the Description field of the DESCRIPTION file
