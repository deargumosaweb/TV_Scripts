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

        return $hours * 3600 * $framerate + $minutes * 60 * $framerate + $seconds * $framerate + $frames
    } catch {
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
    } catch {
        Write-Host "Error formatting frames to timecode: $_"
        return $null
    }
}

function Process-XmlFiles($sourceDir, $outputDir) {
    Get-ChildItem $sourceDir -Filter *.xml | ForEach-Object {
        $xml = [xml](Get-Content $_.FullName)
        
        $sequenceStart = $xml.SelectSingleNode("//MarquisEDL/Sequence/Start").'#text'
        $sequenceEnd = $xml.SelectSingleNode("//MarquisEDL/Sequence/End").'#text'
        if ($sequenceStart -and $sequenceEnd) {
            $sequenceStartFrames = Convert-TimecodeToFrames $sequenceStart
            $sequenceEndFrames = Convert-TimecodeToFrames $sequenceEnd

            $markerPositions = $xml.SelectNodes("//MarquisEDL/Sequence/Markers/Marker/Position")
            $markerFrames = $markerPositions | ForEach-Object { Convert-TimecodeToFrames $_.'#text' }

            # Check if markers are in ascending order
            $isOrdered = $true
            for ($i = 0; $i -lt $markerFrames.Count - 1; $i++) {
                if ($markerFrames[$i] -gt $markerFrames[$i + 1]) {
                    $isOrdered = $false
                    break
                }
            }

            if (-not $isOrdered) {
                Write-Host "Markers out of order: $($markerPositions | ForEach-Object { $_.'#text' })"
                continue
            }

            # Adjust markers if ordered
            $markerPositions | ForEach-Object {
                $originalPosFrames = Convert-TimecodeToFrames $_.'#text'
                if ($originalPosFrames -ne $null -and $originalPosFrames -lt $sequenceStartFrames) {
                    $newTimecode = Convert-FramesToTimecode ($originalPosFrames + $sequenceStartFrames)
                    $_.'#text' = $newTimecode
                }
            }
        } else {
            Write-Host "Start or end time not found in sequence for file $($_.Name)"
        }

        $xml.Save((Join-Path $outputDir $_.Name))
        Write-Host "File saved: $(Join-Path $outputDir $_.Name)"
    }
}

$sourceDirectory = "C:\Users\Public\Public-tests\Timecode_Corrections\corrections"
$outputDirectory = "C:\Users\Public\Public-tests\Timecode_Corrections\ps-fixed"
Process-XmlFiles $sourceDirectory $outputDirectory
