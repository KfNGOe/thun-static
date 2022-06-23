import glob
import os
from collections import defaultdict, OrderedDict
from acdh_tei_pyutils.tei import TeiReader
from slugify import slugify
from tqdm import tqdm
import lxml.etree as ET

files = glob.glob('./data/editions/*xml')
out_file = "./data/indices/listkeyword.xml"
template = """
<?xml version="1.0" encoding="UTF-8"?>
<TEI xmlns="http://www.tei-c.org/ns/1.0">
   <teiHeader>
      <fileDesc>
         <titleStmt>
            <title type="label">Schlagwortverzeichnis</title>
            <respStmt>
               <resp>providing the content</resp>
               <name>Tanja Kraler</name>
               <name>Christof Aichner</name>
            </respStmt>
         </titleStmt>
         <publicationStmt>
            <p>
               <idno type="handle">http://hdl.handle.net/21.11115/0000-000E-8B70-7</idno>
            </p>
         </publicationStmt>
         <sourceDesc>
            <p>Schlagwortverzeichnis der Thun-Korrespondenz</p>
         </sourceDesc>
      </fileDesc>
   </teiHeader>
  <text>
      <body>
         <div type="index_keywords">
            <list/>
         </div>
      </body>
  </text>
</TEI>
"""
tei_doc = TeiReader(template)
root = tei_doc.any_xpath('.//tei:list')[0]
data = []
d = defaultdict(list)
for x in tqdm(files, total=len(files)):
# for x in tqdm(files[:100], total=100):
    item = {}
    head, tail = os.path.split(x)
    doc = TeiReader(x)
    doc_name = doc.any_xpath('//tei:title[@type="label"]/text()')[0]
    item['name'] = doc_name
    item['id'] = tail
    item['terms'] = []
    for term in doc.any_xpath('.//tei:term'):
        if term.text:
            d[term.text].append([tail, doc_name])
            term_id = slugify(term.text)
        else:
            continue
        term.attrib['key'] = term_id
    doc.tree_to_file(x)

for key, value in OrderedDict(sorted(d.items())).items():
    item = ET.Element("{http://www.tei-c.org/ns/1.0}item")
    term = ET.Element("{http://www.tei-c.org/ns/1.0}term")
    term.text = key
    try:
        term.attrib["{http://www.w3.org/XML/1998/namespace}id"] = slugify(key)
    except:
        print(key, value)
        continue
    item.append(term)
    for ptr in value:
        ref_node = ET.Element("{http://www.tei-c.org/ns/1.0}ref")
        ref_node.attrib['target'] = ptr[0]
        ref_node.text = ptr[1]
        item.append(ref_node)
    root.append(item)
tei_doc.tree_to_file(out_file)


