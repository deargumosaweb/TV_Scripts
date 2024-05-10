<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns="http://www.redbeemedia.com/nucleus/metadata/ns/v1/standard_metadata" 
                xmlns:cn="http://www.redbeemedia.com/nucleus/metadata/ns/v1/content" 
                xmlns:au="http://www.redbeemedia.com/nucleus/metadata/ns/v1/audio_layout" 
                xmlns:sg="http://www.redbeemedia.com/nucleus/metadata/ns/v1/segmentation" 
                xmlns:mk="http://www.redbeemedia.com/nucleus/metadata/ns/v1/markers" 
                xmlns:id="http://www.redbeemedia.com/nucleus/metadata/ns/v1/identification" 
                xmlns:ed="http://www.redbeemedia.com/nucleus/metadata/ns/v1/editorial" 
                xmlns:tn="http://www.redbeemedia.com/nucleus/metadata/ns/v1/technical" 
                xmlns:an="http://www.redbeemedia.com/nucleus/metadata/ns/v1/ancillary" 
                xmlns:qc="http://www.redbeemedia.com/nucleus/metadata/ns/v1/qc" 
                version="1.0">
    <xsl:import href="timecode.xsl"/>
    
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
    
    <!-- Identity template to copy all nodes and attributes -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:comment>Generated from Nucleus Outernet Medway Transform v0.1</xsl:comment>
        <Nucleus xmlns="http://www.redbeemedia.com/nucleus/metadata/ns/v1/standard_metadata" 
                 xmlns:an="http://www.redbeemedia.com/nucleus/metadata/ns/v1/ancillary" 
                 xmlns:cn="http://www.redbeemedia.com/nucleus/metadata/ns/v1/content" 
                 xmlns:id="http://www.redbeemedia.com/nucleus/metadata/ns/v1/identification" 
                 xmlns:tn="http://www.redbeemedia.com/nucleus/metadata/ns/v1/technical"
                 xmlns:ed="http://www.redbeemedia.com/nucleus/metadata/ns/v1/editorial">
            <id:Identifiers>
                <id:Material_ID>
                    <xsl:call-template name="replaceUnderscores">
                        <xsl:with-param name="input" select="'(/MarquisEDL/ClipList/Clip/Material_ID)'"/>
                    </xsl:call-template>
                </id:Material_ID>
                <!-- <id:Alternate_ID></id:Alternate_ID> -->
            </id:Identifiers>
            <an:Ancillary>
                <an:File>
                    <an:File_Name><xsl:value-of select="/MarquisEDL/ClipList/Clip/File"/>.xml</an:File_Name>
                    <an:File_Type>Metadata</an:File_Type>
                    <an:File_Description>EDL</an:File_Description>
                </an:File>
            </an:Ancillary>
            <cn:Content>
                <cn:Content_Type><xsl:value-of select="/MarquisEDL/ClipList/Clip/Content_Type"/></cn:Content_Type>
                <cn:Supplier>AVID publish to Nucleus</cn:Supplier>
                <!-- <cn:Content_Sub_Type></cn:Content_Sub_Type> -->
                <!-- <cn:Description></cn:Description> -->
                <xsl:if test="/MarquisEDL/ClipList/Clip/CustomMetadata/CustomData[@name='Description'] != ''">
                    <cn:Description>
                        <xsl:value-of select="/MarquisEDL/ClipList/Clip/CustomMetadata/CustomData[@name='Description']"/>
                    </cn:Description>
                </xsl:if>
                <!-- <cn:Supplier>Channel_5</cn:Supplier> -->
                <!-- <cn:Channel></cn:Channel> -->
            </cn:Content>
            <tn:Technical>
                <!-- <tn:Media_File_Name>
                     <xsl:value-of select="translate(substring-before(substring-after(/MarquisEDL/ClipList/Clip/Material_ID, 'C5_'), '.mxf'), '_', '/')"/>.mxf
                     </tn:Media_File_Name> -->
                <tn:Media_File_Name>
                    <xsl:value-of select="/MarquisEDL/ClipList/Clip/File"/>.mxf
                </tn:Media_File_Name>
                <!-- <tn:Media_File_Name><xsl:value-of select="/MarquisEDL/ClipList/Clip/File"/>C5_12345_0001A.mxf</tn:Media_File_Name> -->
                <tn:Frame_Rate>
                    <xsl:value-of select="/MarquisEDL/ClipList/Clip/AvidFramerate"/>
                </tn:Frame_Rate>
                <tn:Video_Format>
                    <xsl:value-of select="/MarquisEDL/ClipList/Clip/AvidType"/>
                </tn:Video_Format>
                <tn:Display_Aspect_Ratio>
                    <xsl:value-of select="/MarquisEDL/ClipList/Clip/ImageAspectRatio"/>
                </tn:Display_Aspect_Ratio>
                <tn:Start_Of_File>
                    <xsl:value-of select="/MarquisEDL/ClipList/Clip/AvidSOM"/>
                </tn:Start_Of_File>
                <tn:End_Of_File>
                    <xsl:value-of select="/MarquisEDL/ClipList/Clip/AvidEOM"/>
                </tn:End_Of_File>
                <!-- <tn:Frame_Rate><xsl:value-of select="/MarquisEDL/FrameRate"/></tn:Frame_Rate> -->
                <!-- <tn:Video_Format_Profile></tn:Video_Format_Profile> -->
                <!-- <tn:Picture_Definition></tn:Picture_Definition> -->
                <!-- <tn:Picture_Width></tn:Picture_Width> -->
                <!-- <tn:Picture_Height></tn:Picture_Height> -->
                <!-- <tn:Scan_Type></tn:Scan_Type> -->
                <!-- <tn:Scan_Order></tn:Scan_Order> -->
                <!-- <tn:Video_Bit_Rate></tn:Video_Bit_Rate> -->
                <!-- <tn:Video_Bit_Rate_Mode></tn:Video_Bit_Rate_Mode> -->
                <!-- <tn:Picutre_Aspect_Ratio></tn:Picutre_Aspect_Ratio> -->
                <!-- <tn:Active_Format_Description></tn:Active_Format_Description> -->
                <!-- <tn:GOP_Structure></tn:GOP_Structure> -->
                <!-- <tn:File_Size_Bytes></tn:File_Size_Bytes> -->
                <!-- <tn:File_MD5></tn:File_MD5> -->
                <!-- <tn:File_SHA1></tn:File_SHA1> -->
                <!-- <tn:Audio_Track_Count><xsl:value-of select="/MarquisEDL/ClipList/Clip/NumberAudioTracks"/></tn:Audio_Track_Count> -->
                <!-- <tn:Audio_Channel_Count><xsl:value-of select="/MarquisEDL/ClipList/Clip/NumberAudioTracks"/></tn:Audio_Channel_Count> -->
                <!-- <tn:Audio_Format></tn:Audio_Format> -->
            </tn:Technical>
            <ed:Editorial>
                <ed:Title>
                    <xsl:value-of select="/MarquisEDL/ClipList/Clip/Title"/> - Avid publish to Nucleus
                </ed:Title>
            </ed:Editorial>
        </Nucleus>
        
        <!-- Template to replace underscores with slashes -->
        <xsl:template name="replaceUnderscores">
            <xsl:param name="input"/>
            <xsl:param name="output" select="''"/>
            <xsl:choose>
                <xsl:when test="contains($input, '_')">
                    <xsl:variable name="before" select="substring-before($input, '_')"/>
                    <xsl:variable name="after" select="substring-after($input, '_')"/>
                    <xsl:call-template name="replaceUnderscores">
                        <xsl:with-param name="input" select="$after"/>
                        <xsl:with-param name="output" select="concat($output, $before, '/')"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat($output, $input)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:template>
        
    </xsl:stylesheet>