import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network/recipe_model.dart';
import '../../network/recipe_service.dart';
import '../colors.dart';
import '../recipe_card.dart';
import '../widgets/custom_dropdown.dart';
import 'recipe_details.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  static const String prefSearchKey = 'previousSearches';

  late TextEditingController searchTextController;
  final ScrollController _scrollController = ScrollController();
  List<Hit> currentSearchList = [];
  List<String> previousSearches = <String>[];
  bool hasMore = false;
  bool loading = false;
  bool inErrorState = false;
  String? nextUrl = null;

  @override
  void initState() {
    super.initState();

    getPreviousSearches();

    searchTextController = TextEditingController(text: '');
    _scrollController.addListener(() {
      final triggerFetchMoreSize =
          0.7 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        if (hasMore && !loading && !inErrorState) {
          setState(() {
            loading = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  void savePreviousSearches() async {
    final value = searchTextController.text;

    if (!previousSearches.contains(value) && value.isNotEmpty) {
      previousSearches.add(value.trim());

      final prefs = await SharedPreferences.getInstance();

      prefs.setStringList(prefSearchKey, previousSearches);
    }
  }

  void getPreviousSearches() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(prefSearchKey)) {
      final searches = prefs.getStringList(prefSearchKey);

      if (searches != null) {
        previousSearches = searches;
      }
    }
  }

  void startSearch(String value) {
    log('Starting search for $value');

    setState(() {
      nextUrl = null;
      currentSearchList.clear();

      savePreviousSearches();
    });
  }

  Future<RecipeSearch> getRecipeData(String query, String? nextUrl) async {
    log('Querying $query');

    final recipeJson = await RecipeService().getRecipes(query, nextUrl);

    final recipeMap = json.decode(recipeJson);

    return RecipeSearch.fromJson(recipeMap);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchCard(),
          _buildRecipeLoader(context),
        ],
      ),
    );
  }

  Widget _buildSearchCard() {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                        ),
                        autofocus: false,
                        textInputAction: TextInputAction.done,
                        onSubmitted: startSearch,
                        controller: searchTextController,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: lightGrey,
                    ),
                    onSelected: (String value) {
                      searchTextController.text = value;
                      startSearch(searchTextController.text);
                    },
                    itemBuilder: (BuildContext context) {
                      return previousSearches
                          .map<CustomDropdownMenuItem<String>>((String value) {
                        return CustomDropdownMenuItem<String>(
                          text: value,
                          value: value,
                          callback: () {
                            setState(() {
                              previousSearches.remove(value);
                              Navigator.pop(context);
                            });
                          },
                        );
                      }).toList();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      startSearch(searchTextController.text);

                      final currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeLoader(BuildContext context) {
    log('Recipes: ${currentSearchList.length}');

    if (searchTextController.text.length < 3) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Search at least 3 characters'),
      );
    }

    return FutureBuilder<RecipeSearch>(
      future: getRecipeData(
        searchTextController.text.trim(),
        nextUrl,
      ),
      builder: (context, snapshot) {
        log('Recipes: ${currentSearchList.length}');

        if (snapshot.connectionState != ConnectionState.done &&
            currentSearchList.isEmpty) {
          return const Expanded(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        loading = false;
        final query = snapshot.data;
        inErrorState = false;

        if (query != null) {
          if (currentSearchList.length < query.to) {
            log('Adding items to list');
            currentSearchList.addAll(query.hits);
          }

          nextUrl = query.links.next?.href;
          log('Next url: $nextUrl');

          hasMore = query.to < query.count;
          log('Has more? $hasMore');
        }

        return _buildRecipeList(context, currentSearchList);
      },
    );
  }

  Widget _buildRecipeList(BuildContext context, List<Hit> hits) {
    return Flexible(
      child: ListView.builder(
          controller: _scrollController,
          itemCount: hits.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildRecipeCard(context, hits, index);
          }),
    );
  }

  Widget _buildRecipeCard(
    BuildContext topLevelContext,
    List<Hit> hits,
    int index,
  ) {
    final recipe = hits[index].recipe;

    return GestureDetector(
      onTap: () {
        Navigator.push(topLevelContext, MaterialPageRoute(
          builder: (context) {
            return const RecipeDetails();
          },
        ));
      },
      child: recipeCard(recipe),
    );
  }
}
