set datafile separator ','
set xdata time
set timefmt "%H:%M:%S"
set key autotitle columnhead
set ylabel "FPS" 
set xlabel 'Time'

set y2tics # enable second axis
set ytics nomirror # dont show the tics on that side
set y2label "Units" # label for second axis

plot "logPerformance.csv" using 1:2 with lines, '' using 1:5 with lines axis x1y2
