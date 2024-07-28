import 'package:buksam_flutter_practicum/logic/blocs/auth/auth_bloc.dart';
import 'package:buksam_flutter_practicum/ui/screens/saved_books_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profil'),
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Alisher Uzoqov',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ProfileOption(
                  title: 'Sevimli Kitoblar',
                  icon: Icons.favorite,
                  onTap: () {
                    // Navigate to favorite books page
                  },
                ),
                ProfileOption(
                  title: 'Tarix (xulosa)',
                  icon: Icons.history,
                  onTap: () {
                    // Navigate to summary history page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SavedBooksScreen(),
                      ),
                    );
                  },
                ),
                ProfileOption(
                  title: 'Profilni sozlash',
                  icon: Icons.settings,
                  onTap: () {
                    // Navigate to profile settings page
                  },
                ),
                const Spacer(),
                ProfileOption(
                  title: 'Chiqish',
                  icon: Icons.logout,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  onTap: () {
                    context.read<AuthBloc>().add(LogoutEvent());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final TextStyle? textStyle;

  const ProfileOption({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Text(
        title,
        style: textStyle ??
            const TextStyle(
              fontSize: 18,
            ),
      ),
    );
  }
}
