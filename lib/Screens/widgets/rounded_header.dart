import 'package:debt_and_loan/Constant/const_colors.dart';
import 'package:flutter/material.dart';

class RoundedHeaderWidget extends StatelessWidget {
  const RoundedHeaderWidget({
    required this.icon,
    required this.title,
    Key? key,
  }) : super(key: key);

  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white30,
          radius: 40,
          child: CircleAvatar(
            backgroundColor: ConstColors().roundTile,
            radius: 30,
            child: Image.asset(
              icon,
              width: 15,
              height: 15,
            ),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
