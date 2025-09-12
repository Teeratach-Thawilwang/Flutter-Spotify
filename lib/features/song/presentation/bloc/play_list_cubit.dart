import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/features/song/domain/usecases/get_play_list.dart';
import 'package:spotify/features/song/presentation/bloc/play_list_state.dart';
import 'package:spotify/service_locator.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    var returnedSongs = await sl<GetPlayListUsecase>().call();
    returnedSongs.fold(
      (l) {
        emit(PlayListLoadFailure());
      },
      (data) {
        emit(PlayListLoaded(songs: data));
      },
    );
  }
}
