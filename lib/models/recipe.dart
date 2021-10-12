class Recipe {
  final String uri;
  final String label;

  Recipe(this.uri, this.label);

  factory Recipe.fromJson(Map<String, Object> json) {
    return Recipe(
      json['uri'] as String,
      json['label'] as String,
    );
  }

  Map<String, Object> toJson() {
    return <String, Object>{'uri': uri, 'label': label};
  }
}
