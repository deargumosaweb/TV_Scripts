import os
import xml.etree.ElementTree as ET
import copy


def timecode_to_frames(timecode, framerate=25):
    return sum(
        f * int(t)
        for f, t in zip(
            (3600 * framerate, 60 * framerate, framerate, 1), timecode.split(":")
        )
    )


def frames_to_timecode(frames, framerate=25):
    return "{0:02d}:{1:02d}:{2:02d}:{3:02d}".format(
        frames // (3600 * framerate),
        (frames // (60 * framerate)) % 60,
        (frames // framerate) % 60,
        frames % framerate,
    )


def process_xml_files(source_dir, output_dir):
    for filename in os.listdir(source_dir):
        if filename.endswith(".xml"):
            tree = ET.parse(os.path.join(source_dir, filename))
            root = tree.getroot()

            # Locate the Sequence element and its Start element
            sequence_element = root.find("Sequence")
            if sequence_element is not None:
                sequence_start_element = sequence_element.find("Start")
                if sequence_start_element is not None and sequence_start_element.text:
                    print(f"Contents of <Sequence> in {filename}:")
                    print(f"Found start time: {sequence_start_element.text}")
                    tc_sequence_start_frames = timecode_to_frames(
                        sequence_start_element.text
                    )
                else:
                    print(
                        f"Warning: No start time found in sequence for file {filename}"
                    )
                    continue
            else:
                print(f"Warning: <Sequence> element not found in {filename}")
                continue

            # Modify NumberAudioTracks
            for path in [
                "ClipList/Clip/NumberAudioTracks",
                "Sequence/NumberAudioTracks",
            ]:
                for nat in root.findall(path):
                    if nat.text == "1":
                        nat.text = "4"

            # Check and duplicate Audio Tracks if needed
            audio_element = sequence_element.find("Audio")
            if audio_element is not None:
                tracks = audio_element.findall("Track")
                if len(tracks) == 1:
                    base_track = tracks[0]
                    for i in range(2, 5):  # Create tracks 2, 3, and 4
                        new_track = copy.deepcopy(base_track)
                        new_track.set("number", str(i))
                        new_shot = new_track.find("Shot")
                        new_shot.find("SourceTrack").text = str(i)
                        audio_element.append(new_track)

            # Adjust Marker positions
            markers = root.findall("Sequence/Markers/Marker/Position")
            for marker in markers:
                if marker.text:  # Check if marker text exists
                    old_marker_frames = timecode_to_frames(marker.text)
                    new_marker_frames = tc_sequence_start_frames + old_marker_frames
                    new_marker_timecode = frames_to_timecode(new_marker_frames)
                    print(
                        f"Old Marker: {marker.text}, New Marker: {new_marker_timecode}"
                    )
                    marker.text = new_marker_timecode
                else:
                    print(f"Warning: Empty marker position in file {filename}")

            # Save the modified XML to a new file
            new_file_path = os.path.join(output_dir, filename)
            tree.write(new_file_path)
            print(f"File saved: {new_file_path}")


source_dir = r"C:\Users\Public\Public-tests\Timecode_Corrections\corrections"
output_dir = r"C:\Users\Public\Public-tests\Timecode_Corrections\python-fixed"
process_xml_files(source_dir, output_dir)
