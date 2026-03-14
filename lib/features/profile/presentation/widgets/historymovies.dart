import 'package:flutter/material.dart';

class HistoryMovies extends StatelessWidget {
  const HistoryMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Text(
          "History Coming Soon",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}