# scHCLlite

**A simplized version of R package scHCL, only keep *scHCL* function but make it faster.**

The origianl R package scHCL is [here](https://github.com/ggjlab/scHCL), great respect to [Human Cell Landscape](http://bis.zju.edu.cn/HCL/) project.

### Installation

```R
# devtools required
> install.packages("devtools")
> devtools::install_github("sajuukLyu/scHCLlite")
```

### Quick Start

```R
> library(scHCLlite)
# hcl_lung is an example expression matrix from HCL project.
> data(hcl_lung)
> dim(hcl_lung)
[1] 2884  160
# 2884 genes expression value of 80 cells

> head(rownames(hcl_lung))
[1] "Mbp"    "Tspan2" "Plp1"   "Ermn"   "Mag"    "Mal"
```

Like scHCL, scHCLlite has two parameters: `scdata`,  a single-cell gene expression matrix with each row a gene and each column a cell and `num`, a number setting how many most similar cell types should be returned.

However, the gene names should be the **symbol name of human gene**. So we need to uppercase the row names of input data.

```R
> rownames(hcl_lung) <- toupper(rownames(hcl_lung))
> head(rownames(hcl_lung))
[1] "MBP"    "TSPAN2" "PLP1"   "ERMN"   "MAG"    "MAL"

# now we can run scHCLlite.
> hcl_result <- scHCLlite(scdata = hcl_lung, num = 3)
1471 genes used, calculating correlation coefficient...
20 types expected, extracting top 3 results...
```

The return of scHCLlite() is a list which contains 4 parts, very similar to scHCL().

- cors_matrix: the pearson correlation coefficient matrix of each cell and cell type.
- top_cors: equals to `num`.
- scHCL: the most relevant cell type for each query cell.
- scHCL_similarity: the top n relevant cell types for each query cell.

