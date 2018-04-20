set terminal canvas jsdir ""
set output "/mnt/nexenta/lanno001/nobackup/ab_github_example/analyses/quast/contigs_reports/nucmer_output/flye.html"
set ytics ( \
 "0" 0, \
 "600000" 600000, \
 "1200000" 1200000, \
 "1800000" 1800000, \
 "2400000" 2400000, \
 "3000000" 3000000, \
 "3600000" 3600000, \
 "4200000" 4200000, \
 "4800000" 4800000, \
 "" 4855641 \
)
set size 1,1
set grid
set key outside bottom right
set border 0
set tics scale 0
set xlabel "Reference" noenhanced
set ylabel "Assembly" noenhanced
set format "%.0f"
set xrange [1:*]
set yrange [1:4855641]
set linestyle 1  lt 1 lc rgb "red" lw 3 pt 7 ps 0.5
set linestyle 2  lt 3 lc rgb "blue" lw 3 pt 7 ps 0.5
set linestyle 3  lt 2 lc rgb "yellow" lw 3 pt 7 ps 0.5
plot \
 "/mnt/nexenta/lanno001/nobackup/ab_github_example/analyses/quast/contigs_reports/nucmer_output/flye.fplot" title "FWD" w lp ls 1, \
 "/mnt/nexenta/lanno001/nobackup/ab_github_example/analyses/quast/contigs_reports/nucmer_output/flye.rplot" title "REV" w lp ls 2
