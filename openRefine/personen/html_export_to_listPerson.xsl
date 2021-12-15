<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="/">
        <xsl:variable name="ROWS" select="//*:tr"/>

        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title/>
                    </titleStmt>
                    <publicationStmt>
                        <p/>
                    </publicationStmt>
                    <sourceDesc>
                        <p/>
                    </sourceDesc>
                </fileDesc>
            </teiHeader>
            <text>
                <body>
                    <listPerson>
                        <xsl:for-each select="//*:tr">
                            <xsl:variable name="counter" select="count(preceding::*:tr)"/>
                            <xsl:if test="*:td[1]/text()">
                                <person xml:id="{concat('p_', position())}">
                                    <xsl:if test="*:td[5]/text()">
                                        <idno type="uri">
                                            <xsl:value-of
                                                select="concat('http://d-nb.info/gnd/', normalize-space(*:td[5]/text()))"
                                            />
                                        </idno>
                                    </xsl:if>
                                    <persName>
                                        <!--<name>
                                            <xsl:value-of select="*:td[2]/text()"/>
                                        </name>-->
                                        <xsl:if test="*:td[2]/text()">
                                            <surname>
                                                <xsl:value-of select="normalize-space(*:td[2]/text())"/>
                                            </surname>
                                        </xsl:if>
                                        <xsl:if test="*:td[3]/text()">
                                            <forename>
                                                <xsl:value-of select="normalize-space(*:td[3]/text())"/>
                                            </forename>
                                        </xsl:if>
                                    </persName>
                                    <xsl:if test="(*:td[6]/text() and *:td[6]/text() castable as xs:date) or *:td[8]/text()">
                                        <birth>
                                            <xsl:if
                                                test="*:td[6]/text() and *:td[6]/text() castable as xs:date">
                                                <date when="{*:td[6]/text()}"/>
                                            </xsl:if>
                                            <xsl:if test="*:td[8]/text()">
                                                <placeName>
                                                    <xsl:value-of select="normalize-space(*:td[8]/text())"/>
                                                </placeName>
                                            </xsl:if>
                                        </birth>
                                    </xsl:if>
                                    <xsl:if test="*:td[7]/text() or *:td[9]/text()">
                                        <death>
                                            <xsl:if
                                                test="*:td[7]/text() and *:td[7]/text() castable as xs:date">
                                                <date when="{*:td[7]/text()}"/>
                                            </xsl:if>
                                            <xsl:if test="*:td[9]/text()">
                                                <placeName>
                                                    <xsl:value-of select="normalize-space(*:td[9]/text())"/>
                                                </placeName>
                                            </xsl:if>
                                        </death>
                                    </xsl:if>
                                    <!-- occupations -->
                                    <xsl:if test="*:td[10]/text()">
                                        <occupation>
                                            <term>
                                                <xsl:if test="*:td[11]/*:a/@href">
                                                    <xsl:attribute name="ref" select="normalize-space(*:td[11]/*:a/@href)"/>
                                                </xsl:if>
                                                <!--<xsl:if test="*:td[11]/text()">
                                                  <xsl:attribute name="ref">
                                                      <xsl:choose>
                                                          <xsl:when test="*:td[11]/*:a/@href">
                                                              <xsl:value-of select="normalize-space(*:td[11]/*:a/@href)"/>
                                                          </xsl:when>
                                                          <xsl:otherwise>
                                                              <xsl:value-of select="normalize-space(*:td[11]/text())"/>
                                                          </xsl:otherwise>
                                                      </xsl:choose>
                                                  </xsl:attribute>
                                                </xsl:if>-->
                                                <xsl:value-of select="normalize-space(*:td[10]/text())"/>
                                            </term>
                                        </occupation>
                                    </xsl:if>
                                    <!-- affiliation -->
                                    <xsl:if test="*:td[13]/text()">
                                        <affiliation>
                                            <xsl:value-of select="normalize-space(*:td[13]/text())"/>
                                        </affiliation>
                                    </xsl:if>
                                    <!-- note -->
                                    <!--<xsl:if test="*:td[15]/text() or *:td[15]/*:a">
                                        <figure facs="{*:td[15]}"/>
                                    </xsl:if>-->
                                    <xsl:if test="*:td[16]/text()">
                                        <note>
                                            <xsl:value-of select="normalize-space(*:td[16]/text())"/>
                                        </note>
                                    </xsl:if>
                                    
                                    <!-- //*:tr[3]//following-sibling::tr[not(td[1]/text())][td[10]/text()] -->
                                    <xsl:variable name="next"
                                        select=".//following-sibling::*:tr[*:td[1]/text()][1]/count(preceding::*:tr)"/>
                                    <xsl:for-each select="($counter + 2) to ($next - 1)">
                                        <xsl:variable name="inner_counter" select="number(.)"/>
                                        <xsl:variable name="current" select="$ROWS[$inner_counter]"/>
                                        <xsl:if test="$current/*:td[10]/text()">
                                            <occupation>
                                                <term>
                                                    <xsl:if test="$current/*:td[11]/*:a/@href">
                                                        <xsl:attribute name="ref" select="$current/*:td[11]/*:a/@href"></xsl:attribute>
                                                    </xsl:if>
                                                    <xsl:value-of select="normalize-space($current/*:td[10]/text())"/></term>
                                            </occupation>
                                        </xsl:if>
                                        
                                        <xsl:if test="$current/*:td[13]/text()">
                                            <affiliation>
                                                <xsl:value-of select="$current/*:td[13]/text()"/>
                                            </affiliation>
                                        </xsl:if>
                                    </xsl:for-each>

                                </person>
                            </xsl:if>
                        </xsl:for-each>
                    </listPerson>
                </body>
            </text>
        </TEI>
    </xsl:template>

</xsl:stylesheet>
