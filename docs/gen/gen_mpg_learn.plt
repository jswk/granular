#! /usr/bin/gnuplot --persist

set term epslatex color
set out 'w_mpg_learn.tex'

set log z
set xlabel "c"
set xrange [] reverse
set zrange [0.1:1e6]
set ylabel "m"
set zlabel "Q"
set pm3d at b
set logscale cb
splot 'mpg.data' u ($1):($2):($3) with lines notitle

