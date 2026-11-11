set terminal png tiny size 800,800
set output "high.png"
set xtics rotate ( \
 "NC_016833.1" 1.0, \
 "NC_016834.1" 215774.0, \
 "NC_016823.1" 224726.0, \
 "" 229880 \
)
set ytics ( \
 "1" 1.0, \
 "2" 215774.0, \
 "*3" 224726.0, \
 "" 229880 \
)
set size 1,1
set grid
unset key
set border 0
set tics scale 0
set xlabel "REF"
set ylabel "QRY"
set format "%.0f"
set mouse format "%.0f"
set mouse mouseformat "[%.0f, %.0f]"
set xrange [1:229880]
set yrange [1:229880]
set style line 1  lt 1 lw 3 pt 6 ps 1
set style line 2  lt 3 lw 3 pt 6 ps 1
set style line 3  lt 2 lw 3 pt 6 ps 1
plot \
 "high.fplot" title "FWD" w lp ls 1, \
 "high.rplot" title "REV" w lp ls 2
