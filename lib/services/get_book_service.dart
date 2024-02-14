import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_books/classes/book_class.dart';

class BooksService {
  Future<List<Book>> getBooks(String searchTerms) async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$searchTerms&maxResults=40'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'] ?? [];
      return items.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
