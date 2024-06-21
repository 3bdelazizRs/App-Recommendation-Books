
class BookRecommendation {
  final String title;
  final String author;
  final String imageUrl;
  final String isbn;


  BookRecommendation({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.isbn,

  });

  factory BookRecommendation.fromJson(Map<String, dynamic> json) {
    
    return BookRecommendation(
      title: json['title'],
      author: json['author'],
      imageUrl: json['image_url'],
      isbn: json['isbn'],
    
    );
  }
}
