import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilTab extends StatelessWidget {
  const ProfilTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.red,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 16),
          const Text(
            'Pengguna CineMax',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text('user@cinemax.id',
              style: TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 32),
          _buildMenuItem(Icons.history, 'Riwayat Tiket', () {}),
          _buildMenuItem(Icons.favorite_border, 'Film Favorit', () {}),
          _buildMenuItem(Icons.settings_outlined, 'Pengaturan', () {}),
          _buildMenuItem(Icons.help_outline, 'Bantuan', () {}),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text('Keluar',
                  style: TextStyle(color: Colors.red, fontSize: 16)),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.grey[900],
                    title: const Text('Keluar?',
                        style: TextStyle(color: Colors.white)),
                    content: const Text('Apakah kamu yakin ingin keluar?',
                        style: TextStyle(color: Colors.grey)),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Batal',
                            style: TextStyle(color: Colors.grey)),
                      ),
                      TextButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('is_logged_in', false);
                          if (!context.mounted) return;
                          
                          Navigator.pop(context); // close dialog
                          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                        },
                        child: const Text('Keluar',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white70, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label,
                  style: const TextStyle(color: Colors.white, fontSize: 15)),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
