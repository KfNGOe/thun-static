import glob
import os
import pandas as pd
import jinja2


from acdh_tei_pyutils.tei import TeiReader

files = glob.glob('./data/editions/*-an-*.xml')
unbekannt = "unbekannt"
nsmap = {
    'tei': "http://www.tei-c.org/ns/1.0",
    'xml': "http://www.w3.org/XML/1998/namespace",
    'tcf': "http://www.dspin.de/data/textcorpus"
}
doc = TeiReader('./data/indices/listperson.xml')

persons = {}
for x in doc.any_xpath('.//tei:person[@xml:id]'):
    xml_id = x.attrib["{http://www.w3.org/XML/1998/namespace}id"]
    try:
        ref = x.xpath('.//tei:idno/text()', namespaces=nsmap)[0]
    except IndexError:
        continue
    name = " ".join("".join(x.xpath('.//tei:persName//text()', namespaces=nsmap)).split())
    persons[xml_id] = {
        "id": xml_id,
        "ref": ref,
        "name": name
    }
person_df = pd.DataFrame.from_dict(persons, orient='index')
# person_df.to_csv('./tmp/persons.csv', index=False)

doc = TeiReader('./data/indices/listplace.xml')
places = {}
for x in doc.any_xpath('.//tei:place[@xml:id]'):
    xml_id = x.attrib["{http://www.w3.org/XML/1998/namespace}id"]
    try:
        ref = x.xpath('.//tei:idno/text()', namespaces=nsmap)[0]
    except IndexError:
        continue
    name = " ".join("".join(x.xpath('.//tei:placeName[1]//text()', namespaces=nsmap)).split())
    places[xml_id] = {
        "id": xml_id,
        "ref": ref,
        "name": name
    }
places_df = pd.DataFrame.from_dict(places, orient='index')
# places_df.to_csv('./tmp/places.csv', index=False)


items = []
for x in sorted(files):
    _, tails = os.path.split(x)
    item = {
        "doc_id": doc.any_xpath('.//tei:idno[@type="handle"]/text()')[0],
        "sender_ref": unbekannt,
        "sender_place_ref": unbekannt,
        "receiver_ref": unbekannt,
    }
    doc = TeiReader(x)
    item['title'] = doc.any_xpath('.//tei:title[@type="label"]')[0].text
    try:
        item['date'] = doc.any_xpath('.//@when-iso')[0]
    except:
        item['date'] = None
    try:
        item['sender_ref'] = doc.any_xpath('.//tei:title[1]/tei:rs[@type="person"][1]/@ref')[0]
    except:
        pass
    try:
        item['receiver_ref'] = doc.any_xpath('.//tei:title[1]/tei:rs[@type="person"][2]/@ref')[0]
    except:
        pass
    try:
        item['sender_place_ref'] = doc.any_xpath('.//tei:title[1]/tei:rs[@type="place"]/@ref')[0]
    except:
        pass
    for key, value in item.items():
        if '_ref' in key:
            item[key] = value.replace('#', '')
    items.append(item)

df = pd.DataFrame(items)
# df.to_csv('./tmp/basic_cmi.csv', index=False)

df = df.merge(person_df, how='right', left_on="sender_ref", right_on='id')
df = df.merge(person_df, how='right', left_on="receiver_ref", right_on='id')
df = df.merge(places_df, how='left', left_on="sender_place_ref", right_on='id')
df = df[df['ref'].notna()]
df = df.fillna('')
# df.to_csv('./tmp/cmi.csv', index=False)

templateLoader = jinja2.FileSystemLoader(searchpath=".")
templateEnv = jinja2.Environment(loader=templateLoader)
template = templateEnv.get_template('template.j2')
data = []
for i, row in df.iterrows():
    data.append(dict(row))

with open(f'./data/indices/cmfi.xml', 'w') as f:
    f.write(template.render({"data": data}))