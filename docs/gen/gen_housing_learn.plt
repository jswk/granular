#! /usr/bin/gnuplot --persist

set term epslatex color
set out 'w_housing_learn.tex'

set log z
set xlabel "c"
set xrange [] reverse
set zrange [1e-7:1e10]
set ylabel "m"
set zlabel "Q"
set pm3d at b
set logscale cb
splot 'housing.data' u ($1):($2):($3) with lines notitle

