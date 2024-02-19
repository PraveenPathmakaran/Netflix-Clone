import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/home/home_bloc.dart';
import 'package:netflix/core/colors/colors.dart';

import '../../core/constants.dart';
import '../widgets/main_title_card.dart';
import 'widgets/background_card.dart';
import 'widgets/categories.dart';
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
                  final releasedPastYear = state.pastYearMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();

                  //trending
                  final southIndianMovies = state.trendingMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();
                  //_trending.shuffle();
                  //tense drama
                  final trending = state.tenseDramaMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();
                  //_tenseDramas.shuffle();
                  //south indian movies
                  final tenseDramas = state.southIndianMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();
                  // _southIndianMovies.shuffle();

                  //top 10 tv shows
                  final top10TvShows = state.trendingTvList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();

                  // _top10TvShows.shuffle();

                  if (southIndianMovies.isEmpty &&
                      releasedPastYear.isEmpty &&
                      trending.isEmpty &&
                      tenseDramas.isEmpty &&
                      top10TvShows.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }
                  //listview
                  return ListView(
                    children: [
                      const BackgroundCard(
                          backgroundImage:
                              'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/vtfsNxAsDHElFvYHUc9Khwqg17Y.jpg'),
                      kHeight,
                      MainTitleCard(
                        title: 'Trending Now',
                        posterList: trending,
                      ),
                      kHeight,
                      NumberTitleCard(postersList: top10TvShows.sublist(0, 10)),
                      MainTitleCard(
                        title: 'Tense Dramas',
                        posterList: tenseDramas,
                      ),
                      kHeight,
                      MainTitleCard(
                        title: 'South Indian Cinemas',
                        posterList: southIndianMovies,
                      ),
                    ],
                  );
                },
              ),
              scrollNotifier.value == true
                  ? AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
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
                                Image.network(
                                  "https://upload.wikimedia.org/wikipedia/commons/0/0b/Netflix-avatar.png",
                                  width: 25,
                                  height: 25,
                                ),
                                kWidth
                              ],
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    'TV Shows',
                                    style: kHomeTitleText,
                                  ),
                                  const Text(
                                    'Movies',
                                    style: kHomeTitleText,
                                  ),
                                  TextButton(
                                    child: const Row(
                                      children: [
                                        Text(
                                          'Categories',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          color: kWhiteColor,
                                        )
                                      ],
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const Categories();
                                          });
                                    },
                                  ),
                                ],
                              ),
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
