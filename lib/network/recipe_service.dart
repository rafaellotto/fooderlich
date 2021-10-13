import 'dart:developer';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class RecipeService {
  final String apiAuthority = dotenv.env['EDAMAM_DOMAIN']!;
  final String apiPath = dotenv.env['EDAMAM_ENDPOINT']!;
  final String apiId = dotenv.env['EDAMAM_ID']!;
  final String apiKey = dotenv.env['EDAMAM_KEY']!;

  Future getData(Map<String, String> params) async {
    final url = Uri.https(apiAuthority, apiPath, {
      'app_id': apiId,
      'app_key': apiKey,
      ...params,
    });

    log('Calling url: $url');

    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    if (response.statusCode == 200) {
      return response.body;
    } else {
      log('Response status: ${response.statusCode}');
    }
  }

  Future<Object> getRecipes(String query, int from, int to) async {
    final recipeData =
        await getData({'q': query, 'from': '$from', 'to': '$to'});

    return recipeData;
  }
}
