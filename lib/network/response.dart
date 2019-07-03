import 'package:http/http.dart' as http;
import 'package:food_recipes/model/foods.dart';
import 'dart:convert';

class Response {

  final _baseUrl = "https://www.themealdb.com/api/json/v1/1";

  Future<List<Food>> fetchFood(String endpoint) async {
    String dataURL = "$_baseUrl/filter.php?c=$endpoint";
    final response = await http.get(dataURL);

    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      var foods = List<Food>();
//      FoodList foodList = FoodList.fromJson(responseJson);

      for (var food in responseJson['meals']) {
        foods.add(Food.fromJson(food));
      }
      return foods;
    } else {
      return null;
    }

  }

  fetchFoodDetail(String id) async {
    String dataURL = "$_baseUrl/lookup.php?i=$id";
    final response = await http.get(dataURL);

    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      var detail = (responseJson['meals'] as List)
          .map((f) => FoodDetail.fromJson(f))
          .toList();
      return detail;
    } else {
      return null;
    }
  }
}