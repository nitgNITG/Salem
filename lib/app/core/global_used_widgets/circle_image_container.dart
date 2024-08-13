import 'package:flutter/material.dart';

Widget getCircleImageContainer(String url) => Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(
            url,
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
