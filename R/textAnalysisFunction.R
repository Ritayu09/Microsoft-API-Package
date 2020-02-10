#' Title
#'
#' @param filename : Name of Csv file that needs to be processed.
#' Note it should have Id, language and text columns as the first three columns and the bare minimum.
#' @param IDs (This is a sequence/list of Ids that need to be processed)
#' @param subscriptionKey This is the Microsoft text analytics subscription key.
#'
#' @return
#' @export
#'
#' @examples textAnalysisFunction('test.csv', 1:6, '8f8ab4688a644bc8bc08e95b52f9175c')
textAnalysisFunction <- function(filename, IDs, key){

  # read csv file whose name/location is provided by user
  data.i = read.csv(filename, stringsAsFactors=FALSE)

  # filter only those rows whose id's are provided by user
  data.i = data.i[IDs,]

  # we only need id, language and text for further processing so we use first 3
  data_for_api <- data.i[,1:3]

  # creation of a dataframe for storing all the intermediate results from api processing.
  data_table <- data.frame(Id=integer(),
                           Text=character(),
                           Score=double(),
                           length=integer(),
                           type=character(),
                           status.code=integer(),
                           error.message =character(),
                           url=character(),
                           stringsAsFactors=FALSE)

  # loop over all rows in dataset from users and store the results in the dataframe created above.
  for  (i in 1:length(data_for_api[,1])) {

    # select one row from he dataset for single api processing.
    data <- data_for_api[i,]

    # convert the data into appropriate json format so that api post call can be made.
    p = toJSON(list(documents = data), auto_unbox = TRUE)

    # Post call to MS text analytics API in west central region to obtain sentiment results
    r <- POST("https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.1/sentiment?showStats=1",
              body = p, add_headers(.headers =
                                      c('Content-Type' = "application/json", 'Ocp-Apim-Subscription-Key' = key)))

    # if api call is successful and we get some output then store that first, else try to
    # get some other useful information like status code, error message etc. for debugging later
    if (r$status_code == 200 && length(content(r)$documents) > 0){
      id = data$Id
      # we try to see if a status of 200 can give score, if not then try obtaining the error
      # this can happen in cases like when languge is not in the list of languages supported by Api
      tryCatch(
        expr = {
          score <- as.numeric(content(r)$documents[[1]]$score)
        },
        error = function(e){
          score <- NA
        })
      error.code = 200
      error.message = NA
      url = r$url
    } else {
      id = data$Id
      score = NA
      error.code = r$status_code
      if(is.null(content(r)$error) ){
        error.message = content(r)$message
        url = r$url
      } else if (length(content(r)$documents) == 0 && length(content(r)$errors) > 0){
        error.message = content(r)$errors[[1]]$message
        url = r$url
      } else {
        error.message = content(r)$error$message
        url = r$url
      }
    }

    # code for debugging the number of columns in dataframe
    #print(c(id, data$text, score, as.numeric(data.i[i,]$length_processed_text), data.i[i,]$type, error.code, error.message, url))

    # add new rows to dataframe that has 8 columns
    data_table[nrow(data_table) + 1,] = c(id, data$text, score, as.numeric(data.i[i,]$length_processed_text), data.i[i,]$type, error.code, error.message, url)

    # if there have been 30 calls already then take a break of more than a minute before another batch of 30
    if (i > 1 && i%%30 == 0 && test==0){
      Sys.sleep(61)
    }
  }

  # Converting the data to apporpriate format for further processing
  data_table$Score = as.numeric(data_table$Score)
  data_table$length = as.numeric(data_table$length)
  data_table$type = as.factor(data_table$type)

  # return the final dataframe that contains all the results of the batch of processed text
  return(data_table)
}
