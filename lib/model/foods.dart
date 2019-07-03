class FoodList {
  final List<Food> foods;

  FoodList({
    this.foods
  });

  factory FoodList.fromJson(Map<String, dynamic> json) {
    var list = json['meals'] as List;
    List<Food> foodList = list.map((i) => Food.fromJson(i)).toList();

    return FoodList(
      foods: foodList
    );
  }
}

class Food {
  final String id;
  final String meal;
  final String image;

  Food({this.id, this.meal, this.image});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['idMeal'],
      meal: json['strMeal'],
      image: json['strMealThumb']
    );
  }
}

class FoodArguments {
  final String id;

  FoodArguments(this.id);
}

class FoodDetail {
  final String id;
  final String meal;
  final String image;
  final String instructions;
  final String tags;
  final String ingredients;

  FoodDetail({
    this.id,
    this.meal,
    this.image,
    this.instructions,
    this.tags,
    this.ingredients,
  });

  factory FoodDetail.fromJson(Map<String, dynamic> json) {

    return FoodDetail(
        id: json['idMeal'],
        meal: json['strMeal'],
        image: json['strMealThumb'],
        instructions: json['strInstructions'],
        tags: json['strTags'] != null ? json['strTags'] : "No Tag",
        ingredients: "- ${json['strIngredient1']} ${json['strMeasure1']}"
            "\n- ${json['strIngredient2']} ${json['strMeasure2']}"
            "\n- ${json['strIngredient3']} ${json['strMeasure3']}"
            "\n- ${json['strIngredient4']} ${json['strMeasure4']}"
            "\n- ${json['strIngredient5']} ${json['strMeasure5']}"
            "\n- ${json['strIngredient6']} ${json['strMeasure6']}"
            "\n- ${json['strIngredient7']} ${json['strMeasure7']}"
            "\n- ${json['strIngredient8']} ${json['strMeasure8']}"
    );
  }
}
