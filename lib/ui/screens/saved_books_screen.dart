import 'package:buksam_flutter_practicum/logic/blocs/books/books_bloc.dart';
import 'package:buksam_flutter_practicum/ui/screens/summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedBooksScreen extends StatelessWidget {
  const SavedBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Xulosalar Tarixi"),
      ),
      body: BlocBuilder<BooksBloc, BooksState>(
        bloc: context.read<BooksBloc>()..add(GetBooksEvent()),
        builder: (ctx, state) {
          if (state is LoadingBookState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ErrorBookState) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is LoadedBookState) {
            return state.books.isEmpty
                ? const Center(
                    child: Text("Saqlangan kitoblar mavjud emas"),
                  )
                : ListView.builder(
                    itemCount: state.books.length,
                    itemBuilder: (ctx, index) {
                      final book = state.books[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => SummaryScreen(book: book),
                              settings: const RouteSettings(
                                arguments: "saved",
                              ),
                            ),
                          );
                        },
                        title: Text(book.title),
                        subtitle: Text(book.author),
                      );
                    },
                  );
          }

          return const Center(
            child: Text("Saqlangan kitoblar mavjud emas"),
          );
        },
      ),
    );
  }
}
