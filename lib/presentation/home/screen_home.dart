import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/home/home_bloc.dart';
import '../../core/constants.dart';
import '../widgets/main_title_card.dart';
import 'widgets/background_card.dart';

import 'widgets/number_title_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
        body: ValueListenableBuilder(
      valueListenable: scrollNotifier,
      builder: (context, value, _) {
        return NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            final ScrollDirection direction = notification.direction;

            if (direction == ScrollDirection.reverse) {
              scrollNotifier.value = false;
            } else if (direction == ScrollDirection.forward) {
              scrollNotifier.value = true;
            }
            return true;
          },
          child: Stack(
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  } else if (state.hasError) {
                    return const Center(
                        child: Text(
                      'Error while getting data',
                      style: TextStyle(color: Colors.white),
                    ));
                  }
                  //released pastyear
                  final _releasedPastYear = state.pastYearMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();

                  //trending
                  final _trending = state.trendingMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();
                  _trending.shuffle();
                  //tense drama
                  final _tenseDramas = state.tenseDramaMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();
                  _tenseDramas.shuffle();
                  //south indian movies
                  final _southIndianMovies =
                      state.southIndianMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();
                  _southIndianMovies.shuffle();

                  //top 10 tv shows
                  final _top10TvShows = state.trendingTvList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();

                  _top10TvShows.shuffle();

                  if (_southIndianMovies.isEmpty &&
                      _releasedPastYear.isEmpty &&
                      _trending.isEmpty &&
                      _tenseDramas.isEmpty &&
                      _top10TvShows.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }
                  //listview
                  return ListView(
                    children: [
                      BackgroundCard(backgroundImage: _trending),
                      kHeight,
                      MainTitleCard(
                        title: 'Trending Now',
                        posterList: _trending,
                      ),
                      kHeight,
                      NumberTitleCard(
                          postersList: _top10TvShows.sublist(0, 10)),
                      MainTitleCard(
                        title: 'Tense Dramas',
                        posterList: _tenseDramas,
                      ),
                      kHeight,
                      MainTitleCard(
                        title: 'South Indian Cinemas',
                        posterList: _southIndianMovies,
                      ),
                    ],
                  );
                },
              ),
              scrollNotifier.value == true
                  ? AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      child: Container(
                        width: double.infinity,
                        height: 90,
                        color: Colors.black.withOpacity(0.3),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  "https://cdn-images-1.medium.com/max/1200/1*ty4NvNrGg4ReETxqU2N3Og.png",
                                  width: 60,
                                  height: 60,
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.cast,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                kWidth,
                                Container(
                                  color: Colors.blue,
                                  width: 30,
                                  height: 30,
                                ),
                                kWidth
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  'TV Shows',
                                  style: kHomeTitleText,
                                ),
                                Text(
                                  'Movies',
                                  style: kHomeTitleText,
                                ),
                                Text(
                                  'Categories',
                                  style: kHomeTitleText,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  : kHeight,
            ],
          ),
        );
      },
    ));
  }
}
