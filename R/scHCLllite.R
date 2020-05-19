
#' Human Cell Landscape mapping
#'
#' simplized version of origianl scHCL function.
#'
#' @param scdata matrix-like data input, log-normalized data recommended.
#' @param num the number of the most similiar cell types returned, default 3.
#'
#' @return a list containing cors_matrix, top_cors, scHCL and scHCL_similarity.
#' @export
#' @importFrom reshape2 melt
#' @import dplyr
scHCLlite <- function(scdata, num = 3){

  tst.expr <- scdata
  used.gene <- intersect(rownames(ref.expr), rownames(ncov.int))
  tst.expr <- tst.expr[used.gene, ]

  message(length(used.gene), " genes used, calculating correlation coefficient...")
  cors <- cor(log2(ref.expr[used.gene, ] + 1), as.matrix(tst.expr), method = "pearson")

  cors.index <- apply(cors, 2, function(x){order(x, decreasing = T)[1:num]})
  cors.index <- as.integer(cors.index) %>% unique() %>% sort()

  type.res <- apply(cors, 2, function(x){rownames(cors)[which.max(x)]})

  message(length(cors.index), " types expected, extracting top ", num, " results...")
  cors_in = cors[cors.index, ]
  cors_out = reshape2::melt(cors_in)[c(2, 1, 3)]
  colnames(cors_out)<- c("Cell", "Type", "Score")
  cors_out <- as.data.frame(cors_out %>% group_by(Cell) %>% top_n(n = num, wt = Score))

  result <- list()
  result[["cors_matrix"]] <- cors
  result[['top_cors']] <- num
  result[['scHCL']] <- type.res
  result[['scHCL_similarity']] <- cors_out
  return(result)

}
