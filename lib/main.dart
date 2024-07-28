import 'package:buksam_flutter_practicum/data/repositories/books_repository.dart';
import 'package:buksam_flutter_practicum/data/services/firebase_book_service.dart';
import 'package:buksam_flutter_practicum/firebase_options.dart';
import 'package:buksam_flutter_practicum/logic/blocs/books/books_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/app.dart';
import 'logic/blocs/all_blocs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await dotenv.load(fileName: ".env");

  final firebaseBookService = FirebaseBookService();
  runApp(
    RepositoryProvider(
      create: (context) => BooksRepository(
        firebaseBookService: firebaseBookService,
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (ctx) {
            return FilePickerBloc();
          }),
          BlocProvider(create: (ctx) {
            return PdfToImageBloc();
          }),
          BlocProvider(create: (ctx) {
            return GenerativeAiBloc();
          }),
          BlocProvider(create: (ctx) {
            return BooksBloc(booksRepository: ctx.read<BooksRepository>());
          }),
        ],
        child: const MainApp(),
      ),
    ),
  );
}
