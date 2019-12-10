library(jsonlite)  
library(data.table)  
library(ggplot2)

# Replace "iperf3.json" with the output filename
# you saved your iperf data to, if different
jsonData <- fromJSON("iperf3.json")  
df <- rbindlist(jsonData$intervals$streams)

q <- ggplot(df) + theme_minimal()  
q <- q + geom_line(aes(x=start, y=snd_cwnd))  
q <- q + scale_x_continuous("Time (s)")  
q <- q + scale_y_continuous("CWND")  
# Saves output to a file called "iperf3.png"
# Use a different output filename, if you prefer
png("iperf3.png")  
print(q)  
dev.off()

quit('no')
