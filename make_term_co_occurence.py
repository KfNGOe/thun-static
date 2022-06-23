import itertools
import pandas as pd
import networkx as nx
import numpy

from collections import Counter
from acdh_tei_pyutils.tei import TeiReader



file = "https://thun-korrespondenz.acdh.oeaw.ac.at/listkeyword.xml"

doc = TeiReader(file)
docs = set(doc.any_xpath('.//tei:ref/@target'))
doc_list = []
for x in docs:
    terms = doc.any_xpath(f'.//tei:item[.//@target="{x}"]/tei:term/text()')
    doc_list.append(terms)

varnames = tuple(sorted(set(itertools.chain(*doc_list))))
expanded = [tuple(itertools.combinations(d, 2)) for d in doc_list]
expanded = itertools.chain(*expanded)
expanded = [tuple(sorted(d)) for d in expanded]
c = Counter(expanded)
table = numpy.zeros((len(varnames),len(varnames)), dtype=int)
for i, v1 in enumerate(varnames):
    for j, v2 in enumerate(varnames[i:]):        
        j = j + i 
        table[i, j] = c[v1, v2]
        table[j, i] = c[v1, v2]
df = pd.DataFrame(table, index=varnames, columns=varnames)
G=nx.from_numpy_matrix(df.to_numpy())
node_labels = {i: {'label':x} for i, x in enumerate(df.columns)}
nx.set_node_attributes(G, node_labels)
nx.write_gexf(G, "hansi.gexf")