<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="timecode.xsl"/>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
	<xsl:template match="/">
		<xsl:comment>Generated from Nucleus Channel 5 Medway Transform v0.1</xsl:comment>
		<Nucleus xmlns="http://www.redbeemedia.com/nucleus/metadata/ns/v1/standard_metadata" >
			<id:Identifiers xmlns:id="http://www.redbeemedia.com/nucleus/metadata/ns/v1/identification">
				<id:Material_ID><xsl:value-of select="/MarquisEDL/ClipList/Clip/File"/></id:Material_ID>
				<!-- <id:Alternate_ID></id:Alternate_ID> -->
			</id:Identifiers>
			<an:Ancillary xmlns:an="http://www.redbeemedia.com/nucleus/metadata/ns/v1/ancillary">
				<an:File>
					<an:File_Name><xsl:value-of select="/MarquisEDL/ClipList/Clip/File"/>_gen.xml</an:File_Name>
					<an:File_Type>Metadata</an:File_Type>
					<an:File_Description>EDL</an:File_Description>
				</an:File>
			</an:Ancillary>
			<cn:Content xmlns:cn="http://www.redbeemedia.com/nucleus/metadata/ns/v1/content">
				<cn:Content_Type>Programme</cn:Content_Type>
				<!-- <cn:Content_Sub_Type></cn:Content_Sub_Type> -->
				<!-- <cn:Description></cn:Description> -->
				<xsl:if test="/MarquisEDL/ClipList/Clip/CustomMetadata/CustomData[@name='Description'] != ''">
					<cn:Description><xsl:value-of select="/MarquisEDL/ClipList/Clip/CustomMetadata/CustomData[@name='Description']"/></cn:Description>
				</xsl:if>
				<cn:Supplier>Channel_5</cn:Supplier>
				<!-- <cn:Channel></cn:Channel> -->
			</cn:Content>
			<tn:Technical xmlns:tn="http://www.redbeemedia.com/nucleus/metadata/ns/v1/technical">
				<tn:Media_File_Name><xsl:value-of select="/MarquisEDL/ClipList/Clip/File"/>.mxf</tn:Media_File_Name>
				<!-- <tn:Start_Of_File><xsl:value-of select="/MarquisEDL/ClipList/Clip/Start"/></tn:Start_Of_File> -->
				<!-- <tn:Frame_Rate><xsl:value-of select="/MarquisEDL/FrameRate"/></tn:Frame_Rate> -->
				<!-- <tn:Video_Format></tn:Video_Format> -->
				<!-- <tn:Video_Format_Profile></tn:Video_Format_Profile> -->
				<!-- <tn:Picture_Definition></tn:Picture_Definition> -->
				<!-- <tn:Picture_Width></tn:Picture_Width> -->
				<!-- <tn:Picture_Height></tn:Picture_Height> -->
				<!-- <tn:Scan_Type></tn:Scan_Type> -->
				<!-- <tn:Scan_Order></tn:Scan_Order> -->
				<!-- <tn:Video_Bit_Rate></tn:Video_Bit_Rate> -->
				<!-- <tn:Video_Bit_Rate_Mode></tn:Video_Bit_Rate_Mode> -->
				<!-- <tn:Display_Aspect_Ratio></tn:Display_Aspect_Ratio> -->
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
			<ed:Editorial xmlns:ed="http://www.redbeemedia.com/nucleus/metadata/ns/v1/editorial">
				<ed:Title><xsl:value-of select="/MarquisEDL/ClipList/Clip/File"/></ed:Title>
			</ed:Editorial>
		</Nucleus>
	</xsl:template>
</xsl:stylesheet>