<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs"
    xmlns:xmind="urn:xmind:xmap:xmlns:content:2.0"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    version="2.0">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" omit-xml-declaration="no" indent="yes"
        doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    />


    <!-- Named Templates -->
    <xsl:template name="double_blank">
        <xsl:text>
        </xsl:text>
    </xsl:template>
    
    <xsl:template name="output">
        <xsl:choose>
            <xsl:when test="@xlink:href">
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="@xlink:href"/>
                    </xsl:attribute>
                    <xsl:value-of select="xmind:title"/>    
                </a>               
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="xmind:title"/>
            </xsl:otherwise>
        </xsl:choose>
        

        <xsl:if test="@xlink:href">
            
            
        </xsl:if>
    </xsl:template>



    <!-- Templates -->

    <!-- Surpress unnecessarry strings -->
    <xsl:template match="xmind:title" xmlns:ns1="urn:xmind:xmap:xmlns:content:2.0"></xsl:template>
    
    <xsl:template match="xmind:xmap-content" xmlns:ns1="urn:xmind:xmap:xmlns:content:2.0">
        <html>
            <head>
                <title>
                    <xsl:value-of select="xmind:sheet/xmind:topic/xmind:title"/>
                </title>
            </head>

            <body>
                <xsl:for-each select="xmind:sheet">
                <h1>
                    <xsl:value-of select="xmind:topic/xmind:title"/>
                </h1>
                <!--                    <xsl:apply-templates select="$map_h2"/> -->
                <xsl:apply-templates/>
                </xsl:for-each>

                <xsl:call-template name="double_blank"/>
            </body>
        </html>
    </xsl:template>


    <!-- h2 -->
        <xsl:template match="//xmind:topics[count(ancestor-or-self::xmind:topics)=1]" xmlns:ns1="urn:xmind:xmap:xmlns:content:2.0">
<!--    <xsl:template match="//xmind:topics" xmlns:ns1="urn:xmind:xmap:xmlns:content:2.0">-->
        <xsl:for-each select="xmind:topic">
            <xsl:call-template name="double_blank"/>
            <xsl:call-template name="double_blank"/>
            <h2>
                <xsl:call-template name="output"></xsl:call-template>
            </h2>
            <xsl:apply-templates/>
        </xsl:for-each>
    </xsl:template>

    <!-- h3 -->
    <xsl:template match="//xmind:topics[count(ancestor-or-self::xmind:topics)=2]" xmlns:ns1="urn:xmind:xmap:xmlns:content:2.0">
        <xsl:for-each select="xmind:topic">
<!--            <xsl:call-template name="double_blank"/>-->
            <h3>
                <xsl:call-template name="output"></xsl:call-template>
            </h3>
            <xsl:apply-templates/>
        </xsl:for-each>
    </xsl:template>

    <!-- h4 -->
    <xsl:template match="//xmind:topics[count(ancestor-or-self::xmind:topics)=3]" xmlns:ns1="urn:xmind:xmap:xmlns:content:2.0">
        <xsl:for-each select="xmind:topic">
<!--            <xsl:call-template name="double_blank"/>-->
            <h4>
                <xsl:call-template name="output"></xsl:call-template>
            </h4>
            <xsl:apply-templates/>
        </xsl:for-each>
    </xsl:template>

    <!-- h5 -->
    <xsl:template match="//xmind:topics[count(ancestor-or-self::xmind:topics)=4]" xmlns:ns1="urn:xmind:xmap:xmlns:content:2.0">
        <xsl:for-each select="xmind:topic">
<!--            <xsl:call-template name="double_blank"/>-->
            <h5>
                <xsl:call-template name="output"></xsl:call-template>
            </h5>
            <xsl:apply-templates/>
        </xsl:for-each>
    </xsl:template>

    <!-- h6 -->
    <xsl:template match="//xmind:topics[count(ancestor-or-self::xmind:topics)=5]" xmlns:ns1="urn:xmind:xmap:xmlns:content:2.0">
        <xsl:for-each select="xmind:topic">
<!--            <xsl:call-template name="double_blank"/>-->
            <h6>
                <xsl:call-template name="output"></xsl:call-template>
            </h6>
            <xsl:apply-templates/>
        </xsl:for-each>
    </xsl:template>

    <!-- list: ul -->
    <xsl:template match="//xmind:topics[count(ancestor-or-self::xmind:topics)&gt;=6]" xmlns:ns1="urn:xmind:xmap:xmlns:content:2.0">
        <ul>
            <xsl:for-each select="xmind:topic">
                <!--            <xsl:call-template name="double_blank"/>-->
                <li>
                    <xsl:call-template name="output"></xsl:call-template>
                    <xsl:apply-templates/>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>


    <!-- tmp -->
<!--    <xsl:template match="//xmind:topics" xmlns:ns1="urn:xmind:xmap:xmlns:content:2.0">
        <xsl:call-template name="double_blank"/> count(ancestor-or-self::xmind:topics) = <xsl:value-of
            select="count(ancestor-or-self::xmind:topics)"/>
        <xsl:call-template name="double_blank"/>
        <xsl:for-each select="xmind:topic">
            <h2>
                <xsl:call-template name="output"></xsl:call-template>
            </h2> <xsl:apply-templates/> </xsl:for-each>
    </xsl:template>-->


</xsl:stylesheet>
