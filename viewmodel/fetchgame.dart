
import 'dart:async';
import 'dart:convert';

import 'package:game_app/model/detailgame.dart';
import 'package:game_app/model/game.dart';
import 'package:http/http.dart' as http;

// Mengambil daftar game dari API
Future<List<Game>> fetchGames() async {
  final url = Uri.parse(
    'https://www.freetogame.com/api/games',
  );

  final response = await http
      .get(url)
      .timeout(const Duration(seconds: 20));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);

    return jsonData
        .map((item) => Game.fromJson(item))
        .toList();
  } else {
    throw Exception(
      'Gagal mengambil daftar game. '
          'Status code: ${response.statusCode}',
    );
  }
}

// Mengambil detail game berdasarkan ID
Future<DetailGame> fetchDataFromAPI(int idGame) async {
  final url = Uri.https(
    'www.freetogame.com',
    '/api/game',
    {'id': idGame.toString()},
  );

  final response = await http
      .get(url)
      .timeout(const Duration(seconds: 20));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData =
    json.decode(response.body);

    return DetailGame.fromJson(jsonData);
  } else {
    throw Exception(
      'Gagal mengambil detail game. '
          'Status code: ${response.statusCode}',
    );
  }
}
