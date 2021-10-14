import 'package:json_annotation/json_annotation.dart';

part 'recipe_model.g.dart';

String getCalories(double? calories) {
  if (calories == null) {
    return '0 KCAL';
  }
  return calories.floor().toString() + ' KCAL';
}

String getWeight(double? weight) {
  if (weight == null) {
    return '0g';
  }
  return weight.floor().toString() + 'g';
}

@JsonSerializable()
class RecipeSearch {
  int from;
  int to;
  int count;
  @JsonKey(name: '_links')
  Links links;
  List<Hit> hits;

  RecipeSearch({
    required this.from,
    required this.to,
    required this.count,
    required this.links,
    required this.hits,
  });

  factory RecipeSearch.fromJson(Map<String, dynamic> json) =>
      _$RecipeSearchFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeSearchToJson(this);
}

@JsonSerializable()
class Links {
  Link? self;
  Link? next;

  Links({
    this.next,
    this.self,
  });

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

@JsonSerializable()
class Link {
  String? href;
  String? title;

  Link({
    this.href,
    this.title,
  });

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  Map<String, dynamic> toJson() => _$LinkToJson(this);
}

@JsonSerializable()
class Hit {
  @JsonKey(name: 'recipe')
  Recipe recipe;

  Hit({
    required this.recipe,
  });

  factory Hit.fromJson(Map<String, dynamic> json) => _$HitFromJson(json);

  Map<String, dynamic> toJson() => _$HitToJson(this);
}

@JsonSerializable()
class Recipe {
  String label;
  String image;
  String url;
  List<Ingredients> ingredients;
  double calories;
  double totalWeight;
  double totalTime;

  Recipe({
    required this.label,
    required this.image,
    required this.url,
    required this.ingredients,
    required this.calories,
    required this.totalWeight,
    required this.totalTime,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}

@JsonSerializable()
class Ingredients {
  String? text;
  double quantity;
  String? measure;
  String? food;
  double weight;
  String? foodCategory;
  String? foodId;
  String? image;

  Ingredients({
    this.text,
    required this.quantity,
    this.measure,
    this.food,
    required this.weight,
    this.foodCategory,
    this.foodId,
    this.image,
  });

  factory Ingredients.fromJson(Map<String, dynamic> json) =>
      _$IngredientsFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientsToJson(this);
}
