<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="tei xsl xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[1]/text()"/>
        </xsl:variable>

        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html xmlns="http://www.w3.org/1999/xhtml">
            <xsl:call-template name="html_head">
                <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
            </xsl:call-template>
            
            <body role="document" class="contained" id="body">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>

                    <div class="container" style="color:black">
                        <h1 style="text-align:center">Die Korrespondenz von Leo von Thun-Hohenstein</h1>
                        <div id="carouselExampleControls" class="carousel slide" data-ride="carousel" style="margin:20px">
                        <div class="carousel-inner">
                                <div class="carousel-item active">
                                        <img class="d-block w-100" src="img/acdh_projects_thunkorrespondenz_01.jpg" alt="First slide" title="CC-BY 4.0, Sandra Lehecka"/>
                                        <div class="carousel-caption d-none d-md-block" style="color:#0063a6;">
                                                <h2>Thun-Statue, Universität Wien</h2>
                                        </div>
                                </div>
                                <div class="carousel-item">
                                        <img class="d-block w-100" src="img/acdh_projects_thunkorrespondenz_03.jpg" alt="Second slide" title="CC-BY 4.0, Sandra Lehecka"/>
                                        <div class="carousel-caption d-none d-md-block">
                                                <div class="carousel-caption d-none d-md-block" style="color:#0063a6;">
                                                        <h2>Thun-Statue, Universität Wien</h2>
                                                </div>
                                        </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <h1 style="text-align:center">
                                            <a class="btn btn-main btn-outline-primary btn-lg" href="about.html" role="button">Über die Edition</a>
                                        </h1>
                                    </div>
                                        <div class="col-md-6">
                                            <h1 style="text-align:center">
                                                <a class="btn btn-main btn-outline-primary btn-lg" href="toc.html" role="button">Alle Dokumente</a>
                                            </h1>
                                        </div>
                                </div>
                        </div>
                        <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"/>
                                <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"/>
                                <span class="sr-only">Next</span>
                        </a>
                </div>
                </div>

                    <xsl:call-template name="html_footer"/>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>