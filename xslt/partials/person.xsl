<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" exclude-result-prefixes="xsl tei xs">

    <xsl:template match="tei:person" name="person_detail">
        <xsl:param name="showNumberOfMentions" as="xs:integer" select="50000" />
        <xsl:variable name="selfLink">
            <xsl:value-of select="concat(data(@xml:id), '.html')"/>
        </xsl:variable>
        <div class="card-body">
            <small>Vorname</small>: <xsl:value-of select=".//tei:forename/text()"/>
            <br/>
            <small>Nachname</small>: <xsl:value-of select=".//tei:surname/text()"/>
            <br/>
            <small>Lebensdaten</small>:
            <xsl:if test=".//tei:note/tei:p[1]/text()">
                <xsl:value-of select=".//tei:note/tei:p[1]/text()"/>
            </xsl:if>
            <br/>
            <small>weitere biographische Angaben</small>:
            <xsl:if test=".//tei:note/tei:p[2]/text()">
                <xsl:value-of select=".//tei:note/tei:p[2]/text()"/>
            </xsl:if>
            <br/>
            <small>GND-ID</small>:
            <xsl:if test=".//tei:note/tei:p[3]/text()">
                <a>
                    <xsl:attribute name="href"><xsl:value-of select=".//tei:note/tei:p[3]/text()"/></xsl:attribute>
                    <xsl:value-of select=".//tei:note/tei:p[3]/text()"/>
                </a>
            </xsl:if>
            <br/>
            <hr />
            <div id="mentions">
                <legend>erwähnt in</legend>
                <ul>
                    <xsl:for-each select=".//tei:event">
                        <xsl:variable name="linkToDocument">
                            <xsl:value-of select="replace(tokenize(data(.//@target), '/')[last()], '.xml', '.html')"/>
                        </xsl:variable>
                        <xsl:choose>
                            <xsl:when test="position() lt $showNumberOfMentions + 1">
                                <li>
                                    <xsl:value-of select=".//tei:title"/><xsl:text> </xsl:text>
                                    <a href="{$linkToDocument}">
                                        <i class="fas fa-external-link-alt"></i>
                                    </a>
                                </li>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                </ul>
                <xsl:if test="count(.//tei:event) gt $showNumberOfMentions + 1">
                    <p>Anzahl der Erwähnungen limitiert, klicke <a href="{$selfLink}">hier</a> für eine vollständige Auflistung</p>
                </xsl:if>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>
