import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../home/widgets/custom_button_widget.dart';
import 'video_widget.dart';

class ComingSoonWidget extends StatelessWidget {
  const ComingSoonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text('FEB', style: TextStyle(fontSize: 20, color: kGreyColor)),
              Text(
                '11',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        SizedBox(
          width: size.width - 50,
          height: 450,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VideoWidget(),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'TALL GIRL 2',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -5),
                      ),
                      const Spacer(),
                      Row(
                        children: const [
                          CustomButtonWidget(
                            icon: Icons.alarm,
                            title: 'Remind me',
                            iconSize: 20,
                            textSize: 12,
                          ),
                          kWidth,
                          CustomButtonWidget(
                            icon: Icons.info,
                            title: 'Info',
                            iconSize: 20,
                            textSize: 12,
                          ),
                          kWidth
                        ],
                      )
                    ],
                  )
                ],
              ),
              kHeight,
              const Text('Coming on Friday'),
              kHeight,
              const Text('Tall Girl 2'),
              kHeight,
              const Text(
                "simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic",
                style: TextStyle(color: kGreyColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
