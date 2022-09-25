
import 'package:flutter/material.dart';
import '../../Constant/const_colors.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    required this.title,
    required this.amount,
    required this.image,
    required this.color,
    Key? key,
  }) : super(key: key);

  final String title;
  final String amount;
  final String image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidht = MediaQuery.of(context).size.width;
    return SizedBox(
      width: mWidht * .43,
      height: mHeight * .24,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: color,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 45,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(title,
                          style: TextStyle(color: ConstColors().gradientStart)),
                    ),
                  ),
                  Image.asset(
                    image,
                    height: 40,
                    width: 40,
                  )
                ],
              ),
              SizedBox(height: mHeight * .015),
              Text(
                amount,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: mHeight * .01),
              Text('2 debts',
                  style: TextStyle(color: ConstColors().gradientStart)),
            ],
          ),
        ),
      ),
    );
  }
}
