import 'package:flutter/material.dart';
import 'package:fooderlich/fooderlich_theme.dart';
import 'package:fooderlich/views/widgets/circle_image.dart';

class AuthorCard extends StatefulWidget {
  final String authorName;
  final String title;
  final ImageProvider imageProvider;

  const AuthorCard({
    Key? key,
    required this.authorName,
    required this.title,
    required this.imageProvider,
  }) : super(key: key);

  @override
  State<AuthorCard> createState() => _AuthorCardState();
}

class _AuthorCardState extends State<AuthorCard> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleImage(
              imageProvider: widget.imageProvider,
              imageRadius: 28.0,
            ),
            const SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.authorName,
                  style: FooderlichTheme.lightTextTheme.headline2,
                ),
                Text(
                  widget.title,
                  style: FooderlichTheme.lightTextTheme.headline3,
                ),
              ],
            ),
          ],
        ),
        IconButton(
          icon: Icon(_isFavorited ? Icons.favorite : Icons.favorite_border),
          iconSize: 30,
          color: Colors.red[400],
          onPressed: () {
            setState(() {
              _isFavorited = !_isFavorited;
            });
          },
        ),
      ],
    );
  }
}
