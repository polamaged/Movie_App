import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movies_app/core/route_manager/route_manager.dart';
import 'package:movies_app/features/home/presentation/widgets/details_movie_card.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.rating, required this.imagePath, required this.movieID});

  final double rating;
  final String imagePath;
  final int movieID ;
  @override

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteManager.detailsMovie,arguments: movieID);
        log('Navigating to details of movie ID: $movieID');
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          children: [
            Image.network(
              imagePath,
              height: MediaQuery.of(context).size.height * 0.4,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  color: Colors.grey[300],
                  child: const Icon(Icons.movie_creation_outlined, size: 50, color: Colors.grey),
                );
              },
            ),
      
            // ⭐ Rating badge
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, size: 12, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      '$rating',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
