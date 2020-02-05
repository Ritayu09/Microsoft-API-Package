#' Title
#'
#' @param filename 
#' @param IDs 
#' @param subscriptionKey 
#'
#' @return
#' @export
#'
#' @examples
textAnalysisFunction <- function(filename, IDs, subscriptionKey = key){
  
  data.i = read.csv(filename, stringsAsFactors=FALSE)
  data.i = data.i[IDs,]
  
  #data.i
  data_for_api <- data.i[,1:3]
  #data_for_api
  
  #data_for_api <- data_for_api[134:165,]
  #data_for_api
  data_table <- data.frame(Id=integer(),
                           Text=character(),
                           Score=double(),
                           length=integer(),
                           type=character(),
                           error.code=integer(),
                           error.message =character(),
                           url=character(),
                           stringsAsFactors=FALSE)
  
  for  (i in 1:length(data_for_api[,1])) {
    data <- data_for_api[i,]
    p = toJSON(list(documents = data), auto_unbox = TRUE)
    #print(p)
    r <- POST("https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.1/sentiment?showStats=1", body = p, add_headers(.headers =    
                                                                                                                                     c('Content-Type' = "application/json", 'Ocp-Apim-Subscription-Key' = key)))
    #r$status_code
    #print(content(r))
    if (r$status_code == 200){
      id = content(r)$documents[[1]]$id
      score <- as.numeric(content(r)$documents[[1]]$score)
      error.code = NA
      error.message = NA
      url = r$url
    } else {
      id = data$id
      score = NA
      error.code = r$status_code
      if(is.null(content(r)$error) ){
        error.message = content(r)$message
        url = r$url
      } else {
        error.message = content(r)$error$message
        url = r$url
      }
    }
    #print(score)
    #print(error.code)
    #print(error.message)
    #print(url)
    #print(c(id, data$text, score, as.numeric(data.i[i,]$length_processed_text), data.i[i,]$type, error.code, error.message, url))
    data_table[nrow(data_table) + 1,] = c(id, data$text, score, as.numeric(data.i[i,]$length_processed_text), data.i[i,]$type, error.code, error.message, url)
  }
  
  data_table$Score = as.numeric(data_table$Score)
  data_table$length = as.numeric(data_table$length)
  data_table$type = as.factor(data_table$type)
  return(data_table)
}