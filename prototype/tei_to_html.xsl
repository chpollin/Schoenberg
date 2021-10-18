<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta charset="utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>

                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css"
                    rel="stylesheet"
                    integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU"
                    crossorigin="anonymous"/>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"/>

            </head>

            <!-- body -->
            <body>

                <div class="col-lg-8 mx-auto p-3 py-md-5">
                    <header class="d-flex align-items-center pb-3 mb-5 border-bottom">
                        <nav class="nav">
                            <div>Schönberg Prototyp</div>
                        </nav>
                    </header>
                    <!-- main -->
                    <main>
                        <div class="container">
                            <div class="row">
                                <p>
                                    msDesc: <xsl:value-of select="//*:teiHeader/*:sourceDesc/*:msDesc"/>
                                </p>
                                <p>
                                    correspDesc: <xsl:value-of select="//*:teiHeader/*:profileDesc/*:correspDesc"/>
                                </p>
                            </div>
                            <div class="row">
                                <div class="col-8">
                                    <xsl:apply-templates select="//*:body"/>
                                </div>
                                <div class="col-4">
                                    <!-- just one img -->
                                    <xsl:for-each select="//*:facsimile/*:surface[1]">
                                        <div class="row mt-5">
                                            <figure class="figure">
                                                <!-- folder name -->
                                                <img src="{concat('../data/sample_letter/1913_07_08_6852/', *:graphic/@url)}" class="figure-img img-fluid" alt="{@start}"/>
                                                <figcaption class="figure-caption">
                                                    <xsl:value-of select="*:graphic/@url"/>
                                                    <xsl:text>, </xsl:text>
                                                    <xsl:value-of select="@start"/>
                                                </figcaption>
                                            </figure>
                                        </div>
                                    </xsl:for-each>
                                </div>
                            </div>
                        </div>

                    </main>
                    <!-- footer -->
                    <footer class="pt-5 my-5 text-muted border-top"> Lorem </footer>
                </div>

            </body>
        </html>
    </xsl:template>

    <!-- OPENER -->
    <xsl:template match="*:opener">
        <div class="row">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="*:address">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="*:addrLine">
        <div class="row">
            <span>
                <xsl:apply-templates/>
            </span>
        </div>
    </xsl:template>
    
    <xsl:template match="*:closer">
        <div class="row">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="*:salute">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
   <xsl:template match="*:stamp">
    <div title="stamp" class="lead">
        <p>
            <xsl:apply-templates/>
        </p>
    </div>
    </xsl:template>
    
    <xsl:template match="*[@rend = 'right', 'left']">
        <span>
         <xsl:choose>
             <xsl:when test="@rend = 'right'">
                 <xsl:attribute name="class">
                     <xsl:text>text-end</xsl:text>
                 </xsl:attribute>
             </xsl:when>
             <xsl:when test="@rend = 'left'">
                 <xsl:attribute name="class">
                     <xsl:text>text-begin</xsl:text>
                 </xsl:attribute>
             </xsl:when>
         </xsl:choose>
        <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="*:lb">
        <br/>
    </xsl:template>
    
    <xsl:template match="*:pb">
        <hr class="mt-5">
            <xsl:if test="@xml:id">
                <xsl:attribute name="id">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
            </xsl:if>
        </hr>
       
    </xsl:template>

    <xsl:template match="*:p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="*:hi[@rend = 'underline']">
        <span class="text-decoration-underline">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="*:hi[@rend = 'rectangle']">
        <span class="border">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="*:del[@rend = 'strikethrough']">
        <span class="text-decoration-line-through">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="*:add">
        <mark>
            <xsl:if test="@place">
                <xsl:attribute name="title">
                    <xsl:value-of select="concat(@place, ':', .)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </mark>
    </xsl:template>

    <xsl:template match="*:list">
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>

    <xsl:template match="*:list/*:item">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    
    <xsl:template match="*:choice">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="*:choice/*:abbr">
        <span style="background-color: coral;">
            <xsl:if test="../*:expan">
                <xsl:attribute name="title">
                    <xsl:choose>
                        <xsl:when test="../*:expan/*:reg">
                            <xsl:text>[</xsl:text>
                            <xsl:value-of select="../*:expan/*:reg"/>
                            <xsl:text>]</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="../*:expan"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="*:choice/*:expan"/>
    
    <xsl:template match="*:supplied">
        <span title="{@cert}">
            <xsl:text>[ </xsl:text>
                <xsl:apply-templates/>
            <xsl:text>] </xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="*:gap">
        <span class="{concat('p-', @quantity)}">
            <xsl:choose>
                <xsl:when test="@rend|@reason">
                    <xsl:attribute name="title">
                        <xsl:value-of select="@rend|@reason"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </span>
    </xsl:template>
    
    <!-- NAMES -->
    <xsl:template match="*:persName | *:orgName | *:placeName">
        <a href="#">
            <xsl:attribute name="title">
                <xsl:value-of select="@key"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>

</xsl:stylesheet>
