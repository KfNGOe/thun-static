<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://dse-static.foo.bar"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:import href="./partials/shared.xsl"/>
    <xsl:import href="./partials/person.xsl"/>
    <xsl:import href="./partials/place.xsl"/>
    <xsl:import href="./partials/org.xsl"/>
    
    <xsl:variable name="prev">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@prev), '/')[last()], '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="next">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@next), '/')[last()], '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="teiSource">
        <xsl:value-of select="data(tei:TEI/@xml:id)"/>
    </xsl:variable>
    <xsl:variable name="link">
        <xsl:value-of select="replace($teiSource, '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="doc_title">
        <xsl:value-of select=".//tei:title[@type='label'][1]/text()"/>
    </xsl:variable>
    <xsl:variable name="signatur">
        <xsl:value-of select=".//tei:institution/text()"/>, <xsl:value-of select=".//tei:repository[1]/text()"/>, <xsl:value-of select=".//tei:msIdentifier/tei:idno[1]/text()"/>
    </xsl:variable>
    <xsl:template match="/">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <xsl:call-template name="html_head">
                <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
            </xsl:call-template>
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid">                        
                        <div class="card" data-index="true">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-md-2">
                                        <xsl:if test="ends-with($prev,'.html')">
                                            <h1>
                                                <a>
                                                    <xsl:attribute name="href">
                                                        <xsl:value-of select="$prev"/>
                                                    </xsl:attribute>
                                                    <i class="fas fa-chevron-left" title="prev"/>
                                                </a>
                                            </h1>
                                        </xsl:if>
                                    </div>
                                    <div class="col-md-8">
                                        <h2 align="center">
                                            <xsl:for-each select="//tei:fileDesc/tei:titleStmt/tei:title[1]">
                                                <xsl:apply-templates/>
                                                <br/>
                                            </xsl:for-each>
                                            <a>
                                                <i class="fas fa-info" title="show more info about the document" data-toggle="modal" data-target="#exampleModalLong"/>
                                            </a>
                                            |
                                            <a href="{$teiSource}">
                                                <i class="fas fa-download" title="show TEI source"/>
                                            </a>
                                        </h2>
                                        
                                        
                                    </div>
                                    <div class="col-md-2" style="text-align:right">
                                        <xsl:if test="ends-with($next, '.html')">
                                            <h1>
                                                <a>
                                                    <xsl:attribute name="href">
                                                        <xsl:value-of select="$next"/>
                                                    </xsl:attribute>
                                                    <i class="fas fa-chevron-right" title="next"/>
                                                </a>
                                            </h1>
                                        </xsl:if>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body"> 
                                <div class="card-header">
                                    <h3>Regest</h3>
                                </div>
                                <div class="card-body" style="font-style:italic">
                                    <xsl:apply-templates select="//tei:msContents"/>
                                </div>
                                <div class="card-header">
                                    <h3>Anmerkungen zum Dokument</h3>
                                </div>
                                <div class="card-body">
                                    <xsl:apply-templates select="//tei:physDesc"/>
                                    <xsl:apply-templates select="//tei:publicationStmt"/>
                                </div>
                                <div class="card-header">
                                    <h3>Schlagworte</h3>
                                </div>
                                <div class="card-body">
                                    <h4>
                                        <xsl:for-each select=".//tei:term">
                                            
                                            <a>
                                                <xsl:attribute name="href">
                                                    <xsl:value-of select="concat(data(@key), '__kw.html')"/>
                                                </xsl:attribute>
                                                <span class="badge badge-info" style="background-color: #0063a6; margin-left: 1em;">
                                                    <xsl:value-of select="."/>
                                                </span>
                                            </a>
                                            
                                        </xsl:for-each>
                                    </h4>
                                </div>
                                
                                <div class="card-header">
                                    <h3>Edierter Text</h3>
                                </div>
                                <div class="card-body">
                                    <xsl:apply-templates select="//tei:div[@type='transcript']"/>
                                </div>
                                <div class="card-footer">
                                    <p style="text-align:center;">
                                        <xsl:for-each select=".//tei:note[not(./tei:p)]">
                                            <div class="footnotes" id="{local:makeId(.)}">
                                                <xsl:element name="a">
                                                    <xsl:attribute name="name">
                                                        <xsl:text>fn</xsl:text>
                                                        <xsl:number level="any" format="1" count="tei:note"/>
                                                    </xsl:attribute>
                                                    <a>
                                                        <xsl:attribute name="href">
                                                            <xsl:text>#fna_</xsl:text>
                                                            <xsl:number level="any" format="1" count="tei:note"/>
                                                        </xsl:attribute>
                                                        <span style="font-size:7pt;vertical-align:super; margin-right: 0.4em">
                                                            <xsl:number level="any" format="1" count="tei:note"/>
                                                        </span>
                                                    </a>
                                                </xsl:element>
                                                <xsl:apply-templates/>
                                            </div>
                                        </xsl:for-each>
                                    </p>
                                    <p>
                                        <hr/>
                                        <h3>Zitierhinweis</h3>
                                        <blockquote class="blockquote">
                                            <cite title="Source Title">
                                                <xsl:value-of select="$signatur"/>; hrsg von Brigitte Mazohl, Christof Aichner und Tanja Kraler, in: In Die Korrespondenz von Leo von Thun-Hohenstein, https://thun-korrespondenz.acdh.oeaw.ac.at</cite>
                                        </blockquote>
                                    </p>
                                </div>
                            </div>
                        </div>                       
                    </div>
                    <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLongTitle">
                                        <xsl:for-each select="//tei:fileDesc/tei:titleStmt/tei:title[1]">
                                            <xsl:apply-templates/>
                                            <br/>
                                        </xsl:for-each>
                                    </h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">x</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <table class="table table-striped">
                                        <tbody>
                                            <xsl:if test="//tei:msIdentifier">
                                                <tr>
                                                    <th>
                                                        <abbr title="//tei:msIdentifie">Signatur</abbr>
                                                    </th>
                                                    <td>
                                                        <xsl:for-each select="//tei:msIdentifier/child::*">
                                                            <abbr>
                                                                <xsl:attribute name="title">
                                                                    <xsl:value-of select="name()"/>
                                                                </xsl:attribute>
                                                                <xsl:value-of select="."/>
                                                            </abbr>
                                                            <br/>
                                                        </xsl:for-each><!--<xsl:apply-templates select="//tei:msIdentifier"/>-->
                                                    </td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test="//tei:supportDesc/tei:extent">
                                                <tr>
                                                    <th>
                                                        <abbr title="//tei:supportDesc/tei:extent">Extent</abbr>
                                                    </th>
                                                    <td>
                                                        <xsl:apply-templates select="//tei:supportDesc/tei:extent"/>
                                                    </td>
                                                </tr>
                                            </xsl:if>
                                            <tr>
                                                <th>
                                                    <abbr title="//tei:availability//tei:p[1]">License</abbr>
                                                </th>
                                                <td align="center">
                                                    <a class="navlink" target="_blank" href="https://creativecommons.org/licenses/by/4.0/">
                                                        https://creativecommons.org/licenses/by/4.0/
                                                    </a>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <xsl:for-each select=".//tei:back//tei:org[@xml:id]">
                        
                        <div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                            <xsl:attribute name="id">
                                <xsl:value-of select="./@xml:id"/>
                            </xsl:attribute>
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">
                                            <xsl:value-of select=".//tei:orgName[1]/text()"/>
                                        </h5>
                                        
                                    </div>
                                    <div class="modal-body">
                                        <xsl:call-template name="org_detail">
                                            <xsl:with-param name="showNumberOfMentions" select="5"/>
                                        </xsl:call-template>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Schließen</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </xsl:for-each>
                    <xsl:for-each select=".//tei:back//tei:person[@xml:id]">
                        <xsl:variable name="xmlId">
                            <xsl:value-of select="data(./@xml:id)"/>
                        </xsl:variable>

                        <div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" id="{$xmlId}">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">
                                            <xsl:value-of select="normalize-space(string-join(.//tei:persName[1]//text()))"/>
                                            <xsl:text> </xsl:text>
                                            <a href="{concat($xmlId, '.html')}">
                                                <i class="fas fa-external-link-alt"></i>
                                            </a>
                                        </h5>
                                        
                                    </div>
                                    <div class="modal-body">
                                        <xsl:call-template name="person_detail">
                                            <xsl:with-param name="showNumberOfMentions" select="5"/>
                                        </xsl:call-template>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Schließen</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </xsl:for-each>
                    <xsl:for-each select=".//tei:back//tei:place[@xml:id]">
                        <xsl:variable name="xmlId">
                            <xsl:value-of select="data(./@xml:id)"/>
                        </xsl:variable>
                        
                        <div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" id="{$xmlId}">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">
                                            <xsl:value-of select="normalize-space(string-join(.//tei:placeName[1]/text()))"/>
                                            <xsl:text> </xsl:text>
                                            <a href="{concat($xmlId, '.html')}">
                                                <i class="fas fa-external-link-alt"></i>
                                            </a>
                                        </h5>
                                    </div>
                                    <div class="modal-body">
                                        <xsl:call-template name="place_detail">
                                            <xsl:with-param name="showNumberOfMentions" select="5"/>
                                        </xsl:call-template>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Schließen</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </xsl:for-each>
                    <xsl:call-template name="html_footer"/>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="tei:msContents">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:p">
        <p id="{local:makeId(.)}">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="tei:div">
        <div id="{local:makeId(.)}">
            <xsl:if test="./@xml:id">
                <a>
                    <xsl:attribute name="name">
                        <xsl:value-of select="lower-case(./@xml:id)"/>
                    </xsl:attribute>
                </a>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    <xsl:template match="tei:unclear">
        <abbr title="unclear"><xsl:apply-templates/></abbr>
    </xsl:template>
    <xsl:template match="tei:del">
        <del><xsl:apply-templates/></del>
    </xsl:template>
    <xsl:template match="tei:term"/>
    <xsl:template match="tei:note">
        <xsl:element name="a">
            <xsl:attribute name="name">
                <xsl:text>fna_</xsl:text>
                <xsl:number level="any" format="1" count="tei:note"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>#fn</xsl:text>
                <xsl:number level="any" format="1" count="tei:note"/>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:attribute>
            <sup>
                <xsl:number level="any" format="1" count="tei:note"/>
            </sup>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:table">
        <xsl:element name="table">
            <xsl:attribute name="class">
                <xsl:text>table table-bordered table-striped table-condensed table-hover</xsl:text>
            </xsl:attribute>
            <xsl:element name="tbody">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:row">
        <xsl:element name="tr">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:cell">
        <xsl:element name="td">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>