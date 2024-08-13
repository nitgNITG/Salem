import 'package:flutter/cupertino.dart';

Widget meeting() => SingleChildScrollView(
  scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            width: 600,
              height: 290,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50)),
              child: Image(
                image: AssetImage(
                    'assets/images/child1.jpg'),
              )),
          Container(
              width: 600,
              height: 290,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50)),
              child: Image(
                image: AssetImage(
                    'assets/images/child2.jpg'),
              )),

          Container(
              width: double.infinity,
              height: 480,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50)),
              child: Image(
                image: AssetImage(
                    'assets/images/child5.png'),
              )),
        ],
      ),
    );
