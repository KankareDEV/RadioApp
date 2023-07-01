import 'package:flutter/material.dart';

class MusicDataResponse {
  late String id;
  late String title;
  late String album;
  late String artist;
  late String genre;
  late String source;
  late String image;
  late int trackNumber;
  late int totalTrackCount;
  late int duration;
  late String site;

  MusicDataResponse({
    required this.id,
    required this.title,
    required this.album,
    required this.artist,
    required this.genre,
    required this.source,
    required this.image,
    required this.trackNumber,
    required this.totalTrackCount,
    required this.duration,
    required this.site,
  });

  factory MusicDataResponse.fromJson(Map<String, dynamic> json) {
    return MusicDataResponse(
      id: json["id"],
      title: json['title'],
      album: json['album'],
      artist: json['artist'],
      genre: json['genre'],
      source: json['source'],
      image: json['image'],
      trackNumber: json['trackNumber'],
      totalTrackCount: json['totalTrackCount'],
      duration: json['duration'],
      site: json['site'],
    );
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'id': id,
      'title': title,
      'album': album,
      'artist': artist,
      'genre': genre,
      'source': source,
      'image': image,
      'trackNumber': trackNumber,
      'totalTrackCount': totalTrackCount,
      'duration': duration,
      'site': site,
    });
  }
}
