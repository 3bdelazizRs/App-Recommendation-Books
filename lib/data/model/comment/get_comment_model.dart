// To parse this JSON data, do
//
//     final getComments = getCommentsFromJson(jsonString);

import 'dart:convert';

GetComments getCommentsFromJson(String str) => GetComments.fromJson(json.decode(str));

String getCommentsToJson(GetComments data) => json.encode(data.toJson());

class GetComments {
    List<Comment> comments;

    GetComments({
        required this.comments,
    });

    factory GetComments.fromJson(Map<String, dynamic> json) => GetComments(
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    };
}

class Comment {
    int id;
    int bookId;
    String author;
    String content;
    DateTime createdAt;
    DateTime updatedAt;

    Comment({
        required this.id,
        required this.bookId,
        required this.author,
        required this.content,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        bookId: json["book_id"],
        author: json["author"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "author": author,
        "content": content,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
