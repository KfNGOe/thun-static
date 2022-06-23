rm master.zip
rm -rf data
wget https://github.com/KONDE-AT/thun-data/archive/refs/heads/master.zip
unzip master
mv thun-data-master ./data
./dl_imprint.sh
rm master.zip

find ./data/indices/ -type f -name "listperson.xml"  -print0 | xargs -0 sed -i -e 's@<p>k_A</p>@<p/>@g'
find ./data/indices/ -type f -name "listperson.xml"  -print0 | xargs -0 sed -i -e 's@<p>no gnd provided</p>@<p/>@g'