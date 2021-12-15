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
                    <listPlace>
                        <xsl:for-each-group select="//*:tr" group-by="*:td[1]/text()">
                            <xsl:variable name="counter" select="count(preceding::*:tr)"/>
                            <xsl:if test="*:td[1]/text()">
                                <!-- 1 -->
                                <xsl:variable name="position1" select="concat('place.', position())"/>
                                <place xml:id="{$position1}" type="country">
                                    <placeName>
                                        <xsl:value-of select="normalize-space(*:td[1]/text())"/>
                                    </placeName>
                                    <xsl:if test="*:td[3]">
                                        <location>
                                            <geo>
                                                <xsl:value-of select="normalize-space(*:td[3])"/>
                                            </geo>
                                        </location>
                                    </xsl:if>
                                    <xsl:if test="*:td[2]/*:a/@href">
                                        <idno type="uri">
                                            <xsl:value-of select="normalize-space(*:td[2]/*:a/@href)"/>
                                        </idno>
                                    </xsl:if>
                                    <!-- 2 -->
                                    <xsl:for-each-group select="current-group()" group-by="*:td[4]/text()">
                                        <xsl:variable name="position2" select="concat($position1, '.', position())"/>
                                        <place xml:id="{$position2}" type="settlement">
                                            <placeName>
                                                <xsl:value-of select="current-grouping-key()"/>
                                            </placeName>
                                            <xsl:if test="*:td[6]">
                                                <location>
                                                    <geo>
                                                        <xsl:value-of select="normalize-space(*:td[6])"/>
                                                    </geo>
                                                </location>
                                            </xsl:if>
                                            <xsl:if test="*:td[5]/*:a/@href">
                                                <idno type="uri">
                                                    <xsl:value-of select="normalize-space(*:td[5]/*:a/@href)"/>
                                                </idno>
                                            </xsl:if>
                                            <xsl:if test="*:td[7]/text()">
                                                <!-- 3 -->
                                                <xsl:for-each-group select="current-group()" group-by="*:td[7]/text()">
                                                    <xsl:variable name="position3" select="concat($position2, '.', position())"/>
                                                    <place xml:id="{$position3}" type="district">
                                                        <placeName>
                                                            <xsl:value-of select="normalize-space(current-grouping-key())"/>
                                                        </placeName>
                                                        <xsl:if test="*:td[9]">
                                                            <location>
                                                                <geo>
                                                                    <xsl:value-of select="*:td[9]"/>
                                                                </geo>
                                                            </location>
                                                        </xsl:if>
                                                        <xsl:if test="*:td[8]/*:a/@href">
                                                            <idno type="uri">
                                                                <xsl:value-of select="normalize-space(*:td[8]/*:a/@href)"/>
                                                            </idno>
                                                        </xsl:if>
                                                        <!-- 4 -->
                                                        <xsl:for-each-group select="current-group()" group-by="*:td[10]/text()">
                                                            <xsl:variable name="position4" select="concat($position3, '.', position())"/>
                                                            <place xml:id="{$position4}" type="building">
                                                                <placeName>
                                                                    <xsl:value-of select="normalize-space(current-grouping-key())"/>
                                                                </placeName>
                                                                <xsl:if test="*:td[11]/text()">
                                                                    <placeName type="alt">
                                                                        <xsl:value-of select="normalize-space(*:td[11]/text())"/>
                                                                    </placeName>
                                                                </xsl:if>
                                                                <xsl:if test="*:td[12]">
                                                                    <location>
                                                                        <geo>
                                                                            <xsl:value-of select="normalize-space(*:td[12])"/>
                                                                        </geo>
                                                                    </location>
                                                                </xsl:if>
                                                            </place>
                                                        </xsl:for-each-group>
                                                    </place>
                                                </xsl:for-each-group>
                                            </xsl:if>
                                            
                                            <!--  -->
                                            <xsl:if test="not(*:td[7]/text()) and *:td[10]/text()">
                                                <xsl:for-each-group select="current-group()" group-by="*:td[10]/text()">
                                                    <place xml:id="{concat($position2, '.', position())}" type="building">
                                                        <placeName>
                                                            <xsl:value-of select="normalize-space(current-grouping-key())"/>
                                                        </placeName>
                                                        <xsl:if test="*:td[11]/text()">
                                                            <placeName type="alt">
                                                                <xsl:value-of select="normalize-space(*:td[11]/text())"/>
                                                            </placeName>
                                                        </xsl:if>
                                                        <xsl:if test="*:td[12]">
                                                            <location>
                                                                <geo>
                                                                    <xsl:value-of select="normalize-space(*:td[12])"/>
                                                                </geo>
                                                            </location>
                                                        </xsl:if>
                                                    </place>
                                                </xsl:for-each-group>
                                            </xsl:if>
                                        </place>
                                    </xsl:for-each-group>
                                </place>
                            </xsl:if>
                        </xsl:for-each-group>
                    </listPlace>
                </body>
            </text>
        </TEI>
    </xsl:template>

</xsl:stylesheet>
