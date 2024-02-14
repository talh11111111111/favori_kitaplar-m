class Book {
  final String id;
  final String title;
  final String subtitle;
  final String publisher;
  final String publishDate;
  final int pageCount;
  final String thumbnail;
  final List<String> authors;

  Book({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.publisher,
    required this.publishDate,
    required this.pageCount,
    required this.thumbnail,
    required this.authors,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'];

    return Book(
      id: json['id'] ?? 'id yok',
      title: volumeInfo['title'] ?? 'Bilinmiyor',
      subtitle: volumeInfo['subtitle'] ?? '',
      publisher: volumeInfo['publisher'] ?? '',
      publishDate: volumeInfo['publishedDate'] ?? '',
      pageCount: volumeInfo['pageCount'] ?? 0,
      thumbnail: volumeInfo['imageLinks'] != null &&
              volumeInfo['imageLinks']['thumbnail'] != null
          ? volumeInfo['imageLinks']['thumbnail']
          : 'https://smartmobilestudio.com/wp-content/uploads/2012/06/leather-book-preview.png',
      authors: List<String>.from(volumeInfo['authors'] ?? []),
    );
  }
}
