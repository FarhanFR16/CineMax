// ============================================================
// MODEL DATA
// ============================================================

import 'dart:math';

class Movie {
  final String id;
  final String judul;
  final String genre;
  final String sinopsis;
  final String tahun;
  final String rating;
  final String imageUrl;
  final List<String> cinemaIds; // relasi ke cinema

  Movie({
    required this.id,
    required this.judul,
    required this.genre,
    required this.sinopsis,
    required this.tahun,
    required this.rating,
    required this.imageUrl,
    required this.cinemaIds,
  });
}

class Cinema {
  final String id;
  final String nama;
  final String lokasi;
  final String jam;
  final double harga;
  final List<String> movieIds; // relasi ke movie

  Cinema({
    required this.id,
    required this.nama,
    required this.lokasi,
    required this.jam,
    required this.harga,
    required this.movieIds,
  });
}

// ============================================================
// DATA DUMMY
// ============================================================

final List<Cinema> daftarCinema = [
  Cinema(
    id: 'c1',
    nama: 'CGV Grand Indonesia',
    lokasi: 'Jakarta Pusat',
    jam: '10:00 / 13:00 / 16:00 / 19:00',
    harga: 75000,
    movieIds: ['m1', 'm2', 'm3'],
  ),
  Cinema(
    id: 'c2',
    nama: 'XXI Senayan City',
    lokasi: 'Jakarta Selatan',
    jam: '11:00 / 14:00 / 17:00 / 20:00',
    harga: 70000,
    movieIds: ['m1', 'm3', 'm4', 'm5'],
  ),
  Cinema(
    id: 'c3',
    nama: 'Cinepolis Lotte Mall',
    lokasi: 'Jakarta Barat',
    jam: '09:00 / 12:00 / 15:00 / 18:00',
    harga: 65000,
    movieIds: ['m2', 'm3', 'm5'],
  ),
  Cinema(
    id: 'c4',
    nama: 'CGV Cibubur Junction',
    lokasi: 'Cibubur',
    jam: '10:30 / 13:30 / 16:30 / 19:30',
    harga: 60000,
    movieIds: ['m1', 'm2', 'm4'],
  ),
  Cinema(
    id: 'c5',
    nama: 'XXI Summarecon Mall',
    lokasi: 'Bekasi',
    jam: '11:30 / 14:30 / 17:30 / 20:30',
    harga: 55000,
    movieIds: ['m3', 'm4', 'm5'],
  ),
];

final List<Movie> daftarMovie = [
  Movie(
    id: 'm1',
    judul: 'Interstellar',
    genre: 'Sci-Fi / Drama',
    sinopsis: 'Seorang mantan pilot NASA bersama timnya melakukan perjalanan melalui wormhole di luar angkasa untuk memastikan kelangsungan hidup umat manusia.',
    tahun: '2024',
    rating: '8.7',
    imageUrl: 'imagePoster/interstellar.jpeg',
    cinemaIds: ['c1', 'c2', 'c4'],
  ),
  Movie(
    id: 'm2',
    judul: 'Dune: Part Two',
    genre: 'Sci-Fi / Adventure',
    sinopsis: 'Paul Atreides bersatu dengan Chani dan bangsa Fremen dalam perjalanan balas dendam melawan para konspirator yang menghancurkan keluarganya.',
    tahun: '2024',
    rating: '8.5',
    imageUrl: 'imagePoster/dune part two.jpeg',
    cinemaIds: ['c1', 'c3', 'c4'],
  ),
  Movie(
    id: 'm3',
    judul: 'Oppenheimer',
    genre: 'Biography / Drama',
    sinopsis: 'Kisah J. Robert Oppenheimer dan perannya dalam pengembangan bom atom selama Perang Dunia II yang mengubah sejarah dunia selamanya.',
    tahun: '2024',
    rating: '8.9',
    imageUrl: 'imagePoster/oppenheimer.jpeg',
    cinemaIds: ['c1', 'c2', 'c3', 'c5'],
  ),
  Movie(
    id: 'm4',
    judul: 'Godzilla x Kong',
    genre: 'Action / Sci-Fi',
    sinopsis: 'Godzilla dan Kong harus bersatu menghadapi ancaman kolosal yang muncul dari kedalaman Hollow Earth dan mengancam seluruh peradaban manusia.',
    tahun: '2024',
    rating: '7.2',
    imageUrl: 'imagePoster/godzila x kong.jpeg',
    cinemaIds: ['c2', 'c4', 'c5'],
  ),
  Movie(
    id: 'm5',
    judul: 'Kingdom of the Planet',
    genre: 'Action / Adventure',
    sinopsis: 'Generasi baru kera membangun peradaban mereka, sementara manusia masih berjuang untuk bertahan hidup. Sebuah misi berbahaya mengubah segalanya.',
    tahun: '2024',
    rating: '7.5',
    imageUrl: 'imagePoster/kingdom of the planet.jpeg',
    cinemaIds: ['c2', 'c3', 'c5'],
  ),
];

// ambil cinema berdasarkan movie
List<Cinema> getCinemaByMovie(Movie movie) {
  return daftarCinema.where((c) => movie.cinemaIds.contains(c.id)).toList();
}

// ambil movie berdasarkan cinema (random 3 atau 5)
List<Movie> getMovieByCinema(Cinema cinema) {
  final movies = daftarMovie.where((m) => cinema.movieIds.contains(m.id)).toList();
  movies.shuffle(); // Acak urutan filmnya

  // kalau true dapat 5, kalau false dapat 3, note : Random().nextBool() untuk memilih angka 3 atau 5
  int targetJumlah = Random().nextBool() ? 5 : 3;

  // agar tidak melebihi total film yg dimiliki bioskop tsb
  final jumlahAman = targetJumlah.clamp(0, movies.length);

  return movies.take(jumlahAman).toList();
}
