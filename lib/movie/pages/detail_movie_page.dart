import 'package:flutter/material.dart';
import '../data/movie_data.dart';
import 'detail_cinema_page.dart';
import 'beli_tiket_bottomsheet.dart';

class DetailMoviePage extends StatelessWidget {
  final Movie movie;

  const DetailMoviePage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final cinemaList = getCinemaByMovie(movie);

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // AppBar dengan gambar
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(movie.imageUrl, fit: BoxFit.cover),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul & rating
                  Text(
                    movie.judul,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(movie.genre,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12)),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(movie.rating,
                          style: const TextStyle(
                              color: Colors.amber, fontSize: 14)),
                      const SizedBox(width: 10),
                      Text('• ${movie.tahun}',
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Sinopsis
                  const Text(
                    'Sinopsis',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.sinopsis,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Daftar Cinema (maks 5)
                  Text(
                    'Tersedia di ${cinemaList.length} Bioskop',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...cinemaList.take(5).map((cinema) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailCinemaPage(cinema: cinema),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.local_movies,
                                color: Colors.red, size: 24),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cinema.nama,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(cinema.lokasi,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                  Text(
                                    'Rp ${cinema.harga.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                        color: Colors.amber, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            // Tombol beli tiket
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: () {
                                showBeliTiketBottomSheet(
                                    context, movie, cinema);
                              },
                              child: const Text('Beli',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13)),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
