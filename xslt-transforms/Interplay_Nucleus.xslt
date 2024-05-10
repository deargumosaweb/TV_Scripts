<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="timecode.xsl"/>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
	<xsl:template match="/">
		<xsl:comment>Generated from Nucleus Standard Medway Transform v0.4</xsl:comment>
		<Nucleus xmlns="http://www.redbeemedia.com/nucleus/metadata/ns/v1/standard_metadata" 
			xmlns:au="http://www.redbeemedia.com/nucleus/metadata/ns/v1/audio_layout" 
			xmlns:sg="http://www.redbeemedia.com/nucleus/metadata/ns/v1/segmentation" 
			xmlns:mk="http://www.redbeemedia.com/nucleus/metadata/ns/v1/markers">
			<xsl:if test="/MarquisEDL/ClipList/Clip/CustomMetadata/CustomData[@name='Deadline'] != ''">
				<xsl:attribute name="Deadline"><xsl:value-of select="/MarquisEDL/ClipList/Clip/CustomMetadata/CustomData[@name='Deadline']"></xsl:value-of></xsl:attribute>
			</xsl:if>
			<id:Identifiers xmlns:id="http://www.redbeemedia.com/nucleus/metadata/ns/v1/identification">
				<id:Material_ID><xsl:value-of select="/MarquisEDL/ClipList/Clip/CustomMetadata/CustomData[@name='Mat ID']"/></id:Material_ID>
				<id:Material_ID_Suffix><xsl:value-of select="substring(/MarquisEDL/ClipList/Clip/File, string-length(/MarquisEDL/ClipList/Clip/CustomMetadata/CustomData[@name='Mat ID'])+1)"/></id:Material_ID_Suffix>
				<!-- <id:Alternate_ID></id:Alternate_ID> -->
			</id:Identifiers>
			<!-- <an:Ancillary xmlns:an="http://www.redbeemedia.com/nucleus/metadata/ns/v1/ancillary"></an:Ancillary> -->
			<cn:Content xmlns:cn="http://www.redbeemedia.com/nucleus/metadata/ns/v1/content">
				<cn:Content_Type><xsl:value-of select="/MarquisEDL/ClipList/Clip/CustomMetadata/CustomData[@name='Content Type']"/></cn:Content_Type>
				<!-- <cn:Content_Sub_Type></cn:Content_Sub_Type> -->
				<xsl:if test="/MarquisEDL/ClipList/Clip/CustomMetadata/CustomData[@name='Content Sub Type C4'] != ''">
					<cn:Client_Content_Sub_Type><xsl:value-of select="/MarquisEDL/ClipList/Clip/CustomMetadata/CustomData[@name='Content Sub Type C4']"/></cn:Client_Content_Sub_Type>
				</xsl:if>
				<!-- <cn:Description></cn:Description> -->
				<cn:Supplier>RBM - Post Production</cn:Supplier>
				<cn:Origin>Post Production</cn:Origin>
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
				<ed:Title><xsl:value-of select="/MarquisEDL/ClipList/Clip/CustomMetadata/CustomData[@name='Title']"/></ed:Title>
				<ed:version><xsl:value-of select="floor(substring(/MarquisEDL/ClipList/Clip/File, string-length(/MarquisEDL/ClipList/Clip/CustomMetadata/CustomData[@name='Mat ID'])+3))"/></ed:version>
			</ed:Editorial>
			<!-- <as:Access_Services></as:Access_Services> -->
			<qc:Quality_Control xmlns:qc="http://www.redbeemedia.com/nucleus/metadata/ns/v1/qc">
				<qc:Manual_QC>
					<qc:Manual_QC_Type>FullHiResQC</qc:Manual_QC_Type>
					<qc:Completion_Status>Required</qc:Completion_Status>
				</qc:Manual_QC>
				<qc:Auto_QC>
					<qc:AQC_Type>Custom</qc:AQC_Type>
					<qc:Completion_Status>Required</qc:Completion_Status>
				</qc:Auto_QC>
				<!-- <xsl:if test="/MarquisEDL/ClipList/Clip/CustomMetadata/CustomData[@name='Comments'] != ''">
									<qc:QC_Reports>
									<qc:QC_Report>
									<qc:QC_Type>MANUAL</qc:QC_Type>
									<qc:QC_Status>WARNING</qc:QC_Status>
									<qc:QC_Items>
									<qc:QC_Item>
									<qc:Description><xsl:value-of select="/MarquisEDL/ClipList/Clip/CustomMetadata/CustomData[@name='Comments']" /></qc:Description>
									<qc:Item_Status>WARNING</qc:Item_Status>
									<qc:Mark_In><xsl:value-of select="/MarquisEDL/ClipList/Clip/Start" /></qc:Mark_In>
									<qc:Duration>00:00:00:10</qc:Duration>
									<qc:Order>1</qc:Order>
									</qc:QC_Item>
									</qc:QC_Items>
									</qc:QC_Report>
									</qc:QC_Reports>
									</xsl:if> -->
							</qc:Quality_Control>
		</Nucleus>
	</xsl:template>
</xsl:stylesheet>