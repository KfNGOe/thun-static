<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs tei" version="2.0">
    <xsl:output omit-xml-declaration="yes"></xsl:output>
    <xsl:output indent="no"></xsl:output>
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <!--<xsl:template match="tei:date[@when]">
        <date>
            <xsl:choose>
                <xsl:when test="@when castable as xs:date">
                    <xsl:attribute name="when-iso">
                        <xsl:value-of select="@when"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="node()"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="@* | node()"/>
                </xsl:otherwise>
            </xsl:choose>
        </date>
    </xsl:template>-->
    <xsl:template match="tei:back"></xsl:template>
    
    <xsl:template match="tei:titleStmt">
        <xsl:variable name="no_tags">
            <title type="label"><xsl:apply-templates mode="new_title"></xsl:apply-templates></title>
        </xsl:variable>
        <titleStmt>
            <xsl:apply-templates select="@* | node()"/>
            <title type="label"><xsl:value-of select="replace(normalize-space($no_tags), ' , ', ', ')"/></title>
            <title type="s">Digitale Edition der Korrespondenz von Leo von Thun-Hohenstein</title>
        </titleStmt>
    </xsl:template>
    <xsl:template match="tei:titleStmt//tei:rs[@type='place']" mode="new_title"><xsl:value-of select="concat(', ', ./text())"/></xsl:template>
    <xsl:template match="tei:titleStmt//tei:rs[@type='person']" mode="new_title"><xsl:value-of select="./text()"/></xsl:template>
    <xsl:template match="tei:note" mode="new_title"></xsl:template>
    <xsl:template match="tei:lb" mode="new_title"><xsl:value-of select="' '"/></xsl:template>
    <xsl:template match="tei:title[@type='label']"/>
    <xsl:template match="tei:title[@type='s']"/>
</xsl:stylesheet>

