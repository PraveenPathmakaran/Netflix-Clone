import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:netflix/core/colors/colors.dart';
import '../../../core/constants.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 25,
              height: 200,
            ),
            Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: kRadius10,
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://www.themoviedb.org/t/p/w300_and_h450_bestv2/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg"),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: -5,
          bottom: -30,
          child: BorderedText(
            strokeWidth: 5,
            strokeColor: Colors.white,
            child: Text(
              "${index + 1}",
              style: const TextStyle(
                  fontSize: 140,
                  decoration: TextDecoration.none,
                  decorationColor: Colors.white,
                  color: kBlackColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
