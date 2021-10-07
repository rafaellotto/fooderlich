import 'package:flutter/material.dart';
import 'package:fooderlich/views/pages/home.dart';

class Fooderlich extends StatelessWidget {
  // 2
  const Fooderlich({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Create theme
    // TODO: Apply Home widget
    // 3
    return const MaterialApp(
      // TODO: Add theme
      title: 'Fooderlich',
      // 4
      home: Home(),
    );
  }
}
