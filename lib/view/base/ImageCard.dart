import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  double height;
  double width;
  final String image;

  ImageCard(
    this.image,
    this.height,
    this.width,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        margin: const EdgeInsets.only(right: 8),
        child: Image.network(
          'https://palmail.betweenltd.com/storage/$image',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
