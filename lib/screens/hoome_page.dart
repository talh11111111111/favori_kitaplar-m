// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:the_books/classes/book_class.dart';
import 'package:the_books/localdatabase/hive_book_menager.dart';
import 'package:the_books/localdatabase/hive_type.dart';
import 'package:the_books/screens/favourite_page.dart';
import 'package:the_books/services/get_book_service.dart';
import 'package:the_books/widgets/book_list_item_list.dart';

final booksServiceProvider = Provider<BooksService>((ref) => BooksService());

final TextEditingController searchController = TextEditingController();

final books = FutureProvider<List<Book>>((ref) async {
  final searchValue = searchController.text;
  return ref.watch(booksServiceProvider).getBooks(searchValue);
});

final favoriteBooksProvider = Provider<List<HiveBook>>((ref) {
  final box = Hive.box<HiveBook>('favorite_books');
  return box.values.toList();
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(books);
    final box = Hive.box<HiveBook>('favorite_books');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 31, 46),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color.fromARGB(255, 10, 31, 46),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 10, 31, 46),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      const Icon(Icons.search, color: Colors.white),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          controller: searchController,
                          decoration: const InputDecoration(
                              labelStyle: TextStyle(color: Colors.white),
                              hintText: 'Kitap Ara...',
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Colors.blue,
                onPressed: () {
                  if (searchController.text.isNotEmpty) {
                    ref.refresh(books);
                  } else if (searchController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Bu alani doldurunuz...'),
                      ),
                    );
                  } else if (searchController.text.length > 500) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Girilen karakter sayisi 500 altinda olmali..'),
                      ),
                    );
                  } else {}
                },
                child: const Text(
                  'Ara',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesPage(),
                ),
              );
            },
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20),
        ],
        title: const Text(
          'Favori Kitaplarim',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: book.when(
        data: (bookList) {
          return ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemCount: bookList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onLongPress: () {
                  HiveBookManager.removeBookFromFavorites(
                      context, bookList[index].id);
                },
                onDoubleTap: () {
                  HiveBookManager.addBookToFavorites(context, bookList[index]);
                },
                child: BookListItem(
                  id: bookList[index].id,
                  title: bookList[index].title,
                  thumbnail: bookList[index].thumbnail,
                  authors: bookList[index]
                      .authors
                      .map((author) => author.toString())
                      .join(', '),
                  publisher: bookList[index].publisher,
                  publishDate: bookList[index].publishDate,
                  pageCount: bookList[index].pageCount,
                  color: box.values
                          .any((element) => element.id == bookList[index].id)
                      ? Colors.white
                      : Colors.blue,
                ),
              );
            },
          );
        },
        error: (error, stack) {
          return const Center(
              child: Icon(
            Icons.menu_book_outlined,
            size: 100,
            color: Colors.white,
          ));
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
