import 'package:english_words/english_words.dart';
import 'dart:math' show Random;

class EntryDto {
  final int id;
  final String title;
  final String body;
  final int rating;
  final DateTime date;

  EntryDto({this.id, this.title, this.body, this.rating, this.date});

  EntryDto.sampler()
      : id = Random().nextInt(99999),
        title = genWordPairs(1),
        body = genWordPairs(6),
        rating = Random().nextInt(6),
        date = DateTime.now();

  @override
  String toString() => 'Title: $title | Body: $body';
}

String genWordPairs(int amount) {
  String result = '';
  generateWordPairs()
      .take(amount)
      .forEach((word) => result = result + '${word.first} ${word.second} ');
  return result.substring(0, result.length); // remove trailing space
}
