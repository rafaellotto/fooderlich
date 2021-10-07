import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: Style the title
      appBar: AppBar(title: const Text('Fooderlich')),
      // TODO: Style the body text
      body: const Center(child: Text('Let\'s get cooking 👩‍🍳')),
    );
  }
}
