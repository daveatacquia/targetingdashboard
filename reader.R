library(jsonlite)
library(rCharts)

data <- fromJSON("./data/example.json")

## Totals for Boxes
total.shown <- data$totals$shown
total.converted <- data$totals$converted
total.cr <- data$totals$conversionrate

## Plot for Segments
seg <- data$segments
segment.names <- names(seg)
df <- data.frame(segment=NULL,variation=NULL,cr=NULL)
for(i in seq_along(seg)) {
    for(j in seq_along(seg[[i]]$variations)) {
        #seg[[i]]$variations[[j]]$results$conversionrate
        variation.names <- names(seg[[i]]$variations)
        df <- rbind(df, 
              data.frame(segment=segment.names[i], 
                         variation=variation.names[j],
                         cr=seg[[i]]$variations[[j]]$results$conversionrate))
    }
}
n1 <- nPlot(cr ~ segment, group = "variation", data = df, type = "multiBarChart")
n1
## use n1$print("chart3") in order to print
