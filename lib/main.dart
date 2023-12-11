import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:motor/TambahDataPage.dart';
import 'package:motor/favorite.dart';
import 'package:motor/firebase_options.dart';
import 'package:motor/home.dart';
import 'package:motor/login.dart';
import 'package:motor/profile.dart';
import 'package:motor/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFE1EFFF), // Warna latar belakang
      ),
      initialRoute: '/splash', // Tentukan rute awal
      routes: {
        // Halaman login
        '/login': (context) => Login(),
        '/splash': (context) => SplashScreen(),
        '/home': (context) => MyBottomNavBar(), // Halaman home
        // '/admin': (context) => ButtomAdmin()
        // Definisikan rute-rute lainnya di sini
      },
    );
  }
}

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    favorite_page(),
    // TambahDataPage(),
    Profile(),
    // Home(),
    // Home(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: _children[_currentIndex]),
        bottomNavigationBar: GNav(
          gap: 8,
          backgroundColor: Colors.white,
          color: const Color.fromARGB(255, 51, 77, 169),
          activeColor: Color.fromARGB(255, 51, 77, 169),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          tabBackgroundColor: Color(0xFFE1EFFF),
          tabMargin: EdgeInsets.symmetric(vertical: 17, horizontal: 10),
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.favorite,
              text: 'Favorite',
            ),
            // GButton(
            //   icon: Icons.newspaper,
            //   text: 'Input',
            // ),
            GButton(
              icon: Icons.account_circle,
              text: 'Profile',
            ),
          ],
        ));
  }
}
