import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:radio_project/models/music_data_response.dart';

class ApiService {
  Future<List<MusicDataResponse>> getAllFetchMusicData() async {
    const url = "https://storage.googleapis.com/uamp/catalog.json";
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        final result = json['music'] as List<dynamic>;
        final musicList = result.map((e) {
          return MusicDataResponse.fromJson(e);
        }).toList();

        debugPrint(response.body.toString());
        return musicList;
      } else {
        throw Exception("Data fetch failed: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Data fetch failed: $e");
    }
  }
}
