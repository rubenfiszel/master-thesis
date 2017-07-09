#!/usr/bin/sh

echo "Start building"

interactive_spellcheck=false
batch_spellcheck=false
blog=false

# Process command line arguments
while test $# -gt 0
do
    case "$1" in
        --ispell)
	    interactive_spellcheck=true
	    shift
            ;;
        --bspell)
	    batch_spellcheck=true
	    shift
            ;;
        --blog)
	    blog=true
	    shift		
            ;;
        *)
	    echo "unrecognized option $1"
            ;;
    esac
    shift
done


replace_in_file () {    
    python scripts/replace_in_file.py $1 $2 $3 
}


# Spell check the files
if [ $interactive_spellcheck = true ]; then
  # Run interactive mode to fix spelling mistakes
  mdspell --ignore-acronyms --en-us src/*.md || exit 1
elif [ $batch_spellcheck = true ]; then
  mdspell --report --ignore-acronyms --en-us src/*.md
fi

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
replace_in_file tmp_thesis3.md src/spatial.md '${spatial}' > tmp_thesis4.md

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

cp thesis.pdf ../../hakyll-website/assets/
cp thesis.pdf ..
echo "thesis written to thesis.pdf"


build_post() {
    cp "templates/$1" "tmp_$1"
    replace_in_file "tmp_$1" src/$2 "\${$3}" > "tmp_${1}2.md"
    rm -rf ../$4
    mkdir ../$4
    cp "tmp_${1}2.md" ../$4/$5
    cp ../images/* ../$4/

    rm -rf ../../hakyll-website/posts/$4
    cp -r ../$4 ../../hakyll-website/posts/
    echo "post $1 written to $4"
}

if [ $blog = true ]; then
    build_post post1.md rbpf.md rbpf th1 2017-08-16-thesis-part-1.md
    build_post post2.md flow.md flow th2 2017-08-16-thesis-part-2.md
    build_post post3.md spatial.md spatial th3 2017-08-16-thesis-part-3.md

    rm -rf build/

    cd ../../hakyll-website
    stack exec site build
fi
