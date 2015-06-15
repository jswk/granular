#! /usr/bin/gnuplot --persist

set term epslatex color
set out 'w_mpg_test.tex'

set log z
set xlabel "c"
set xrange [] reverse
set zrange [0.1:1e6]
set ylabel "m"
set zlabel "\$Q_\\text{test}\$"
set pm3d at b
set logscale cb
splot 'mpg.data' u ($1):($2):($4) with lines notitle

