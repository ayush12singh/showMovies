import 'package:book_movie/Model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore_for_file: file_names, camel_case_types

class Get_movies {
  var pmovies = <MoviesModel>[];
  var tmovies = <MoviesModel>[];
  var umovies = <MoviesModel>[];
  Future<void> getPMovies() async {
    var apiKEY = "878e707bf8b872d4c89c8b5010a828a4";
    var response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=$apiKEY&language=en-US&page=1"));
    var jsondata = jsonDecode(response.body);

    jsondata["results"].forEach((element) {
      if (element["original_language"] != "ja") {
        MoviesModel moviesModel = MoviesModel(
            originaltitle: element["original_title"],
            originalposter: element["poster_path"]);
        pmovies.add(moviesModel);
      }
    });
  }

  Future<void> getTMovies() async {
    var apiKEY = "878e707bf8b872d4c89c8b5010a828a4";
    var response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKEY&language=en-US&page=1"));
    var jsondata = jsonDecode(response.body);

    jsondata["results"].forEach((element) {
      if (element["original_language"] == "en") {
        MoviesModel moviesModel = MoviesModel(
            originaltitle: element["original_title"],
            originalposter: element["poster_path"]);
        tmovies.add(moviesModel);
      }
    });
  }

  Future<void> getUMovies() async {
    var apiKEY = "878e707bf8b872d4c89c8b5010a828a4";
    var response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKEY&language=en-US&page=1"));
    var jsondata = jsonDecode(response.body);

    jsondata["results"].forEach((element) {
      if (element["original_language"] == "en") {
        MoviesModel moviesModel = MoviesModel(
            originaltitle: element["original_title"],
            originalposter: element["poster_path"]);
        umovies.add(moviesModel);
      }
    });
  }
}
