import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/features/song/presentation/bloc/song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      // if (state is SongPlayerLoaded) {
      //   updateSongPlayer();
      // }
    });

    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!;
    });
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }

  Future<void> loadSong(String url) async {
    try {
      await audioPlayer.setUrl(url);
      emit(SongPlayerLoaded());
    } catch (e) {
      emit(SongPlayerFailure());
    }
  }

  void playOrPauseSong() {
    if (audioPlayer.playing) {
      audioPlayer.stop();
    } else {
      audioPlayer.play();
    }

    emit(SongPlayerLoaded());
  }

  void updateSongPlayer() {
    emit(SongPlayerLoaded());
  }
}
