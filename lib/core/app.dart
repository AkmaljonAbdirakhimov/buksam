import 'package:buksam_flutter_practicum/ui/screens/auth_screen.dart';
import 'package:buksam_flutter_practicum/ui/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../logic/blocs/auth/auth_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.amber,
        ),
        home: BlocSelector<AuthBloc, AuthState, User?>(
          bloc: context.read<AuthBloc>()..add(WatchAuthEvent()),
          selector: (state) => state.user,
          builder: (context, user) {
            return user == null ? const AuthScreen() : const MainScreen();
          },
        ),
      ),
    );
  }
}
