import 'package:flutter/material.dart';
import '../data/movie_data.dart';
import 'detail_cinema_page.dart';

class ListCinemaTab extends StatelessWidget {
  const ListCinemaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: daftarCinema.length,
      itemBuilder: (context, index) {
        final cinema = daftarCinema[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    DetailCinemaPage(cinema: cinema),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  // Memakai transisi Fade murni tanpa kalkulasi posisi pergeseran layar
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.local_movies, color: Colors.red, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cinema.nama,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.grey, size: 13),
                          const SizedBox(width: 4),
                          Text(cinema.lokasi,
                              style: const TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rp ${cinema.harga.toStringAsFixed(0)}  •  ${cinema.movieIds.length} Film',
                        style: const TextStyle(color: Colors.amber, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
        );
      },
    );
  }
}