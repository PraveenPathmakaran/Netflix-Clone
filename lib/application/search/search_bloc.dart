import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/downloads/i_downloads_repo.dart';
import 'package:netflix/domain/search/search_service.dart';

import '../../domain/downloads/models/downloads.dart';
import '../../domain/search/model/search_resp/search_resp.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IDownloadRepo _downloadService;
  final SearchService _searchService;
  SearchBloc(this._searchService, this._downloadService)
      : super(SearchState.initial()) {
    //idle state
    on<Initialize>((event, emit) async {
      if (state.idleList.isNotEmpty) {
        emit(state);
        return;
      }
      emit(const SearchState(
          searchResultList: [], idleList: [], isLoading: true, isError: false));
      //get trending
      final _result = await _downloadService.getDownloadsImages();
      final _state = _result.fold(
        (MainFailure f) {
          return const SearchState(
              searchResultList: [],
              idleList: [],
              isLoading: false,
              isError: true);
        },
        (List<Downloads> list) {
          return SearchState(
              searchResultList: [],
              idleList: list,
              isLoading: false,
              isError: false);
        },
      );
      //show to ui
      emit(_state);
    });
//search result state
    on<SearchMovie>((event, emit) async {
      //call search movie api
      emit(
        const SearchState(
          searchResultList: [],
          idleList: [],
          isLoading: true,
          isError: false,
        ),
      );
      final result =
          await _searchService.searchMovies(movieQuery: event.movieQuery);

      final _state = result.fold(
        (MainFailure f) {
          return const SearchState(
              searchResultList: [],
              idleList: [],
              isLoading: false,
              isError: true);
        },
        (SearchResp r) {
          return SearchState(
              searchResultList: r.results,
              idleList: [],
              isLoading: false,
              isError: false);
        },
      );
      //show to ui
      emit(_state);
    });
  }
}
