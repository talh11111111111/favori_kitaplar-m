import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class HiveBook {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String authors;

  @HiveField(3)
  final String publisher;

  @HiveField(4)
  final String publishDate;

  @HiveField(5)
  final int pageCount;

  @HiveField(6)
  final String thumbnail;

  HiveBook({
    required this.id,
    required this.title,
    required this.authors,
    required this.publisher,
    required this.publishDate,
    required this.pageCount,
    required this.thumbnail,
  });
}

class BookAdapter extends TypeAdapter<HiveBook> {
  @override
  final int typeId = 0;

  @override
  HiveBook read(BinaryReader reader) {
    return HiveBook(
      id: reader.read(),
      title: reader.read(),
      authors: reader.read(),
      publisher: reader.read(),
      publishDate: reader.read(),
      pageCount: reader.read(),
      thumbnail: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveBook obj) {
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.authors);
    writer.write(obj.publisher);
    writer.write(obj.publishDate);
    writer.write(obj.pageCount);
    writer.write(obj.thumbnail);
  }
}
