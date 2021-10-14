import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class RecipeService {
  final String apiDomain = dotenv.env['EDAMAM_DOMAIN']!;
  final String apiEndpoint = dotenv.env['EDAMAM_ENDPOINT']!;
  final String apiId = dotenv.env['EDAMAM_ID']!;
  final String apiKey = dotenv.env['EDAMAM_KEY']!;

  Future<dynamic> getRecipes(String query, String? useThisUrl) async {
    var url = Uri.https(apiDomain, apiEndpoint, {
      'app_id': apiId,
      'app_key': apiKey,
      'type': 'public',
      'q': query,
      'field': [
        'q',
        'label',
        'image',
        'ingredients',
        'calories',
        'url',
        'totalWeight',
        'totalTime',
      ],
    });

    if (useThisUrl != null) {
      url = Uri.parse(useThisUrl);
    }

    log('Calling url: $url');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      log('Response status: ${response.statusCode}');
    }
  }
}
