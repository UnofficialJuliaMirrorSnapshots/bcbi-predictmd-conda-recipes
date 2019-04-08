set -o verbose
set -o errexit

#wget --output-document=pdf2svg.tar.gz https://github.com/dawbarton/pdf2svg/archive/v0.2.3.tar.gz
cp $RECIPE_DIR/downloads/pdf2svg-0.2.3.tar.gz .
mv pdf2svg-0.2.3.tar.gz pdf2svg.tar.gz
tar -vzxf pdf2svg.tar.gz
rm -f pdf2svg.tar.gz
mv pdf2svg-* pdf2svg
cd pdf2svg
./configure --prefix=$PREFIX
make
make install
cd ..
rm -rf pdf2svg
