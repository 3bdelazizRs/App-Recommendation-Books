import 'dart:convert';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
    String message;
    CommentClass comment;

    Comment({
        required this.message,
        required this.comment,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        message: json["message"],
        comment: CommentClass.fromJson(json["comment"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "comment": comment.toJson(),
    };
}

class CommentClass {
    String author;
    String content;
    String bookId;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    CommentClass({
        required this.author,
        required this.content,
        required this.bookId,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory CommentClass.fromJson(Map<String, dynamic> json) => CommentClass(
        author: json["author"],
        content: json["content"],
        bookId: json["book_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "author": author,
        "content": content,
        "book_id": bookId,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
