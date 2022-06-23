# bin/bash

echo "add ids"
add-attributes -g "./data/editions/*.xml" -b "https://id.acdh.oeaw.ac.at/thun/editions"
add-attributes -g "./data/indices/*.xml" -b "https://id.acdh.oeaw.ac.at/thun/indices"
add-attributes -g "./data/meta/*.xml" -b "https://id.acdh.oeaw.ac.at/thun/meta"


echo "create calendar data"
python make_calendar_data.py

denormalize-indices -x './/tei:title[@type="label"]/text()' -i './data/indices/list*.xml' -f './data/editions/*.xml'

echo "make listkeyword.xml"
python make_keyword_list.py

echo "indexing"
python make_typesense_index.py