<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/">
        <publisher-upload-manifest publisher-id="Publisher_id" preparer="FTP" report-success="true">
            <notify email="something@something.com"/>
            <notify email="somethingelse@somethingelse.com"/>
            <asset>
                <xsl:attribute name="type" >VIDEO_FULL</xsl:attribute>
                <xsl:attribute name="active" >
                    <xsl:value-of select="//MarquisEDL//ClipList//Clip//CustomMetadata//CustomData[@name='AvidFramerate']" />
                </xsl:attribute>
                <xsl:attribute name="user" >
                    <xsl:value-of select="//MarquisEDL//ClipList//Clip//CustomMetadata//CustomData[@name='UserLogin']" />
                </xsl:attribute>
                
                <Barcode_>
                    <xsl:value-of select="//MarquisEDL//ClipList//Clip//CustomMetadata//CustomData[@name='Barcode']"/>
                </Barcode_>
                
                <comments>
                    <xsl:value-of select="//MarquisEDL//ClipList//Clip//CustomMetadata//CustomData[@name='Comments']"/>
                </comments>
            </asset>
        </publisher-upload-manifest>
    </xsl:template>
    
</xsl:stylesheet>
