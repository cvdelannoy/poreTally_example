set terminal canvas jsdir ""
set output "/mnt/nexenta/lanno001/nobackup/ab_github_example/analyses/quast/contigs_reports/nucmer_output/minimap2_miniasm.html"
set ytics ( \
 "0" 0, \
 "300000" 300000, \
 "600000" 600000, \
 "900000" 900000, \
 "1200000" 1200000, \
 "1500000" 1500000, \
 "1800000" 1800000, \
 "2100000" 2100000, \
 "2400000" 2400000, \
 "" 2506984 \
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
set yrange [1:2506984]
set linestyle 1  lt 1 lc rgb "red" lw 3 pt 7 ps 0.5
set linestyle 2  lt 3 lc rgb "blue" lw 3 pt 7 ps 0.5
set linestyle 3  lt 2 lc rgb "yellow" lw 3 pt 7 ps 0.5
plot \
 "/mnt/nexenta/lanno001/nobackup/ab_github_example/analyses/quast/contigs_reports/nucmer_output/minimap2_miniasm.fplot" title "FWD" w lp ls 1, \
 "/mnt/nexenta/lanno001/nobackup/ab_github_example/analyses/quast/contigs_reports/nucmer_output/minimap2_miniasm.rplot" title "REV" w lp ls 2
