import glob
import os
import ciso8601
import time
import typesense

from typesense.api_call import ObjectNotFound
from acdh_cfts_pyutils import TYPESENSE_CLIENT as client
from acdh_cfts_pyutils import CFTS_COLLECTION
from acdh_tei_pyutils.tei import TeiReader
from tqdm import tqdm

files = glob.glob('./data/editions/*.xml')

try:
    client.collections['thun-static'].delete()
except ObjectNotFound:
    pass

current_schema = {
    'name': 'thun-static',
    'fields': [
        {
            'name': 'id',
            'type': 'string',
        },
        {
            'name': 'rec_id',
            'type': 'string'
        },
        {
            'name': 'title',
            'type': 'string'
        },
        {
            'name': 'full_text',
            'type': 'string'
        },
        {
            'name': 'date',
            'type': 'int64',
            'facet': True
        },
        {
            'name': 'year',
            'type': 'int32',
            'optional': True,
            'facet': True
        },
        {
            'name': 'persons',
            'type': 'string[]',
            'facet': True,
            'optional': True
        },
        {
            'name': 'places',
            'type': 'string[]',
            'facet': True,
            'optional': True
        },
        {
            'name': 'orgs',
            'type': 'string[]',
            'facet': True,
            'optional': True
        },
        {
            'name': 'keywords',
            'type': 'string[]',
            'facet': True,
            'optional': True
        }
    ],
    'default_sorting_field': 'date',
}

client.collections.create(current_schema)

records = []
cfts_records = []
for x in tqdm(files, total=len(files)):
    cfts_record = {
        'project': 'thun-static',
    }
    record = {}
    doc = TeiReader(x)
    body = doc.any_xpath('.//tei:body')[0]
    record['rec_id'] = os.path.split(x)[-1]
    cfts_record['rec_id'] = record['rec_id']
    record['id'] = os.path.split(x)[-1].replace('.xml', '')
    cfts_record['resolver'] = f"https://thun-korrespondenz.acdh.oeaw.ac.at/{record['id']}.html"
    cfts_record['id'] = record['id']
    record['title'] = " ".join(" ".join(doc.any_xpath('.//tei:title[@type="label"]//text()')).split())
    cfts_record['title'] = record['title']
    try:
        date_str = doc.any_xpath('.//tei:date[@when-iso]/@when-iso')[0]
    except:
        date_str = "1000-01-01" 
    record['year'] = int(date_str[:4])
    cfts_record['id'] = record['id']
    try:
        ts = ciso8601.parse_datetime(date_str)
    except ValueError:
        ts = ciso8601.parse_datetime('1000-01-01')

    record['date'] = int(time.mktime(ts.timetuple()))
    cfts_record['date'] = record['date']
    record['persons'] = [
        " ".join(" ".join(x.xpath('.//text()')).split()) for x in doc.any_xpath('.//tei:person[@xml:id]/tei:persName')
    ]
    cfts_record['persons'] = record['persons']
    record['places'] = [
         " ".join(" ".join(x.xpath('.//text()')).split()) for x in doc.any_xpath('.//tei:place[@xml:id]/tei:placeName')
    ]
    cfts_record['places'] = record['places']
    record['orgs'] = [
         " ".join(" ".join(x.xpath('.//text()')).split()) for x in doc.any_xpath('.//tei:org[@xml:id]/tei:orgName')
    ]
    cfts_record['orgs'] = record['orgs']
    record['keywords'] = [
         " ".join(" ".join(x.xpath('.//text()')).split()) for x in doc.any_xpath('.//tei:index/tei:term')
    ]
    cfts_record['keywords'] = record['keywords']
    record['full_text'] = " ".join(''.join(body.itertext()).split())
    cfts_record['full_text'] = record['full_text']
    records.append(record)
    cfts_records.append(cfts_record)

make_index = client.collections['thun-static'].documents.import_(records)
print('done with indexing')

print("delete existing items")
delete = CFTS_COLLECTION.documents.delete({'filter_by': 'project:=thun-static'})
print(delete)
make_index = CFTS_COLLECTION.documents.import_(cfts_records)
print('done with central indexing')