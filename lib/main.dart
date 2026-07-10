import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/pages/onboarding_page.dart';
import 'auth/pages/login_page.dart';
import 'auth/pages/register_page.dart';
import 'movie/pages/beranda_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cek status apakah user sudah login sebelumnya di memori HP
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

  runApp(CineMaxApp(isLoggedIn: isLoggedIn));
}

class CineMaxApp extends StatelessWidget {
  final bool isLoggedIn;

  const CineMaxApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: MaterialApp(
        title: 'CineMax',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          colorScheme: const ColorScheme.dark(primary: Colors.red),
        ),
        // Jika sudah login, langsung lempar ke Beranda, jika belum, mulai dari Onboarding
        initialRoute: isLoggedIn ? '/beranda' : '/',
        routes: {
          '/': (context) => const OnboardingPage(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/beranda': (context) => const BerandaPage(),
        },
      ),
    );
  }
}