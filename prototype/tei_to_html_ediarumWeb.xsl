<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="/">
        <div class="container">
            <xsl:apply-templates select="//*:body"/>
        </div>
    </xsl:template>
        
    <xsl:template match="*:note">
        <p style="background-color: #DEB887;">
            <xsl:if test="@place">
                <xsl:attribute name="class">
                    <xsl:choose>
                        <xsl:when test="@place= 'right'">
                            <xsl:attribute name="class">
                                <xsl:text>text-end</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="@place= 'left'">
                            <xsl:attribute name="class">
                                <xsl:text>text-begin</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="*:ref[@target]">
        <a href="{@target}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <!-- OPENER -->
    <xsl:template match="*:opener">
        <div class="my-3" title="opener">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="*:address">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="*:addrLine">
        <div title="addrLine">
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
        <div class="salute">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="*:signed">
        <div class="signed">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
   <xsl:template match="*:stamp">
       <p title="stamp" class="lead" style="font-size: 1rem;">
           <xsl:if test="@rendition = '#c'">
               <xsl:attribute name="class" select="'lead text-center'"></xsl:attribute>
           </xsl:if>
       </p>
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="*[@rendition = '#r', '#l', '#c']">
        <p>
         <xsl:choose>
             <xsl:when test="@rendition = '#r'">
                 <xsl:attribute name="class">
                     <xsl:text>text-end</xsl:text>
                 </xsl:attribute>
             </xsl:when>
             <xsl:when test="@rendition = '#l'">
                 <xsl:attribute name="class">
                     <xsl:text>text-begin</xsl:text>
                 </xsl:attribute>
             </xsl:when>
             <xsl:when test="@rendition = '#c'">
                 <xsl:attribute name="class">
                     <xsl:text>text-center</xsl:text>
                 </xsl:attribute>
             </xsl:when>
         </xsl:choose>
        <xsl:apply-templates/>
        </p>
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
    
    <xsl:template match="*:dateline">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="*:p">
        <p>
            <xsl:if test="contains(@rendition, '#l')">
                <xsl:choose>
                    <xsl:when test="contains(@rend, '#llr')">
                        <xsl:attribute name="style">
                            <xsl:text>border-right-style:double;border-right-style:double;</xsl:text>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:when test="contains(@rend, '#lll')">
                        <xsl:attribute name="style">
                            <xsl:text>border-left-style:double;border-left-style:double;</xsl:text>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:when test="contains(@rendition, '#lr')">
                        <xsl:attribute name="style">
                            <xsl:text>border-right: 1px solid;</xsl:text>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:when test="contains(@rendition,'#ll')">
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

    <xsl:template match="*:hi[contains(@rendition, '#u')]">
        <span>
            <xsl:attribute name="style" select="' text-decoration-line: underline;'"/>
           
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="*:hi[@rendition = '#ud']">
        <span style="text-decoration:underline; text-decoration-style: dotted;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="*:hi[@rendition = '#sup']">
        <sup>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>
    
    <xsl:template match="*:hi[@rendition = '#c']">
        <div class="text-center">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="*:hi[@rendition = '#rectangle']">
        <span class="border">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="*:del[@rendition = 'strikethrough']">
        <span class="text-decoration-line-through">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="*:hi[@rendition = 'preprint']">
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
                <xsl:when test="@type = 'simple'">
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
            <xsl:text>[...]</xsl:text>
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
    
    <xsl:template match="*:seg[@type='comment']/*:note">
        <sup style="background-color: #FFEBCD;">
            <!-- -1 because in teiHeader is a note...needs to be fixed. -->
            <xsl:value-of select="count(preceding::*:note) - 1"/>
        </sup>
    </xsl:template>
    
    <xsl:template match="*:seg[@type = 'salute']">
        <span>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="*:seg[@type = 'row']|*:seg[@type = ''column']">
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
