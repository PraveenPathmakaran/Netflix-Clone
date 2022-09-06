import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import '../../core/constants.dart';
import 'widgets/coming_soon_widget.dart';
import 'widgets/everyones_watching_widget.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(90),
            child: AppBar(
              title: const Text(
                'New & Hot',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
              actions: [
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
              bottom: TabBar(
                  labelColor: kBlackColor,
                  labelStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  unselectedLabelColor: kWhiteColor,
                  isScrollable: true,
                  indicator: BoxDecoration(
                      color: kWhiteColor, borderRadius: kRadius30),
                  tabs: const [
                    Tab(
                      text: 'Coming Soon',
                    ),
                    Tab(
                      text: "everyone's watching",
                    )
                  ]),
            ),
          ),
          body: TabBarView(children: [
            _buildComingSoon(context),
            _buildEveryonesWatching()
          ])),
    );
  }

  Widget _buildComingSoon(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return const ComingSoonWidget();
      },
    );
  }

  Widget _buildEveryonesWatching() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return const EveryOnesWatchingWidgets();
      },
      itemCount: 10,
    );
  }
}
