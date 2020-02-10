#' Title
#'
#' @param data this can be any dataframe that has sentiment score, length of text and type
#' of review data. but most likely this will be the result from textAnalysisFunction
#'
#'
#' @return either a pair plot or error message if the columns dont exist in dataset
#' @export
#'
#' @examples
plotFunction <- function(data) {
  cols <- colnames(data)
  if("Score" %in% cols && "length" %in% cols &&	"type" %in% cols && length(data[,1] > 0))
  {
    u = data.frame(data$Score,data$length,data$type)
    return(pairs(u))
  } else {
    throw("The dataframe doesn't consist of one or more of these columns (Score, length, type)")
  }

}
