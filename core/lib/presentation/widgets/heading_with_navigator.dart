import 'package:flutter/material.dart';

import '../../styles/text_style.dart';


class BuildHeading extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const BuildHeading({ Key? key, required this.title,required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  
  }
}