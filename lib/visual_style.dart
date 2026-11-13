import 'package:flutter/material.dart';

abstract final class AppColors {
  static const green = Color(0xff0d5546);
  static const forest = Color(0xff0b453a);
  static const paper = Color(0xfff7f3ea);
  static const card = Color(0xfffffcf6);
  static const canvas = Color(0xffe5e8df);
  static const ink = Color(0xff172822);
  static const muted = Color(0xff53655b);
  static const line = Color(0xffe2dbce);
  static const gold = Color(0xfff3cf81);
  static const mint = Color(0xffdcece1);
}

void showUnavailable(BuildContext context, String feature) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text('$feature belum tersedia di versi ini.'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
}

class PageHeading extends StatelessWidget {
  const PageHeading({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.forest,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.card,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Icon(icon, color: AppColors.gold),
        ],
      ),
    );
  }
}
