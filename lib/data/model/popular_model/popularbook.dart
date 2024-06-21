// To parse this JSON data, do
//
//     final popularbook = popularbookFromJson(jsonString);

import 'dart:convert';

List<Popularbook> popularbookFromJson(String str) => List<Popularbook>.from(
    json.decode(str).map((x) => Popularbook.fromJson(x)));

String popularbookToJson(List<Popularbook> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Popularbook {
  String bookAuthor;
  String bookTitle;
  String isbn;
  String imageUrlM;
  double avgRating;
  int numRatings;

  Popularbook({
    required this.bookAuthor,
    required this.bookTitle,
    required this.isbn,
    required this.imageUrlM,
    required this.avgRating,
    required this.numRatings,
  });

  factory Popularbook.fromJson(Map<String, dynamic> json) => Popularbook(
        bookAuthor: json["Book-Author"],
        bookTitle: json["Book-Title"],
        isbn: json['isbn'],
        imageUrlM: json["Image-URL-M"],
        avgRating: json["avg_rating"]?.toDouble(),
        numRatings: json["num_ratings"],
      );

  Map<String, dynamic> toJson() => {
        "Book-Author": bookAuthor,
        "Book-Title": bookTitle,
        "Image-URL-M": imageUrlM,
        'isbn': isbn,
        "avg_rating": avgRating,
        "num_ratings": numRatings,
      };
}
