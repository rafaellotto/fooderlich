// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeSearch _$RecipeSearchFromJson(Map<String, dynamic> json) => RecipeSearch(
      from: json['from'] as int,
      to: json['to'] as int,
      count: json['count'] as int,
      links: Links.fromJson(json['_links'] as Map<String, dynamic>),
      hits: (json['hits'] as List<dynamic>)
          .map((e) => Hit.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecipeSearchToJson(RecipeSearch instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'count': instance.count,
      '_links': instance.links,
      'hits': instance.hits,
    };

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      next: json['next'] == null
          ? null
          : Link.fromJson(json['next'] as Map<String, dynamic>),
      self: json['self'] == null
          ? null
          : Link.fromJson(json['self'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'self': instance.self,
      'next': instance.next,
    };

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
      href: json['href'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'href': instance.href,
      'title': instance.title,
    };

Hit _$HitFromJson(Map<String, dynamic> json) => Hit(
      recipe: Recipe.fromJson(json['recipe'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HitToJson(Hit instance) => <String, dynamic>{
      'recipe': instance.recipe,
    };

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      label: json['label'] as String,
      image: json['image'] as String,
      url: json['url'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => Ingredients.fromJson(e as Map<String, dynamic>))
          .toList(),
      calories: (json['calories'] as num).toDouble(),
      totalWeight: (json['totalWeight'] as num).toDouble(),
      totalTime: (json['totalTime'] as num).toDouble(),
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'label': instance.label,
      'image': instance.image,
      'url': instance.url,
      'ingredients': instance.ingredients,
      'calories': instance.calories,
      'totalWeight': instance.totalWeight,
      'totalTime': instance.totalTime,
    };

Ingredients _$IngredientsFromJson(Map<String, dynamic> json) => Ingredients(
      text: json['text'] as String?,
      quantity: (json['quantity'] as num).toDouble(),
      measure: json['measure'] as String?,
      food: json['food'] as String?,
      weight: (json['weight'] as num).toDouble(),
      foodCategory: json['foodCategory'] as String?,
      foodId: json['foodId'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$IngredientsToJson(Ingredients instance) =>
    <String, dynamic>{
      'text': instance.text,
      'quantity': instance.quantity,
      'measure': instance.measure,
      'food': instance.food,
      'weight': instance.weight,
      'foodCategory': instance.foodCategory,
      'foodId': instance.foodId,
      'image': instance.image,
    };
