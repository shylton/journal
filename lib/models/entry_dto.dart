import 'package:english_words/english_words.dart';
import 'dart:math' show Random;
import 'package:intl/intl.dart';

class EntryDto {
  String title;
  String body;
  int rating;
  DateTime datetime;

  EntryDto({this.title, this.body, this.rating, this.datetime});

  EntryDto.sampler()
      : title = genWordPairs(1),
        body = genWordPairs(6),
        rating = Random().nextInt(4) + 1,
        datetime = DateTime.now();

  @override
  String toString() => 'EntryDto: $title';

  String get dateString {
    final dtFormat = DateFormat("EEEE, MMMM d, y");
    return dtFormat.format(datetime);
  }

  String get shortDateString {
    final dtFormat = DateFormat("MMM d, y");
    return dtFormat.format(datetime);
  }

  // goes in the database with format that can be used by DateTime.parse()
  String get dbDate {
    final dtFormat = DateFormat("y-MM-d");
    return dtFormat.format(datetime);
  }
}

String genWordPairs(int amount) {
  String result = '';
  generateWordPairs()
      .take(amount)
      .forEach((word) => result = result + '${word.first} ${word.second} ');
  return result.substring(0, result.length); // remove trailing space
}
