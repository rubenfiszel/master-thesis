#!/usr/bin/sh

replace_in_file () {    
    python scripts/replace_in_file.py $1 $2 $3 
}


# Create build directory if not present
if [ ! -d build ]; then 
  mkdir build
fi

cp -r src/ build/
cp images/* build/
cp -r templates/ build/
cp -r scripts/ build/

cd build/

cp templates/thesis.md tmp_thesis.md
replace_in_file tmp_thesis.md src/rbpf.md '${rbpf}' > tmp_thesis2.md
replace_in_file tmp_thesis2.md src/flow.md '${flow}' > tmp_thesis3.md

pandoc tmp_thesis3.md \
       --template=templates/tmpl.tex \
       --smart \
       --include-in-header=templates/break-sections.tex \
       --reference-links \
       --standalone \
       --number-sections \
       --default-image-extension=pdf \
       --toc \
       --highlight-style=tango \
       --filter pandoc-citeproc \
       --bibliography=src/thesis.bib \
       --csl templates/computer.csl \
       -V fontsize=12pt \
       --variable=geometry:a4paper \
       -o thesis.pdf

cp thesis.pdf ..

cp templates/post1.md tmp_post1.md
replace_in_file tmp_post1.md src/rbpf.md '${rbpf}' > tmp_post12.md
rm -rf ../th1
mkdir ../th1
cp tmp_post12.md ../th1/2017-08-16-thesis-part-1.md
cp ../images/* ../th1/

rm -rf ../../hakyll-website/posts/th1
cp -r ../th1 ../../hakyll-website/posts/

cp templates/post2.md tmp_post2.md
replace_in_file tmp_post2.md src/flow.md '${flow}' > tmp_post22.md
rm -rf ../th2
mkdir ../th2
cp tmp_post22.md ../th2/2017-08-16-thesis-part-2.md
cp ../images/* ../th2/

rm -rf ../../hakyll-website/posts/th2
cp -r ../th2 ../../hakyll-website/posts/

rm -rf build/

cd ../../hakyll-website
stack exec site build
