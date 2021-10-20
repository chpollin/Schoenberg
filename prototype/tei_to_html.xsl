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
                                <div class="col-10">
                                    <xsl:apply-templates select="//*:body"/>
                                </div>
                                <div class="col-2">
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
                        <div class="container">
                            <div class="row my-5">
                                <h2>Anmerkungen</h2>
                                <ol>
                                    <xsl:for-each select="//*:body//*:note[@type='footnote']">
                                        <li>
                                            <xsl:apply-templates/>
                                        </li>
                                    </xsl:for-each>
                                </ol>
                            </div>
                            
                        </div>

                    </main>
                    <!-- footer -->
                    <footer class="pt-5 my-5 text-muted border-top"> Lorem </footer>
                </div>

            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="*:note[@type='footnote']">
        <sup style="background-color: #FFEBCD;">
            <!-- -1 because in teiHeader is a note...needs to be fixed. -->
            <xsl:value-of select="count(preceding::*:note) - 1"/>
        </sup>
    </xsl:template>
    
    <xsl:template match="*:note">
        <span style="background-color: #DEB887;">
            <xsl:text>[</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>]</xsl:text>
        </span>
    </xsl:template>

    <xsl:template match="*:ref[@target]">
        <a href="{@target}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <!-- OPENER -->
    <xsl:template match="*:opener">
        <div class="row my-3">
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
        <div title="closer">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="*:salute">
            <xsl:apply-templates/>
    </xsl:template>
    
   <xsl:template match="*:stamp">
       <div title="stamp" class="lead" style="font-size: 1rem;">
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
            <xsl:if test="*[contains(@rend, 'line')]">
                <xsl:choose>
                    <xsl:when test="*[contains(@rend, 'right')]">
                        <xsl:attribute name="style">
                            <xsl:text>border-right: 1px solid;</xsl:text>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:when test="@rend = 'line left'">
                        <xsl:attribute name="style">
                            <xsl:text>border-left: 1px solid;</xsl:text>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </xsl:if>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="*:hi[contains(@rend, 'underline')]">
        <span>
            <xsl:choose>
                <xsl:when test="contains(@rend, 'double')">
                    <xsl:attribute name="style" select="' text-decoration-line: underline; text-decoration-style: double;'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="style" select="' text-decoration-line: underline;'"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="*:hi[@rend = 'underline dotted']">
        <span style="text-decoration:underline; text-decoration-style: dotted;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="*:hi[@rend = 'superscript']">
        <sup>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>
    
    <xsl:template match="*:hi[@rend = 'center']">
        <div class="text-center">
            <xsl:apply-templates/>
        </div>
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
    
    <xsl:template match="*:hi[@rend = 'preprint']">
        <span style="font-family: 'Lucida Console';">
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
            <xsl:choose>
                <xsl:when test="@rend = 'simple'">
                    <xsl:attribute name="class">
                        <xsl:text>list-unstyled m-3</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
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
    
    <xsl:template match="*:g[@ref='#typoHyphen']">
        <span style="background-color: lightblue;"><xsl:text>-</xsl:text></span>
    </xsl:template>
    
    <xsl:template match="*:term">
        <span style="background-color: green;">
            <xsl:if test="@type">
                <xsl:attribute name="title" select="@type"/>
            </xsl:if>
            <xsl:apply-templates/>
        </span>
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
        <span style="background-color: #FAEBD7;">
            <xsl:attribute name="title">
                <xsl:value-of select="@key"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="*:notatedMusic">
        <div class="container m-3">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="*:seg">
        <div>
            <xsl:choose>
                <xsl:when test="@type = 'row'">
                    <xsl:attribute name="class" select="'row'"/>
                </xsl:when>
                <xsl:when test="@type = 'column'">
                    <xsl:attribute name="class" select="'col'"/>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            <p>
                <xsl:apply-templates/>
            </p>
        </div>
    </xsl:template>
    
    <xsl:template match="*:figure">
        <img  class="mx-auto d-block" src="{concat('../data/sample_letter/', *:graphic/@url)}" width="50%"/>
    </xsl:template>
    
 

</xsl:stylesheet>
