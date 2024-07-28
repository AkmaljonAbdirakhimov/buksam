import 'package:buksam_flutter_practicum/data/models/book.dart';
import 'package:buksam_flutter_practicum/logic/blocs/books/books_bloc.dart';
import 'package:buksam_flutter_practicum/ui/widgets/book_info_dialog.dart';
import 'package:buksam_flutter_practicum/ui/widgets/markdown_with_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryScreen extends StatelessWidget {
  final Book book;
  const SummaryScreen({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    final isSaved = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => BookInfoDialog(book: book),
              );
            },
            icon: const Icon(Icons.info),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: MarkdownWithFooter(
              markdownData: book.summary,
              footer: const Icon(Icons.star),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilledButton.icon(
                  onPressed: () {},
                  label: const Text("Audio"),
                  icon: const Icon(Icons.play_arrow),
                ),
                if (isSaved == null)
                  BlocBuilder<BooksBloc, BooksState>(
                    builder: (context, booksState) {
                      if (booksState is LoadingBookState) {
                        return const CircularProgressIndicator();
                      }

                      return FilledButton.icon(
                        onPressed: () {
                          context.read<BooksBloc>().add(AddBookEvent(book));
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        label: const Text("Saqlash"),
                        icon: const Icon(Icons.bookmark),
                      );
                    },
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
