import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/hot_and_new/hot_and_new_service.dart';

import '../../domain/hot_and_new/hot_and_new_resp/model/hot_and_new_resp.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService _homeService;

  HomeBloc(this._homeService) : super(HomeState.initial()) {
    //on event get home screen data
    on<GetHomeScreenData>((event, emit) async {
      //send loading to ui
      emit(state.copyWith(isLoading: true, hasError: false));
      //get data
      final movieResult = await _homeService.getHotAndNewMovieData();
      final tvResult = await _homeService.getHotAndNewTvData();

      //transform data

      final state1 = movieResult.fold((MainFailure failure) {
        return HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: [],
          trendingMovieList: [],
          tenseDramaMovieList: [],
          southIndianMovieList: [],
          trendingTvList: [],
          isLoading: false,
          hasError: true,
        );
      }, (HotAndNewResp resp) {
        final pastYear = resp.results;
        final trending = resp.results;
        final dramas = resp.results;
        final southIndian = resp.results;
        pastYear.shuffle();
        trending.shuffle();
        dramas.shuffle();
        southIndian.shuffle();
        return HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: pastYear,
          trendingMovieList: trending,
          tenseDramaMovieList: dramas,
          southIndianMovieList: southIndian,
          trendingTvList: state.trendingTvList,
          isLoading: false,
          hasError: false,
        );
      });

      emit(state1);
      final state2 = tvResult.fold((MainFailure failure) {
        return HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: [],
          trendingMovieList: [],
          tenseDramaMovieList: [],
          southIndianMovieList: [],
          trendingTvList: [],
          isLoading: false,
          hasError: true,
        );
      }, (HotAndNewResp resp) {
        final top10List = resp.results;
        return HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: state.pastYearMovieList,
          trendingMovieList: top10List,
          tenseDramaMovieList: state.tenseDramaMovieList,
          southIndianMovieList: state.southIndianMovieList,
          trendingTvList: top10List,
          isLoading: false,
          hasError: false,
        );
      });
      //send to ui

      emit(state2);
    });
  }
}
