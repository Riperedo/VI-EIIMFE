reset

Experimento = "MS.dat"
Teoria = "sdk_MS.dat"

set xlabel "q(nm)" font "Times, 20"
set ylabel "S(q)" font "Times, 20"

set xrange [0:0.03]
set yrange [0:2.5]

set key font "Times, 20"

plot Experimento pt 6 ps 2.0 lc rgb "red" t "Experimento", \
     Teoria u ($1*0.031):2 w l lw 2 lt "--" lc rgb "red" t "OZE"
