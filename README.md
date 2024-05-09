These are scripts to navigate inside an XML file, looking for missing information about the number of tracks a media file and an edit (sequence) should have. 
It will add up to 4 audio tracks, because is working with D1 standard defintion digital files, encoded in IMX50 PAL.
Also it makes a correction of the value of markers in the sequence, calculating the correct value based on the timecode of the first frame in the sequence, doing the math with the absolute value found in the position of the marker.
It has a Python version and a PowerShell version, both scripts can do the same job, it is only based on availability, for which environment is more accessible.
