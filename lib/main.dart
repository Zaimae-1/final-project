import 'package:flutter/material.dart';

import 'home_page.dart';
import 'quran_page.dart';
import 'visual_style.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teman Ibadah',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.green,
          primary: AppColors.green,
          surface: AppColors.paper,
          onSurface: AppColors.ink,
        ),
        scaffoldBackgroundColor: AppColors.paper,
        fontFamily: 'Roboto',
      ),
      home: const WorshipShell(),
    );
  }
}

class WorshipShell extends StatefulWidget {
  const WorshipShell({super.key});

  @override
  State<WorshipShell> createState() => _WorshipShellState();
}

class _WorshipShellState extends State<WorshipShell> {
  int _selected = 0;

  void openDestination(int index) {
    if (index >= 2) {
      showUnavailable(context, index == 2 ? 'Kiblat' : 'Lainnya');
      return;
    }
    setState(() => _selected = index);
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.canvas,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Scaffold(
            body: SafeArea(
              bottom: false,
              child: IndexedStack(
                index: _selected,
                children: [
                  HomePage(onNavigate: openDestination),
                  const QuranPage(),
                ],
              ),
            ),
            bottomNavigationBar: NavigationBar(
              height: 66,
              selectedIndex: _selected,
              backgroundColor: AppColors.card,
              indicatorColor: AppColors.mint,
              onDestinationSelected: openDestination,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Beranda',
                ),
                NavigationDestination(
                  icon: Icon(Icons.menu_book_outlined),
                  label: 'Al-Qur’an',
                ),
                NavigationDestination(
                  icon: Icon(Icons.explore_outlined),
                  label: 'Kiblat',
                ),
                NavigationDestination(
                  icon: Icon(Icons.grid_view_rounded),
                  label: 'Lainnya',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
