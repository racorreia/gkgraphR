# gkgraphR

<!-- badges: start -->
[![R build status](https://github.com/racorreia/gkgraphR/workflows/R-CMD-check/badge.svg)](https://github.com/racorreia/gkgraphR/actions)
[![Build Status](https://travis-ci.org/racorreia/gkgraphR.svg?branch=master)](https://travis-ci.org/racorreia/gkgraphR)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/racorreia/gkgraphR?branch=master&svg=true)](https://ci.appveyor.com/project/racorreia/gkgraphR)
<!-- badges: end -->

Easy access to the Google Knowledge Graph API (v1) from R. More information about the Google Knowledge Graph API can be found here: https://developers.google.com/knowledge-graph

## Before starting

Please note that in order to access the API, users must register a Google account and create a project in the Google API console to obtain an API key. Using the Google Knowledge Graph API is free and a regular API account allows for up to 100.000 queries per day; additional API credits may be obtained through special request. More information on how to register an account and create a project can be found here: https://developers.google.com/knowledge-graph/prereqs

## Installation

You can obtain the current development version from github:

```
# install.packages("devtools")
devtools::install_github("racorreia/gkgraphR", build_vignettes = T)
```

## Querying the API

Querying the Google Knowledge Graph API through **gkgraphR** can be achieved through the function `querygkg()`. A simple query requires a valid Google API key and one of two elements: i) a search query, or ii) a Google Knowledge Graph entity ID. For example, a simple list of entities recognized by the Google Knowledge Graph API in relation to the term "apple" can be achieved with the following code:

```
# Load gkgraphR library
library(gkgraphR)

# Query the API for entities related to the term "apple"
query_apple <- querygkg(query = "apple", api.key = {YOUR_API_KEY}) # Replace YOUR_API_KEY with a valid Google API key
```

Similarly, querying the API for the entity "apple" representing the fruit or the entity "apple" representing the technology company can be achieved with the following queries:

```
# Query the API for the entity "apple" representing the fruit
query_apple_fruit <- querygkg(ids = "/m/014j1m", api.key = {YOUR_API_KEY}) # Replace YOUR_API_KEY with a valid Google API key

# Query the API for the entity "apple" representing the fruit
query_apple_company <- querygkg(ids = "/m/0k8z", api.key = {YOUR_API_KEY}) # Replace YOUR_API_KEY with a valid Google API key
```

More information on how to use package **gkgraphR** can be found in the package vignette:

```
vignette("gkgraphR")
```
