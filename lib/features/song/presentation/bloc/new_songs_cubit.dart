import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/features/song/presentation/bloc/new_songs_state.dart';
import 'package:spotify/features/song/domain/usecases/get_news_songs.dart';
import 'package:spotify/service_locator.dart';

class NewSongsCubit extends Cubit<NewSongsState> {
  late final StreamSubscription _newSongsStreamSubScription;

  NewSongsCubit() : super(NewSongsLoading());

  @override
  Future<void> close() {
    _newSongsStreamSubScription.cancel();
    return super.close();
  }

  Future<void> getNewsSongsStream() async {
    _newSongsStreamSubScription = sl<GetNewsSongsUsecase>().call().listen(
      (songs) => emit(NewSongsLoaded(songs: songs)),
      onError: (_) => emit(NewsSongsLoadFailure()),
    );
  }
}
