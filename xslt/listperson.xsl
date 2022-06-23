<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:import href="./partials/person.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@type='label'][1]/text()"/>
        </xsl:variable>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <xsl:call-template name="html_head">
                <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
            </xsl:call-template>
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid">                        
                        <div class="card">
                            <div class="card-header" style="text-align:center;">
                                <h1>Person Index</h1>
                                <h2>
                                    <a>
                                        <i class="fas fa-info" title="Info" data-toggle="modal" data-target="#exampleModal"/>
                                    </a>
                                    |
                                    <a href="listperson.xml">
                                        <i class="fas fa-download" title="show TEI source"/>
                                    </a>
                                </h2>
                            </div>
                            <div class="card-body">                                
                                <table class="table table-striped display" id="tocTable" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Nachname</th>
                                            <th scope="col">Vorname</th>
                                            <th scope="col">Lebensdaten</th>
                                            <th scope="col">Kurzbiographie</th>
                                            <th scope="col">Erwähnungen</th>
                                            <th scope="col">GND</th>
                                            <th scope="col">ID</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <xsl:for-each select=".//tei:person[@xml:id]">
                                            <xsl:variable name="id">
                                                <xsl:value-of select="data(@xml:id)"/>
                                            </xsl:variable>
                                            <tr>
                                                <td>
                                                    <a>
                                                        <xsl:attribute name="href">
                                                            <xsl:value-of select="concat($id, '.html')"/>
                                                        </xsl:attribute>
                                                        <xsl:value-of select=".//tei:surname/text()"/>
                                                    </a> 
                                                </td>
                                                <td>                                        
                                                    <xsl:value-of select=".//tei:forename/text()"/>
                                                </td>
                                                <td>                                        
                                                    <xsl:value-of select=".//tei:note/tei:p[1]/text()"/>
                                                </td>
                                                <td>                                        
                                                    <xsl:value-of select=".//tei:note/tei:p[2]/text()"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select="count(.//tei:event)"/>
                                                </td>
                                                <td>
                                                    <a>
                                                       <xsl:attribute name="href">
                                                           <xsl:value-of select=".//tei:note/tei:p[3]/text()"/>
                                                       </xsl:attribute>
                                                       <xsl:value-of select=".//tei:note/tei:p[3]/text()"/>
                                                    </a>
                                                </td>
                                                <td>
                                                    <a>
                                                        <xsl:attribute name="href">
                                                            <xsl:value-of select="concat($id, '.html')"/>
                                                        </xsl:attribute>
                                                        <xsl:value-of select="$id"/>
                                                    </a> 
                                                </td>
                                            </tr>
                                        </xsl:for-each>
                                    </tbody>
                                </table>
                            </div>
                        </div>                       
                    </div>
                    <div class="modal" tabindex="-1" role="dialog" id="exampleModal">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Info</h5>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        Der Name der jeweiligen Person ist mit jenen Dokumenten verlinkt, in denen diese Person erwähnt wird.
                                    </p>
                                    <p>
                                        Die Sortierung der einzelnen Spalten kann durch einen Klick auf die Spaltenüberschrift geändert werden. Das Suchfeld links oberhalb der Tabelle durchsucht den gesamten Tabelleninhalt. Darüberhinaus können mit Hilfe der Suchfelder über den Spalten diese gezielt durchsucht bzw. gefiltert werden.
                                    </p>
                                    <p>Die (ggf. gefilterte) Tabelle kann als Excel heruntergeladen bzw. in den Zwischenspeicher kopiert werden.</p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Schließen</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <xsl:call-template name="html_footer"/>
                    <script>
                        $(document).ready(function () {
                        createDataTable('tocTable')
                        });
                    </script>
                </div>
            </body>
        </html>
        <xsl:for-each select=".//tei:person[@xml:id]">
            <xsl:variable name="filename" select="concat(./@xml:id, '.html')"/>
<!--            <xsl:variable name="name" select="normalize-space(string-join(./tei:persName//text()))"></xsl:variable>-->
            <xsl:variable name="name" select="normalize-space(concat(.//tei:forename/text(), ' ', .//tei:surname/text()))"/>
            <xsl:result-document href="{$filename}">
                <html xmlns="http://www.w3.org/1999/xhtml">
                    <xsl:call-template name="html_head">
                        <xsl:with-param name="html_title" select="$name"></xsl:with-param>
                    </xsl:call-template>
                    
                    <body class="page">
                        <div class="hfeed site" id="page">
                            <xsl:call-template name="nav_bar"/>
                            
                            <div class="container-fluid">
                                <div class="card">
                                    <div class="card-header">
                                        <h1 align="center">
                                            <xsl:value-of select="$name"/>
                                        </h1>
                                    </div>
                                    <xsl:call-template name="person_detail"/>
                                </div>
                            </div>
                            
                            <xsl:call-template name="html_footer"/>
                        </div>
                    </body>
                </html>
            </xsl:result-document>
            
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>