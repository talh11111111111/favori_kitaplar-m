import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:the_books/localdatabase/hive_type.dart';
import 'package:the_books/widgets/book_list_item_list.dart';

final favoriteBooksProvider = Provider.autoDispose<Box>((ref) {
  return Hive.box<HiveBook>('favorite_books');
});

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteBooksBox = ref.watch(favoriteBooksProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 31, 46),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 10, 31, 46),
        title: const Text(
          'Favori Kitaplar',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ValueListenableBuilder<Box>(
        valueListenable: favoriteBooksBox.listenable(),
        builder: (context, box, _) {
          final favoriteBooks = box.values.toList().cast<HiveBook>();
          if (favoriteBooks.isEmpty) {
            return const Center(
              child: Text(
                'Favori listeniz boş',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            itemCount: favoriteBooks.length,
            itemBuilder: (context, index) {
              final book = favoriteBooks[index];
              return GestureDetector(
                  onLongPress: () {
                    ref.read(favoriteBooksProvider).deleteAt(index);
                  },
                  child: BookListItem(
                    title: book.title,
                    thumbnail: book.thumbnail,
                    authors: book.authors.toString(),
                    publisher: book.publisher,
                    publishDate: book.publishDate,
                    pageCount: book.pageCount,
                    id: book.id,
                    color: Colors.white,
                  ));
            },
          );
        },
      ),
    );
  }
}
