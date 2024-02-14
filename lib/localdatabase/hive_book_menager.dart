import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:the_books/localdatabase/hive_type.dart';
import 'package:the_books/classes/book_class.dart';

class HiveBookManager {
  static void addBookToFavorites(BuildContext context, Book book) {
    final box = Hive.box<HiveBook>('favorite_books');
    final existingBookIndex =
        box.values.toList().indexWhere((element) => element.id == book.id);
    if (existingBookIndex == -1) {
      final hiveBook = HiveBook(
        id: book.id,
        title: book.title,
        authors: book.authors.join(', '),
        publisher: book.publisher,
        publishDate: book.publishDate,
        pageCount: book.pageCount,
        thumbnail: book.thumbnail,
      );
      box.add(hiveBook);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kitap Favorilere Eklendi.'),
        ),
      );
    } else {}
  }

  static void removeBookFromFavorites(BuildContext context, String bookId) {
    final box = Hive.box<HiveBook>('favorite_books');
    final existingBookIndex =
        box.values.toList().indexWhere((element) => element.id == bookId);
    if (existingBookIndex != -1) {
      box.deleteAt(existingBookIndex);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kitap Favorilerden Silindi.'),
        ),
      );
    } else {}
  }
}
