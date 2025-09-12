import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/features/song/domain/usecases/get_play_list.dart';
import 'package:spotify/features/song/presentation/bloc/play_list_state.dart';
import 'package:spotify/service_locator.dart';

class PlayListCubit extends Cubit<PlayListState> {
  late final StreamSubscription _playListStreamSubscription;

  PlayListCubit() : super(PlayListLoading());

  @override
  Future<void> close() {
    _playListStreamSubscription.cancel();
    return super.close();
  }

  Future<void> getPlayListStream() async {
    _playListStreamSubscription = sl<GetPlayListUsecase>().call().listen(
      (songs) => emit(PlayListLoaded(songs: songs)),
      onError: (_) => emit(PlayListLoadFailure()),
    );
  }
}
