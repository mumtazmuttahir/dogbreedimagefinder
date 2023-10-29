//Singleton class
import 'dart:convert';
import 'dart:math';

import 'package:dogbreedimagefinder/domain/entities/breed.dart';
import 'package:dogbreedimagefinder/domain/entities/dog_breeds.dart';
import 'package:dogbreedimagefinder/domain/entities/random_image_by_breed.dart';
import 'package:http/http.dart' as http;

class DogApi {
  static final DogApi _singleton = DogApi._interface();

  factory DogApi() {
    return _singleton;
  }

  DogApi._interface();

  List<String> dogBreedList = [];

  Future<RandomBreed> fetchRandomImage() async {
    final response =
        await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));

    if (response.statusCode == 200) {
      return RandomBreed.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<String>> fetchAllDogBreeds() async {
    final response =
        await http.get(Uri.parse('https://dog.ceo/api/breeds/list/all'));

    if (response.statusCode == 200) {
      dogBreedList =
          DogBreeds.fromJson(jsonDecode(response.body) as Map<String, dynamic>)
              .message
              .keys
              .toList();
      return dogBreedList;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<String> fetchRandomImageByBreed(String breedName) async {
    final response = await http
        .get(Uri.parse('https://dog.ceo/api/breed/$breedName/images'));

    if (response.statusCode == 200) {
      List<String>? strings = RandomImageByBreed.fromJson(
              jsonDecode(response.body) as Map<String, dynamic>)
          .message;
      var range = Random();
      int nextNumber = range.nextInt(strings!.length);
      return strings[nextNumber];
    } else {
      throw Exception('Failed to load album');
    }
  }
}
