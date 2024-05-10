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
    
    <!-- Template to calculate the duration -->
    <xsl:template name="calculateDuration">
        <xsl:param name="start"/>
        <xsl:param name="end"/>
        <xsl:variable name="startFrames" select="substring-after($start, ':')"/>
        <xsl:variable name="endFrames" select="substring-after($end, ':')"/>
        <xsl:variable name="startSeconds" select="substring-before(substring-after($start, ':'), ':')"/>
        <xsl:variable name="endSeconds" select="substring-before(substring-after($end, ':'), ':')"/>
        <xsl:variable name="startMinutes" select="substring-before(substring-after(substring-after($start, ':'), ':'), ':')"/>
        <xsl:variable name="endMinutes" select="substring-before(substring-after(substring-after($end, ':'), ':'), ':')"/>
        <xsl:variable name="startHours" select="substring-before($start, ':')"/>
        <xsl:variable name="endHours" select="substring-before($end, ':')"/>
        <xsl:variable name="totalFrames" select="number($endFrames) - number($startFrames)"/>
        <xsl:variable name="totalSeconds" select="number($endSeconds) - number($startSeconds)"/>
        <xsl:variable name="totalMinutes" select="number($endMinutes) - number($startMinutes)"/>
        <xsl:variable name="totalHours" select="number($endHours) - number($startHours)"/>
        <xsl:variable name="totalFramesAdjusted" select="if ($totalFrames lt 0) then (number($totalFrames) + 25) else $totalFrames"/>
        <xsl:variable name="totalSecondsAdjusted" select="if ($totalSeconds lt 0) then (number($totalSeconds) + 60) else $totalSeconds"/>
        <xsl:variable name="totalMinutesAdjusted" select="if ($totalMinutes lt 0) then (number($totalMinutes) + 60) else $totalMinutes"/>
        <xsl:variable name="totalHoursAdjusted" select="if ($totalHours lt 0) then (number($totalHours) + 24) else $totalHours"/>
        <Duration>
            <xsl:value-of select="concat(format-number($totalHoursAdjusted, '00'), ':', format-number($totalMinutesAdjusted, '00'), ':', format-number($totalSecondsAdjusted, '00'), ':', format-number($totalFramesAdjusted, '00'))"/>
        </Duration>
    </xsl:template>
    
    
    <!-- Identity template to copy all nodes and attributes -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:comment>Generated from Nucleus Channel 5 Medway Transform v0.1</xsl:comment>
        <Nucleus xmlns="http://www.redbeemedia.com/nucleus/metadata/ns/v1/standard_metadata">
            <id:Identifiers xmlns:id="http://www.redbeemedia.com/nucleus/metadata/ns/v1/identification">
                <id:Material_ID>
                    <xsl:call-template name="replaceUnderscores">
                        <xsl:with-param name="input" select="MarquisEDL/ClipList/Clip/Title"/>
                    </xsl:call-template>
                </id:Material_ID>
                <!-- <id:Alternate_ID></id:Alternate_ID> -->
            </id:Identifiers>
            <cn:Content xmlns:cn="http://www.redbeemedia.com/nucleus/metadata/ns/v1/content">
                <cn:Content_Type><xsl:value-of select="/MarquisEDL/ClipList/Clip/Content_Type"/></cn:Content_Type>
                <cn:Supplier>AVID publish to Nucleus</cn:Supplier>
            </cn:Content>
            <tn:Technical xmlns:tn="http://www.redbeemedia.com/nucleus/metadata/ns/v1/technical">
                <tn:Media_File_Name>
                    <xsl:value-of select="MarquisEDL/ClipList/Clip/File"/>.mxf
                </tn:Media_File_Name>
                <!-- <tn:Media_File_Name><xsl:value-of select="/MarquisEDL/ClipList/Clip/File"/>C5_12345_0001A.mxf</tn:Media_File_Name> -->
                <tn:Frame_Rate>
                    <xsl:value-of select="/MarquisEDL/Framerate"/>
                </tn:Frame_Rate>
                <tn:Video_Format>
                    <xsl:value-of select="MarquisEDL/ClipList/Clip/CustomMetadata/CustomData[@name='Format'] != ''"/>
                </tn:Video_Format>
                <tn:Display_Aspect_Ratio>
                    <xsl:value-of select="MarquisEDL/ClipList/Clip/CustomMetadata/CustomData[@name='Aspect Ratio'] != ''"/>
                </tn:Display_Aspect_Ratio>
                <tn:Start_Of_File>
                    <xsl:value-of select="/MarquisEDL/ClipList/Clip/Start"/>
                </tn:Start_Of_File>
                <tn:End_Of_File>
                    <xsl:value-of select="/MarquisEDL/ClipList/Clip/End"/>
                </tn:End_Of_File>
                
            </tn:Technical>
            <ed:Editorial xmlns:ed="http://www.redbeemedia.com/nucleus/metadata/ns/v1/editorial">
                <ed:Title>
                    <xsl:value-of select="/MarquisEDL/ClipList/Clip/Title"/> - Avid publish to Nucleus
                </ed:Title>
            </ed:Editorial>
            <sg:Segmentation xmlns:sg="http://www.redbeemedia.com/nucleus/metadata/ns/v1/segmentation">
                <sg:Log_Tracks>
                    <sg:Log_Track>
                        <sg:Track_Type>PLAYOUT</sg:Track_Type>
                        <sg:Log_Items>
                            <sg:Log_Item>
                                <sg:Order>1</sg:Order>
                                <sg:Item_Type>PART</sg:Item_Type>
                                <sg:Mark_In>
                                    <xsl:value-of select="/MarquisEDL/ClipList/Clip/Start"/>
                                </sg:Mark_In>
                                <sg:Duration>
                                    <xsl:call-template name="calculateDuration">
                                        <xsl:with-param name="start" select="/MarquisEDL/ClipsList/Clip/Start"/>
                                        <xsl:with-param name="end" select="/MarquisEDL/ClipsList/Clip/End"/>
                                    </xsl:call-template>
                                </sg:Duration>
                            </sg:Log_Item>
                        </sg:Log_Items>
                    </sg:Log_Track>
                </sg:Log_Tracks>
            </sg:Segmentation>
        </Nucleus>
    </xsl:template>
</xsl:stylesheet>
