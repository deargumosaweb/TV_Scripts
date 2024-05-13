function Convert-TimecodeToFrames($tc, $framerate = 25) {
    $parts = $tc -split ':'
    if ($parts.Count -ne 4) {
        Write-Host "Invalid timecode format: $tc"
        return $null
    }
    try {
        $hours = [int64]$parts[0]
        $minutes = [int64]$parts[1]
        $seconds = [int64]$parts[2]
        $frames = [int64]$parts[3]

        $totalFrames = $hours * 3600 * $framerate + $minutes * 60 * $framerate + $seconds * $framerate + $frames
        return $totalFrames
    }
    catch {
        Write-Host "Error converting timecode to frames: $_"
        return $null
    }
}

function Convert-FramesToTimecode($frames, $framerate = 25) {
    if ($frames -eq $null) {
        Write-Host "Null frames value provided"
        return $null
    }
    try {
        $hours = [int][math]::Floor($frames / (3600 * $framerate))
        $minutes = [int][math]::Floor(($frames % (3600 * $framerate)) / (60 * $framerate))
        $seconds = [int][math]::Floor(($frames % (60 * $framerate)) / $framerate)
        $frameRemainder = [int]($frames % $framerate)
        return "{0:D2}:{1:D2}:{2:D2}:{3:D2}" -f $hours, $minutes, $seconds, $frameRemainder
    }
    catch {
        Write-Host "Error formatting frames to timecode: $_"
        return $null
    }
}

function Process-XmlFiles($sourceDir, $outputDir) {
    Get-ChildItem $sourceDir -Filter *.xml | ForEach-Object {
        $xml = [xml](Get-Content $_.FullName)
        
        # Modify NumberAudioTracks
        $audioTracksClipList = $xml.SelectNodes("//MarquisEDL/ClipList/Clip/NumberAudioTracks")
        if ($audioTracksClipList) {
            $audioTracksClipList | ForEach-Object { $_.'#text' = '4' }
        }
        
        $audioTracksSequence = $xml.SelectNodes("//MarquisEDL/Sequence/NumberAudioTracks")
        if ($audioTracksSequence) {
            $audioTracksSequence | ForEach-Object { $_.'#text' = '4' }
        }
        
        # Check and duplicate Audio Tracks if needed
        $audio = $xml.SelectSingleNode("//MarquisEDL/Sequence/Audio")
        if ($audio -and ($audio.ChildNodes.Count -eq 1)) {
            $baseTrack = $audio.Track
            2..4 | ForEach-Object {
                $newTrack = $baseTrack.Clone()
                $newTrack.number = $_.ToString()
                $newTrack.Shot.SourceTrack = $_.ToString()
                $audio.AppendChild($newTrack) | Out-Null
            }
        }

        # Adjust Marker positions
        $sequenceStart = $xml.SelectSingleNode("//MarquisEDL/Sequence/Start").'#text'
        if ($sequenceStart) {
            $sequenceStartFrames = Convert-TimecodeToFrames $sequenceStart
            if ($sequenceStartFrames -ne $null) {
                $markerPositions = $xml.SelectNodes("//MarquisEDL/Sequence/Markers/Marker/Position")
                if ($markerPositions) {
                    $markerPositions | ForEach-Object {
                        $originalPosFrames = Convert-TimecodeToFrames $_.'#text'
                        if ($originalPosFrames -ne $null) {
                            $newTimecode = Convert-FramesToTimecode ($originalPosFrames + $sequenceStartFrames)
                            if ($newTimecode) {
                                $_.'#text' = $newTimecode
                            }
                            else {
                                Write-Host "Failed to update timecode for position: $($_.'#text')"
                                $_.'#text' = "00:00:00:00"  # Set a default or error timecode
                            }
                        }
                    }
                }
            }
        }

        # Save the modified XML
        $xml.Save((Join-Path $outputDir $_.Name))
    }
}

$sourceDirectory = "C:\Users\Public\Public-tests\Timecode_Corrections\corrections"
$outputDirectory = "C:\Users\Public\Public-tests\Timecode_Corrections\ps-fixed"
Process-XmlFiles $sourceDirectory $outputDirectory
