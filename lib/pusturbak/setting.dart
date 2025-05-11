import 'package:flutter/material.dart';
import 'package:pusturbak_pindad/main.dart'; // Import main.dart agar bisa diakses
import 'package:pusturbak_pindad/pusturbak/modegps.dart'; // Import halaman Mode GPS
import 'package:pusturbak_pindad/pusturbak/tambahpeta.dart'; // Import halaman Tambah Peta
import 'package:pusturbak_pindad/pusturbak/pilihpeta.dart'; // Import halaman Pilih Peta
import 'package:pusturbak_pindad/pusturbak/kalkulatordeklinasi.dart'; // Import halaman Kalkulator Deklinasi
import 'package:pusturbak_pindad/pusturbak/pengaturanakun.dart'; // Import halaman Pengaturan Akun
import 'package:pusturbak_pindad/pusturbak/informasiperangkat.dart'; // Import halaman Informasi Perangkat

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool showMenuOperasi = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          decoration: const BoxDecoration(
            color: Color(0xFF424242), // Latar belakang gelap
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header bagian atas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Pengaturan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Tombol MENU OPERASI & KONFIGURASI
              Row(
                children: [
                  _menuButton("MENU OPERASI", true),
                  const SizedBox(width: 10),
                  _menuButton("KONFIGURASI", false),
                ],
              ),
              const SizedBox(height: 20),

              // Konten di dalam Settings
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF212121),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: showMenuOperasi
                        ? [
                            _settingTile("Pengaturan Akun", Icons.person,
                                onTap: () {
                              _showPengaturanAkunPopup();
                            }),
                            _settingTile("Informasi Perangkat", Icons.info,
                                onTap: () {
                              _showInformasiPerangkatPopup(); // Tampilkan Pop-up
                            }),
                            _settingTile("Keluar", Icons.logout,
                                isLogout: true),
                          ]
                        : [
                            _settingTile("Daftar Tembak", Icons.list),
                            _settingTile("Tambah Peta", Icons.add_location,
                                onTap: () {
                              _showTambahPetaPopup();
                            }),
                            _settingTile("Pilih Peta", Icons.map, onTap: () {
                              _showPilihPetaPopup();
                            }),
                            _settingTile(
                                "Kalkulator Deklinasi", Icons.calculate,
                                onTap: () {
                              _showKalkulatorDeklinasiPopup();
                            }),
                            _settingTile("Mode GPS", Icons.gps_fixed,
                                onTap: () {
                              _showModeGPSPopup();
                            }),
                          ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk Tombol Menu Operasi & Konfigurasi
  Widget _menuButton(String title, bool isMenuOperasi) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color(0xDD000000),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: const BorderSide(color: Color(0xFFFFEB3B), width: 1),
      ),
      onPressed: () {
        setState(() {
          showMenuOperasi = isMenuOperasi;
        });
      },
      child: Text(title),
    );
  }

  // Widget untuk Tile Pengaturan
  Widget _settingTile(String title, IconData icon,
      {bool isLogout = false, VoidCallback? onTap}) {
    return InkWell(
      onTap: isLogout
          ? () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) => false,
              );
            }
          : onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xFFFFEB3B), width: 1),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk Menampilkan Popups
  void _showModeGPSPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: ModeGPSPage(onClose: () => Navigator.pop(context)),
        );
      },
    );
  }

  void _showTambahPetaPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: TambahPetaPage(onClose: () => Navigator.pop(context)),
        );
      },
    );
  }

  void _showPilihPetaPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: PilihPetaPage(onClose: () => Navigator.pop(context)),
        );
      },
    );
  }

  void _showKalkulatorDeklinasiPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: KalkulatorDeklinasiPage(onClose: () => Navigator.pop(context)),
        );
      },
    );
  }

  void _showPengaturanAkunPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: PengaturanAkunPage(onClose: () => Navigator.pop(context)),
        );
      },
    );
  }

  // Fungsi untuk Menampilkan Halaman Informasi Perangkat (Pop-up)
  void _showInformasiPerangkatPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: InformasiPerangkatPage(onClose: () => Navigator.pop(context)),
        );
      },
    );
  }
}
