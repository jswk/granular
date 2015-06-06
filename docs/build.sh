#!/bin/bash
set -e

texname="docs"

if [ ! -e $texname".tex" ]; then
    echo "$texname.tex doesn't exist. Exiting..."
    exit 1
fi

echo -n "Cleaning last build... "
rm -rf .build
echo "OK"

set +e

echo -n "Recreating build directory and copying files... "
mkdir -p .build
for file in *.tex *.plt *.data *.eps *.png *jpg *.sty gen/*plt data/*.data tab/*.tex fig/*; do
    if [ -f $file ]; then
        cp $file .build
        if [ $? -ne 0 ]; then
            exit 1
        fi
    fi
done
echo "OK"

cd .build

# generate all plots
if ls *.plt &>/dev/null; then
    for f in *.plt; do
        echo -n "Generating $f... "
        chmod u+x $f
        ./$f &>/dev/null
        echo "OK"
    done
fi


echo -n "Generating $texname... "
pdflatex -interaction=nonstopmode $texname.tex 1>/dev/null
if [ $? -ne 0 ]; then
    echo ""
    rm -f $texname.aux
    pdflatex $texname.tex
    exit 1
else
    echo "OK"
fi

set -e

echo -n "Second pass... "
pdflatex -interaction=nonstopmode $texname.tex 1>/dev/null
echo "OK"

cd ..
cp .build/$texname.pdf ./$texname.pdf
echo "Output copied to "`pwd`"/$texname.pdf"
