<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title" select="'Gesamtübersicht'"/>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html xmlns="http://www.w3.org/1999/xhtml">
            <xsl:call-template name="html_head">
                <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
            </xsl:call-template>
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid">
                        <div class="card">
                            <div class="card-header" style="text-align:center;">
                                <h1>Gesamtübersicht</h1>
                                 <small><xsl:value-of select="count(collection('../data/editions')//tei:TEI)"/><xsl:text> </xsl:text>Dokumente</small>
                            </div>
                            <div class="card-body">
                                <table class="table table-striped display" id="tocTable" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Dokumenttitel</th>
                                            <th scope="col">Absender</th>
                                            <th scope="col">Empfänger</th>
                                            <th scope="col">Ausstellungsort</th>
                                            <th scope="col">Datum</th>
                                            <th scope="col">Dateiname</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <xsl:for-each select="collection('../data/editions')//tei:TEI">
                                            <xsl:variable name="full_path">
                                                <xsl:value-of select="document-uri(/)"/>
                                            </xsl:variable>
                                            <xsl:variable name="sender">
                                                <xsl:value-of select="normalize-space(string-join(.//tei:title[1]/tei:rs[contains(./@role, 'sender')][1]/text()))"/>
                                            </xsl:variable>
                                            <xsl:variable name="receiver">
                                                <xsl:value-of select="normalize-space(string-join(.//tei:title[1]/tei:rs[contains(./@role, 'recipient')][1]/text()))"/>
                                            </xsl:variable>
                                            <tr>
                                                <td>                                        
                                                    <a>
                                                        <xsl:attribute name="href">                                                
                                                            <xsl:value-of select="replace(tokenize($full_path, '/')[last()], '.xml', '.html')"/>
                                                        </xsl:attribute>
                                                        <xsl:value-of select=".//tei:title[@type='label']/text()"/>
                                                    </a>
                                                </td>
                                                <td>
                                                    <xsl:choose>
                                                        <xsl:when test="count(tokenize($sender, ' ')) eq 2">
                                                            <xsl:value-of select="tokenize($sender, ' ')[last()]"/>, <xsl:value-of select="tokenize($sender, ' ')[1]"/>
                                                        </xsl:when>
                                                        <xsl:when test="count(tokenize($sender, ' ')) gt 2">
                                                            <xsl:value-of select="tokenize($sender, ' ')[last()]"/>, <xsl:value-of select="tokenize($sender, ' ')[1]"/><xsl:text> </xsl:text><xsl:value-of select="tokenize($sender, ' ')[2]"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            kein Absender
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </td>
                                                <td>
                                                    <xsl:choose>
                                                        <xsl:when test="count(tokenize($receiver, ' ')) eq 2">
                                                            <xsl:value-of select="tokenize($receiver, ' ')[last()]"/>, <xsl:value-of select="tokenize($receiver, ' ')[1]"/>
                                                        </xsl:when>
                                                        <xsl:when test="count(tokenize($receiver, ' ')) gt 2">
                                                            <xsl:value-of select="tokenize($receiver, ' ')[last()]"/>, <xsl:value-of select="tokenize($receiver, ' ')[1]"/><xsl:text> </xsl:text><xsl:value-of select="tokenize($receiver, ' ')[2]"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            kein Empfänger
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </td>
                                                <td>
                                                    <xsl:value-of select="normalize-space(string-join(.//tei:title[1]/tei:rs[@type='place'][1]/text()))"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select="data(.//tei:title[1]//tei:date[1]/@*)"/>
                                                </td>
                                                <td>
                                                    <xsl:value-of select="tokenize($full_path, '/')[last()]"/>
                                                </td>  
                                            </tr>
                                        </xsl:for-each>
                                    </tbody>
                                </table>
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
    </xsl:template>
    <xsl:template match="tei:div//tei:head">
        <h2 id="{generate-id()}"><xsl:apply-templates/></h2>
    </xsl:template>
    
    <xsl:template match="tei:p">
        <p id="{generate-id()}"><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="tei:list">
        <ul id="{generate-id()}"><xsl:apply-templates/></ul>
    </xsl:template>
    
    <xsl:template match="tei:item">
        <li id="{generate-id()}"><xsl:apply-templates/></li>
    </xsl:template>
    <xsl:template match="tei:ref">
        <xsl:choose>
            <xsl:when test="starts-with(data(@target), 'http')">
                <a>
                    <xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute>
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>