# bin/bash

uv run make_cmif.py

echo "add ids"
uv run add-attributes -g "./data/editions/*.xml" -b "https://id.acdh.oeaw.ac.at/thun/editions"
uv run add-attributes -g "./data/indices/*.xml" -b "https://id.acdh.oeaw.ac.at/thun/indices"
uv run add-attributes -g "./data/meta/*.xml" -b "https://id.acdh.oeaw.ac.at/thun/meta"


echo "create calendar data"
uv run make_calendar_data.py

uv run denormalize-indices -x './/tei:title[@type="label"]/text()' -i './data/indices/list*.xml' -f './data/editions/*.xml'

echo "make listkeyword.xml"
uv run make_keyword_list.py