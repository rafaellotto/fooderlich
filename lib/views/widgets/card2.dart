import 'package:flutter/material.dart';
import 'package:fooderlich/fooderlich_theme.dart';
import 'package:fooderlich/views/widgets/author_card.dart';

class Card2 extends StatelessWidget {
  const Card2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      // 1
      child: Container(
        padding: const EdgeInsets.all(16.0),
        constraints: const BoxConstraints.expand(
          width: 350,
          height: 450,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/mag5.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        // 2
        child: Column(
          children: [
            const AuthorCard(
              authorName: 'Mike Katz',
              title: 'Smoothie Connoisseur',
              imageProvider: AssetImage('assets/author_katz.jpeg'),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Text(
                      'Recipe',
                      style: FooderlichTheme.lightTextTheme.headline1,
                    ),
                  ),
                  Positioned(
                    bottom: 70.0,
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Text(
                        'Smoothies',
                        style: FooderlichTheme.lightTextTheme.headline1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
