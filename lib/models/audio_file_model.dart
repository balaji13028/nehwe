class AudioPath {
  String? audioId, phoneNumber;
  String? audioFile;
  AudioPath({
    this.audioId,
    this.phoneNumber,
    this.audioFile,
  });

  Map<String, dynamic> toMap() {
    return {
      'audioId': audioId,
      'phoneNumber': phoneNumber,
      'audioFile': audioFile,
    };
  }

  @override
  String toString() {
    return 'screenData{audioId: $audioId,phoneNumber:$phoneNumber, audioFile: $audioFile}';
  }
}

List<AudioPath> listenAudio = [];
AudioPath newaudio = AudioPath();
