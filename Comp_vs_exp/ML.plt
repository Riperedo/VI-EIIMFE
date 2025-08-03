reset

Experimento = "ML.dat"
Teoria = "sdk_ML.dat"

set xlabel "q(nm)" font "Times, 20"
set ylabel "S(q)" font "Times, 20"

set xrange [0:0.03]
set yrange [0:2.5]

set key font "Times, 20"

plot Experimento pt 4 ps 2.0 lc rgb "black" t "EXperimento", \
     Teoria u ($1*0.007):2 w l lw 2 lt "--" lc rgb "black" t "OZE"
