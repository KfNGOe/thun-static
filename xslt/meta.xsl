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
    <xsl:import href="./partials/shared.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@type='main'][1]/text()"/>
        </xsl:variable>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <xsl:call-template name="html_head">
                <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
            </xsl:call-template>
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container">
                        <div class="card">
                            <div class="card-header">
                                
                                
                                <div class="col-md-12" align="center">
                                    <h1>
                                        <xsl:value-of select="//tei:title"/>
                                    </h1>
                                    <a href="">
                                        <i class="fas fa-download" title="show TEI source"/>
                                    </a>
                                    <h5>
                                        <i>
                                            <xsl:value-of select="normalize-space(string-join(//tei:author//text(), ' '))"/>
                                        </i>
                                    </h5>
                                </div>
                                
                                
                            </div>
                            <div class="card-body">
                                <div class="card">
                                    
                                    <div class="card-body">
                                        <xsl:for-each select="//tei:head">
                                            <li>
                                                <xsl:value-of select="./text()"/>
                                            </li>
                                        </xsl:for-each>
                                    </div>
                                </div>
                                <xsl:apply-templates select="//tei:body"/>
                            </div>
                            
                            <div class="card-footer">
                                <p style="text-align:center;">
                                    <xsl:for-each select=".//tei:note">
                                        <div class="footnotes">
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
                                            <xsl:value-of select=".//text()"/>
                                        </div>
                                    </xsl:for-each>
                                </p>
                                <p>
                                    <hr/>
                                    <h3>Zitierhinweis</h3>
                                    <blockquote class="blockquote">
                                        <cite title="Source Title">
                                            <xsl:value-of select="'Christof Aichner, Die Korrespondenz von Leo von Thun-Hohenstein, https://thun-korrespondenz.acdh.oeaw.ac.at/about.html'"/>
                                        </cite>
                                    </blockquote>
                                </p>
                            </div>
                        </div>
                    </div>
                    <xsl:call-template name="html_footer"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:p">
        <p id="{generate-id()}"><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="tei:div">
        <div id="{generate-id()}"><xsl:apply-templates/></div>
    </xsl:template>
    <xsl:template match="tei:ptr">
        <a>
            <xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute>
            <xsl:attribute name="target">_blank</xsl:attribute>
            <i class="fas fa-external-link-alt"></i>
        </a>
    </xsl:template>
</xsl:stylesheet>