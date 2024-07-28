import 'package:buksam_flutter_practicum/data/repositories/books_repository.dart';
import 'package:buksam_flutter_practicum/data/repositories/users_repository.dart';
import 'package:buksam_flutter_practicum/data/services/firebase_book_service.dart';
import 'package:buksam_flutter_practicum/firebase_options.dart';
import 'package:buksam_flutter_practicum/logic/blocs/auth/auth_bloc.dart';
import 'package:buksam_flutter_practicum/logic/blocs/books/books_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/app.dart';
import 'data/repositories/auth_repository.dart';
import 'data/services/firebase_auth_service.dart';
import 'data/services/firebase_user_service.dart';
import 'logic/blocs/all_blocs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await dotenv.load(fileName: ".env");

  final firebaseBookService = FirebaseBookService();
  final firebaseAuthService = FirebaseAuthService();
  final firebaseUserService = FirebaseUserService();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => BooksRepository(
            firebaseBookService: firebaseBookService,
          ),
        ),
        RepositoryProvider(
          create: (context) => AuthRepository(
            firebaseAuthService: firebaseAuthService,
          ),
        ),
        RepositoryProvider(
          create: (context) => UsersRepository(
            firebaseUserService: firebaseUserService,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) => AuthBloc(
              ctx.read<AuthRepository>(),
              ctx.read<UsersRepository>(),
            )..add(InitialAuthEvent()),
          ),
          BlocProvider(create: (ctx) => FilePickerBloc()),
          BlocProvider(create: (ctx) => PdfToImageBloc()),
          BlocProvider(
            create: (ctx) => GenerativeAiBloc(
              booksRepository: ctx.read<BooksRepository>(),
              authRepository: ctx.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (ctx) => BooksBloc(
              booksRepository: ctx.read<BooksRepository>(),
            ),
          ),
        ],
        child: const MainApp(),
      ),
    ),
  );
}
