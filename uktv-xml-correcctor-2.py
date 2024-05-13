import os
import xml.etree.ElementTree as ET
import copy

def timecode_to_frames(timecode, framerate=25):
    return sum(f * int(t) for f, t in zip((3600 * framerate, 60 * framerate, framerate, 1), timecode.split(":")))

def frames_to_timecode(frames, framerate=25):
    return "{0:02d}:{1:02d}:{2:02d}:{3:02d}".format(frames // (3600 * framerate), (frames // (60 * framerate)) % 60, (frames // framerate) % 60, frames % framerate)

def process_xml_files(source_dir, output_dir):
    for filename in os.listdir(source_dir):
        if filename.endswith(".xml"):
            tree = ET.parse(os.path.join(source_dir, filename))
            root = tree.getroot()

            sequence_element = root.find("Sequence")
            if sequence_element is None:
                print(f"Warning: <Sequence> element not found in {filename}")
                continue

            sequence_start_element = sequence_element.find("Start")
            sequence_end_element = sequence_element.find("End")
            if sequence_start_element is None or sequence_end_element is None:
                print(f"Warning: Start or end time not found in sequence for file {filename}")
                continue

            sequence_start_frames = timecode_to_frames(sequence_start_element.text)
            sequence_end_frames = timecode_to_frames(sequence_end_element.text)

            # Modify NumberAudioTracks
            for path in ["ClipList/Clip/NumberAudioTracks", "Sequence/NumberAudioTracks"]:
                for nat in root.findall(path):
                    if nat.text == "1":
                        nat.text = "4"

            # Check and duplicate Audio Tracks if needed
            audio_element = sequence_element.find("Audio")
            if audio_element is not None and len(audio_element.findall("Track")) == 1:
                base_track = audio_element.find("Track")
                for i in range(2, 5): # Create tracks 2, 3, and 4
                    new_track = copy.deepcopy(base_track)
                    new_track.set("number", str(i))
                    new_shot = new_track.find("Shot")
                    new_shot.find("SourceTrack").text = str(i)
                    audio_element.append(new_track)

            # Collect and check marker positions
            markers = sequence_element.findall("Markers/Marker/Position")
            marker_frames = [timecode_to_frames(marker.text) for marker in markers if marker.text]
            if not all(earlier <= later for earlier, later in zip(marker_frames, marker_frames[1:])):
                out_of_order_markers = [marker.text for marker in markers]
                print(f"Markers out of order in {filename}: {out_of_order_markers}")
                continue  # Skip modification if markers are out of order

            # Adjust Marker positions
            for marker in markers:
                old_marker_frames = timecode_to_frames(marker.text)
                if old_marker_frames < sequence_start_frames:
                    new_marker_frames = sequence_start_frames + old_marker_frames
                    new_marker_timecode = frames_to_timecode(new_marker_frames)
                    marker.text = new_marker_timecode
                    print(f"Adjusted marker from {marker.text} to {new_marker_timecode} in file {filename}")
                else:
                    print("No timecode was changed")

            # Save the modified XML to a new file
            new_file_path = os.path.join(output_dir, filename)
            tree.write(new_file_path)
            print(f"File saved: {new_file_path}")

source_dir = r"C:\Users\Public\Public-tests\Timecode_Corrections\corrections"
output_dir = r"C:\Users\Public\Public-tests\Timecode_Corrections\python-fixed"
process_xml_files(source_dir, output_dir)
