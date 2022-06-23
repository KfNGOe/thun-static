<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output media-type="text" encoding="UTF-8" omit-xml-declaration="yes"/>
    <xsl:template match="/">#FORMAT: BEACON<xsl:text>&#xa;</xsl:text>#NAME: Thun Korrespondenz<xsl:for-each select=".//tei:person[.//tei:p[3]/text()]"><xsl:text>&#xa;</xsl:text><xsl:value-of select=".//tei:p[3]/text()"/>|<xsl:value-of select=".//tei:surname/text()"/><xsl:if test=".//tei:forename/text()">,<xsl:text> </xsl:text><xsl:value-of select=".//tei:forename/text()"/></xsl:if>|https://kfngoe.github.io/thun-static/<xsl:value-of select="data(@xml:id)"/>.html</xsl:for-each>
    </xsl:template>
</xsl:stylesheet>