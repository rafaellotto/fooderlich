import 'package:flutter/material.dart';
import 'package:fooderlich/components/recipe_thumbnail.dart';
import 'package:fooderlich/models/simple_recipe.dart';

class RecipesGridView extends StatelessWidget {
  final List<SimpleRecipe> recipes;

  const RecipesGridView({
    Key? key,
    required this.recipes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
      ),
      child: GridView.builder(
        itemCount: recipes.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 350,
        ),
        itemBuilder: (context, index) {
          final simpleRecipe = recipes[index];

          return RecipeThumbnail(recipe: simpleRecipe);
        },
      ),
    );
  }
}
