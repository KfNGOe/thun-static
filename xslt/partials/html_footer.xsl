<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xsl xs"
    version="2.0">

    <xsl:template match="/" name="html_footer">
        <footer class="main-footer">
            <div class="container">
                <div class="footer-wrapper">
                    <div class="footer-sep">
                        <i class="far fa-comment"/> Kontakt: <a href="mailto:christof.aichner@uibk.ac.at">Christof Aichner</a>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <a href="https://www.oeaw.ac.at/acdh/" target="_blank" rel="noopener" aria-label="ACDHCH">
                                <img src="https://shared.acdh.oeaw.ac.at/acdh-common-assets/images/acdh-ch-logo-grayscale.svg" alt="ACDH" title="Austrian Centre for Digital Humanities and Cultural Heritage"/>
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="https://pf.fwf.ac.at/de/wissenschaft-konkret/project-finder?search[what]=P+22554" target="_blank" rel="noopener" aria-label="FWF P 29329">
                                <img src="img/fwf.gif" alt="FWF" title="FWF funded Project P 22554"/>
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="http://www.oesterreichische-geschichte.at/" target="_blank" rel="noopener" aria-label="Kommission für Neuere Geschichte Österreichs">
                                <img src="img/logo_kommission.png" alt="Kommission für Neuere Geschichte Österreichs" title="Kommission für Neuere Geschichte Österreichs" style="max-width:30%;"/>
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="https://www.uibk.ac.at/" target="_blank" rel="noopener" aria-label="UIBK">
                                <img src="img/uibklogo.png" alt="UIBK" title="University of Innsbruck"/>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer-imprint-bar">
                <a href="imprint.html">Impressum/Imprint</a>
                <div class="row" style="padding-top: 20px;">
                    <div class="col-sm">
                        <a href="https://github.com/KfNGOe/thun-static">
                            <i class="fab fa-github-square fa-2x"/>
                        </a>
                    </div>
                </div>
            </div>
        </footer>
        <script type="text/javascript" src="dist/fundament/vendor/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="dist/fundament/js/fundament.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/v/bs4/jszip-2.5.0/dt-1.11.0/b-2.0.0/b-html5-2.0.0/cr-1.5.4/r-2.2.9/sp-1.4.0/datatables.min.js"></script>
        <script type="text/javascript" src="js/dt.js"></script>
    </xsl:template>
</xsl:stylesheet>