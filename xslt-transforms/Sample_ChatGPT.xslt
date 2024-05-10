<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="timecode.xsl"/>
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
    
    <!-- Identity template to copy all nodes and attributes -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Template to match the root MarquisEDL element -->
    <xsl:template match="MarquisEDL">
        <xsl:variable name="outputFileName" select="concat('output_', normalize-space(Sequence/Title), '.xml')" />
        <locators framerate="{FrameRate}" name="{Sequence/UID}">
            <xsl:apply-templates select="Sequence/Markers/Marker"/>
        </locators>
        <!-- Output the result to the specified file name -->
        <xsl:result-document href="{$outputFileName}">
            <xsl:apply-templates/>
        </xsl:result-document>
    </xsl:template>
    
    <!-- Template to match Marker elements -->
    <xsl:template match="Marker">
        <locator>
            <timecode><xsl:value-of select="Position"/></timecode>
            <frame><xsl:call-template name="timeToFrames"><xsl:with-param name="time" select="Position"/></xsl:call-template></frame>
            <user><xsl:value-of select="Name"/></user>
            <color><xsl:value-of select="Colour"/></color>
            <track>V1</track>
            <comment><xsl:value-of select="Comment"/></comment>
        </locator>
    </xsl:template>
    
    <!-- Template to convert timecode to frames -->
    <xsl:template name="timeToFrames">
        <xsl:param name="time"/>
        <xsl:variable name="hours" select="number(substring-before($time, ':')) * 3600"/>
        <xsl:variable name="minutes" select="number(substring-before(substring-after($time, ':'), ':')) * 60"/>
        <xsl:variable name="seconds" select="number(substring-before(substring-after(substring-after($time, ':'), ':'), ':'))"/>
        <xsl:variable name="frames" select="number(substring-after(substring-after(substring-after($time, ':'), ':'), ':'))"/>
        <!-- Adjust for starting timecode -->
        <xsl:value-of select="round((($hours + $minutes + $seconds) * 25) + ($frames)) - (((9 * 3600) + (59 * 60) + 30) * 25) + 1"/>
    </xsl:template>
    
</xsl:stylesheet>
