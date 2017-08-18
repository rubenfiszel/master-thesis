#!/usr/bin/sh

echo "Start building"

interactive_spellcheck=false
batch_spellcheck=false
blog=false
inc=false

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
        --inc)
	    inc=true
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

cd images
if [ $inc = false ]; then
    for gif in *.gif
    do
	echo "Processing $gif"
	convert $gif "${gif%%.*}".png
    done
    for pdf in *.pdf
    do
	echo "Processing $pdf"
	convert $pdf "${pdf%%.*}".png
    done
fi

cd ..
cp -r templates/ build/
cp -r scripts/ build/

cd build/

cp templates/thesis.md tmp_thesis.md
replace_in_file tmp_thesis.md src/rbpf.md '${rbpf}' > tmp_thesis2.md
replace_in_file tmp_thesis2.md src/flow.md '${flow}' > tmp_thesis3.md
replace_in_file tmp_thesis3.md src/interpreter.md '${interpreter}' > tmp_thesis4.md
replace_in_file tmp_thesis4.md src/spatial.md '${spatial}' > tmp_thesis5.md
replace_in_file tmp_thesis5.md src/lang-ref.tex '${lang-ref}' > tmp_thesis6.md
replace_in_file tmp_thesis6.md src/minpf.md '${minpf}' > tmp_thesis7.md
replace_in_file tmp_thesis7.md src/rbpfc.md '${rbpfc}' > tmp_thesis8.md

sed -i 's/.gif/-0.png/g' tmp_thesis8.md
sed -i 's/.webm/.png/g' tmp_thesis8.md
sed -ir 's/```scala/```{.scala bgcolor=bg autogobble=true framesep=2mm fontsize=\\scriptsize}/g' tmp_thesis8.md
sed -ir 's/```graph/```{.text fontsize=\\footnotesize samepage=true}/g' tmp_thesis8.md
sed -ir 's/```mermaid/```{.mermaid format=svg loc=media}/g' tmp_thesis8.md

mkdir -p media

pandoc tmp_thesis8.md \
       --template=templates/tmpl.tex \
       --smart \
       --reference-links \
       --standalone \
       --default-image-extension=pdf \
       --toc \
       --toc-depth=2 \
       --latex-engine-opt=-shell-escape \
       --highlight-style=tango \
       --filter mermaid-filter --filter pandoc-minted --filter pandoc-citeproc \
       --bibliography=src/thesis.bib \
       --csl templates/computer.csl \
       -V fontsize=11pt \
       --variable="geometry:a4paper, hmargin=4cm, bottom=4cm, top=3cm" \
       -o thesis.tex

if [ $inc = false ]; then
    for svg in media/*.svg
    do
	echo "Processing $svg"
	phantomjs ../rasterize.js $svg "${svg%%.*}".pdf 
	#    inkscape $svg --export-pdf="${svg%%.*}".pdf 
    done
fi

sed -i 's/\\includegraphics{\(media\/diagram-10\).svg}/\\begin{wrapfigure}{L}{5cm}\\vspace{-1cm}\\centering\\includegraphics[width=4cm]{\1.pdf}\\caption{Flow diagram of the argon compiler}\\vspace{-1cm}\\end{wrapfigure}/g' thesis.tex
sed -i 's/\\includegraphics{\(media\/diagram-12\).svg}/\\begin{wrapfigure}{R}{5cm}\\centering\\includegraphics{\1.pdf}\\caption{Flow diagram of the argon interpreter}\\vspace{-3cm}\\end{wrapfigure}/g' thesis.tex
sed -i 's/\\includegraphics{\(.*\).svg}/\\begin{figure}\\centering\\includegraphics{\1.pdf}\\end{figure}/g' thesis.tex

#pdflatex -shell-escape thesis.tex
xelatex -shell-escape thesis.tex
xelatex -shell-escape thesis.tex 

cp thesis.pdf ../../hakyll-website/assets/
cp thesis.pdf ..
echo "thesis written to thesis.pdf"


build_post() {
    cp "templates/$1" "tmp_$1"
    replace_in_file "tmp_$1" src/$2 "\${$3}" > "tmp_${1}2.md"
    rm -rf ../$4
    mkdir ../$4
    cp "tmp_${1}2.md" ../$4/$5
    sed -i 's/.pdf/.png/g' ../$4/$5
    sed -i 's/thesis.png/thesis.pdf/g' ../$4/$5            
    cp ../images/* ../$4/

    rm -rf ../../hakyll-website/posts/$4
    cp -r ../$4 ../../hakyll-website/posts/
    
    echo "post $1 written to $4"
}

if [ $blog = true ]; then
    build_post post1.md rbpf.md rbpf th1 2017-08-16-thesis-part-1.md
    build_post post2.md flow.md flow th2 2017-08-16-thesis-part-2.md
    build_post post3.md interpreter.md interpreter th3 2017-08-16-thesis-part-3.md        
    build_post post4.md spatial.md spatial th4 2017-08-16-thesis-part-4.md

    cp templates/computer.csl ../../hakyll-website/csl/
    cp src/thesis.bib ../../hakyll-website/bib/    

    cd ..
#    rm -rf build/
    
    cd ../hakyll-website
    stack exec site build
else
    cd ..
#    rm -rf build/    
fi


