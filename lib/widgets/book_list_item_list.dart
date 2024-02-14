import 'package:flutter/material.dart';

class BookListItem extends StatelessWidget {
  final String id;
  final String title;
  final String thumbnail;
  final String? authors;
  final String? publisher;
  final String? publishDate;
  final int? pageCount;
  final Color color;

  const BookListItem({
    Key? key,
    required this.title,
    required this.thumbnail,
    this.publishDate,
    this.pageCount,
    this.authors,
    this.publisher,
    required this.id,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasAuthors = authors != null && authors!.isNotEmpty;
    bool hasPublisher = publisher != null && publisher!.isNotEmpty;
    bool hasPublishDate = publishDate != null && publishDate!.isNotEmpty;
    bool hasPageCount = pageCount != null;

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 10, 31, 46),
        border: Border.all(width: 1, color: color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Image.network(
              thumbnail,
              fit: BoxFit.cover,
              height: 180,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            flex: 6,
            child: SizedBox(
              height: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                    endIndent: 5,
                    thickness: 0.5,
                  ),
                  if (hasAuthors)
                    Text(
                      'Authors: $authors',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  if (hasPublisher)
                    Text(
                      'Publisher: $publisher',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (hasPublishDate)
                        Text(
                          'Published at: $publishDate',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      if (hasPageCount)
                        Text(
                          'Pages: $pageCount',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
