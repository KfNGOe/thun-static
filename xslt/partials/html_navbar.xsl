<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xsl tei xs" version="2.0">
    <xsl:template match="/" name="nav_bar">
        <header>
            <nav class="navbar navbar-expand-md navbar-light  bg-white box-shadow">
                <a class="navbar-brand" href="index.html">
                    thun
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"/>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Info
                            </a>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="about.html">Über die Webseite</a>
                                <a class="dropdown-item" href="how-to-use.html">Benützungshinweise</a>
                            </div>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Bestände
                            </a>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="toc-nachlass.html">Nachlass Leo Thun</a>
                                <a class="dropdown-item" href="toc-autographen.html">Autographen Leo Thun / Briefe aus anderen Archiven</a>
                                <a class="dropdown-item" href="toc.html">Gesamter Bestand</a>
                                <div class="dropdown-divider"/>
                                <a class="dropdown-item" href="calendar.html">Kalender Ansicht</a>
<!--                                <a class="dropdown-item" href="timeline.html">Timeline</a>-->
                            </div>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Register
                            </a>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="listperson.html">Personen</a>
                                <a class="dropdown-item" href="listplace.html">Orte</a>
                                <a class="dropdown-item" href="listorg.html">Institutionen</a>
                                 <a class="dropdown-item" href="schlagworte.html">Schlagworte</a>
                                <div class="dropdown-divider"/>
                                <a class="dropdown-item" href="beacon.txt">GND-BEACON</a>
                                <a class="dropdown-item" href="cmfi.xml">CMIF</a>
                            </div>
                        </li>
                    </ul>
                    <form method="get" action="search.html" class="form-inline my-2 my-lg-0">
                        <input name="q" class="form-control mr-sm-2" type="text" placeholder="Suche in allen Dokumenten" aria-label="Suchen"/>
                        <button class="btn btn-main btn-outline-primary btn-mg" type="submit">Suchen</button>
                    </form>
                </div>
            </nav>
        </header>
    </xsl:template>
</xsl:stylesheet>