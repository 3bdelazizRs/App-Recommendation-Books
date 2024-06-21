// To parse this JSON data, do
//
//     final books = booksFromJson(jsonString);

import 'dart:convert';

Books booksFromJson(String str) => Books.fromJson(json.decode(str));

String booksToJson(Books data) => json.encode(data.toJson());

class Books {
    List<Datum>? data;
    int? page;
    int? perPage;
    int? total;
    int? totalPages;

    Books({
         this.data,
         this.page,
         this.perPage,
         this.total,
         this.totalPages,
    });

    factory Books.fromJson(Map<String, dynamic> json) => Books(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
    };
}

class Datum {
    String bookAuthor;
    String bookTitle;
    String isbn;
    String imageUrlL;
    String imageUrlM;
    String imageUrlS;
    String publisher;
    int yearOfPublication;

    Datum({
        required this.bookAuthor,
        required this.bookTitle,
        required this.isbn,
        required this.imageUrlL,
        required this.imageUrlM,
        required this.imageUrlS,
        required this.publisher,
        required this.yearOfPublication,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bookAuthor: json["Book-Author"],
        bookTitle: json["Book-Title"],
        isbn: json["ISBN"],
        imageUrlL: json["Image-URL-L"],
        imageUrlM: json["Image-URL-M"],
        imageUrlS: json["Image-URL-S"],
        publisher: json["Publisher"],
        yearOfPublication: json["Year-Of-Publication"],
    );

    Map<String, dynamic> toJson() => {
        "Book-Author": bookAuthor,
        "Book-Title": bookTitle,
        "ISBN": isbn,
        "Image-URL-L": imageUrlL,
        "Image-URL-M": imageUrlM,
        "Image-URL-S": imageUrlS,
        "Publisher": publisher,
        "Year-Of-Publication": yearOfPublication,
    };
}
