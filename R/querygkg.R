#' Performs a query on the Google Knowledge Graph API
#'
#' @param query A character string to search for in Google Knowledge Graph.
#' @param ids A list of one or more entity IDs to search for in Google Knowledge Graph. Should be a Google Knowledge Graph or Freebase ID code in character string format.
#' @param lang A character argument defining the language filter. The list of language codes (defined in ISO 639) to run the query with, for instance `en`. Defaults to NULL.
#' @param types A character argument restricting returned entities to those of the specified types. See schema.org for valid types (e.g. `Person` as defined in http://schema.org/Person restricts the results to entities representing people). If multiple types are specified, returned entities will contain one or more of these types. Defaults to NULL.
#' @param indent A logical argument enabling indenting of JSON results. Defaults to NULL.
#' @param prefix A logical argument enabling prefix (initial substring) matching against names and aliases of entities. For example, a prefix `Jung` will match entities and aliases such as `Jung`, `Jungle`, and `Jung-ho Kang`. Defaults to NULL.
#' @param limit A numeric value limiting the number of entities to be returned. Maximum is 500. Defaults to 20. Please note that requests with high limits have a higher chance of timing out.
#' @param json A logical argument defining whether the API query should be returned in the original JSON format or as an R object. Defaults to FALSE.
#' @param itemList Should the query contain only the Google Knowledge Graph item list returned by the query? Defaults to TRUE. Only valid when returning R objects (i.e. parameter json = FALSE).
#' @param cleanIDs If the output is an item list, should it return clean IDs? Defaults to TRUE. Only valid when returning an item list (i.e. parameter json = FALSE and parameter itemList = TRUE).
#' @param api.key A Google API key.
#'
#' @return Returns the Google Knowledge Graph output.
#' @export
#'
#' @examples
#' \dontrun{
#' # Note: Function querygkg requires a valid Google API key to work
#'
#' # Run a text-based query for the term "apple"
#' querygkg(query = "apple", api.key = "YOUR_API_KEY")
#'
#' # Run an ID-based query for the entity "apple" representing the fruit
#' querygkg(ids = "/m/014j1m", api.key = "YOUR_API_KEY")
#'
#' # Run an ID-based query and get the original JSON object returned by the API
#' querygkg(ids = "/m/014j1m", json = TRUE, api.key = "YOUR_API_KEY")
#' }



querygkg <- function(query=NULL, ids=NULL, lang=NULL, types=NULL, indent=NULL, prefix=NULL, limit = NULL, json = FALSE, itemList = TRUE, cleanIDs = TRUE, api.key) {

  #Base link of API call
  link <- "https://kgsearch.googleapis.com/v1/entities:search?"

  if(is.null(query) == TRUE & is.null(ids) == TRUE){
    stop("Either a search term or entity ID must be provided to perform the search")
  }

  if(is.null(query) == FALSE & is.null(ids) == FALSE){
    stop("The search is likely to return an empty result when both query terms and entity IDs are provided. Please consider using only one paramter.")
  }

  #Add serach term to link
  #Search terms should be a single character string
  if (is.null(query) == F){
    if (is.character(query) == F){
      stop("The query must provided be in character string format", call. = FALSE)
    }

    if (length(query) > 1){
      stop("Query should be a single character string", call. = FALSE)
    } else {
      link <- paste0(link, "query=", utils::URLencode(query))
    }
  }

  #Add serach id to link
  #IDs should be provided in character string format
  if(is.null(ids) == F){
    if (is.character(ids) == F){
      stop("The ids must be provided in character string format", call. = FALSE)
    }

    if (length(ids) == 1){
      link <- paste0(link, "ids=", ids)
    } else {
      link <- paste0(link, "ids=", paste0(ids, collapse = "&ids="))
    }
  }

  #Add Google API key to link
  if (is.character(api.key) == F){
    stop("The API key must be provided in character string format", call. = FALSE)
  } else {
    link <- paste0(link, "&key=", api.key)
  }


  #Add limit to link
  if(is.null(limit) == F){
    if (is.numeric(limit) == F){
      stop("The limit must be provided in numeric format", call. = FALSE)
    } else {
      link <- paste0(link, "&limit=", as.integer(limit))
    }
  }

  #Add language filter to link
  if (is.null(lang) == F){
    if(is.character(lang) == F){
      stop("lang must be provided in character string format", call. = FALSE)
    }else{
      if(lang %in% ISOcodes::ISO_639_2$Alpha_2 == F){
        stop("lang must an ISO-639-1 (i.e. Alpha-2) language code - call ISOcodes::ISO_639_ for possible codes", call. = FALSE)
      }else{
        link <- paste0(link,"&languages=", lang)
      }
    }
  }

  #Add types filter
  if (is.null(types) == F){
    if(is.character(types) == F){
      stop("types must be provided in string format matching available types from Schema.org", call. = FALSE)
    }else{
      if (length(types) == 1){
        link <- paste0(link, "&types=", types)
      } else {
        link <- paste0(link, "&types=", paste0(types, collapse = "&types="))
      }
    }
  }

  #Add indent filter
  if (is.null(indent) == F){
    if(is.logical(indent) == F){
      stop("indent must be provided in logical format", call. = FALSE)
    }else{
      if(indent == TRUE){
        link <- paste0(link, "&indent=true")
      }else{
        link <- paste0(link, "&indent=false")
      }
    }
  }

  #Add prefix filter
  if (is.null(prefix) == F){
    if(is.logical(prefix) == F){
      stop("prefix must be provided in logical format", call. = FALSE)
    }else{
      if(prefix == TRUE){
        link <- paste0(link, "&prefix=true")
      }else{
        link <- paste0(link, "&prefix=false")
      }
    }
  }


  #GET call to extract data
  res <- httr::GET(link)

  if(res$status_code != 200){
    stop(paste0("API request returned error code ", res$status_code))
  }

  if(json == FALSE){
    #Convert data to JSON format
    res <- jsonlite::fromJSON(httr::content(res, as = "text"), flatten = T)

    if (itemList == TRUE){
      # Select only the item list returned by the query
      res <- res$itemListElement

      if(cleanIDs == TRUE){
        res$`result.@id` <- gsub("kg:", "", res$`result.@id`)
      }
    }
  }

  # Returns the final output
  return(res)
}
