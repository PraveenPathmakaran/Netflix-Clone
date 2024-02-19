import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import 'custom_button_widget.dart';

class BackgroundCard extends StatelessWidget {
  final String backgroundImage;
  const BackgroundCard({Key? key, required this.backgroundImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 600,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://image.tmdb.org/t/p/w600_and_h900_bestv2/vtfsNxAsDHElFvYHUc9Khwqg17Y.jpg"),
                fit: BoxFit.cover),
          ),
        ),
        const Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButtonWidget(
                  icon: Icons.add,
                  title: 'My List',
                ),
                PlayButton(),
                CustomButtonWidget(
                  icon: Icons.info,
                  title: 'Info',
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kWhiteColor),
        ),
        icon: const Icon(
          Icons.play_arrow,
          size: 25,
          color: kBlackColor,
        ),
        label: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            'Play',
            style: TextStyle(
              fontSize: 20,
              color: kBlackColor,
            ),
          ),
        ));
  }
}
