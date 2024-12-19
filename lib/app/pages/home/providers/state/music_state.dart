class MusicState {
  final bool isPlaying;
  final String currentTrack;

  MusicState({
    this.isPlaying = false,
    this.currentTrack = '',
  });

  MusicState copyWith({
    bool? isPlaying,
    String? currentTrack,
  }) {
    return MusicState(
      isPlaying: isPlaying ?? this.isPlaying,
      currentTrack: currentTrack ?? this.currentTrack,
    );
  }

  @override
  bool operator ==(covariant MusicState other) {
    if (identical(this, other)) return true;

    return other.isPlaying == isPlaying && other.currentTrack == currentTrack;
  }

  @override
  int get hashCode => isPlaying.hashCode ^ currentTrack.hashCode;
}
