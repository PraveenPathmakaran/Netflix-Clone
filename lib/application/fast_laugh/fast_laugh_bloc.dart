import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/downloads/i_downloads_repo.dart';

import '../../domain/downloads/models/downloads.dart';

part 'fast_laugh_bloc.freezed.dart';
part 'fast_laugh_event.dart';
part 'fast_laugh_state.dart';

final dummyVideoUrls = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4"
];

ValueNotifier<Set<int>> likedVideosIdNotifier = ValueNotifier({});

@injectable
class FastLaughBloc extends Bloc<FastLaughEvent, FastLaughState> {
  FastLaughBloc(IDownloadRepo downloadService)
      : super(FastLaughState.initial()) {
    on<Initialize>((event, emit) async {
      //sending loading to UI
      emit(const FastLaughState(
        videosList: [],
        isLoading: true,
        isError: false,
      ));
      //get trending movies

      final result = await downloadService.getDownloadsImages();
      final state = result.fold(
        (l) {
          return const FastLaughState(
            videosList: [],
            isLoading: false,
            isError: true,
          );
        },
        (resp) => FastLaughState(
          videosList: resp,
          isLoading: false,
          isError: false,
        ),
      );
      //send to ui
      emit(state);
    });

    on<LikeVideo>((event, emit) async {
      likedVideosIdNotifier.value.add(event.id);
    });
    on<UnlikeVideo>((event, emit) async {
      likedVideosIdNotifier.value.remove(event.id);
    });
  }
}
