import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:pusturbak_pindad/maps/mapscreen.dart';
import 'package:pusturbak_pindad/pusturbak/setting.dart';
import 'package:pusturbak_pindad/pusturbak/sms.dart';
import 'package:pusturbak_pindad/pusturbak/cuaca.dart';
import 'package:pusturbak_pindad/pusturbak/datasasaran.dart';
import 'package:pusturbak_pindad/pusturbak/daftarobjek.dart';
import 'package:pusturbak_pindad/pusturbak/daftartembak.dart';

class MainPusturbakPage extends StatelessWidget {
  const MainPusturbakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DashboardPage(),
    );
  }
}

class _AmunisiCell extends StatelessWidget {
  final String text;
  const _AmunisiCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}

Widget _amunisiTextCell(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    ),
  );
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final MapController _mapController = MapController();
  bool _isNavBarVisible = false;
  bool _isSMSVisible = false;
  bool _isWeatherVisible = false;
  bool _isDataSasaranVisible = false;
  bool _isDaftarTembakVisible = false;
  bool _isDaftarObjekVisible = false;
  bool _isModeOnoffVisible = false;
  bool _isKoPucukDialogVisible = false;
  bool _isArahAmunisiVisible = false;
  bool _showSuccessAlert = false; // Added for showing success alert
  bool _isModeDialogVisible = false;

// Controller untuk input
  TextEditingController _idPucukController = TextEditingController();
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();
  TextEditingController _altitudeController = TextEditingController();
  TextEditingController arahTDController = TextEditingController();
  TextEditingController jarakTDController = TextEditingController();
  TextEditingController sudutKompasController = TextEditingController();
  TextEditingController dariTD1Controller = TextEditingController();
  TextEditingController dariTD2Controller = TextEditingController();
  TextEditingController jarakPeninjauController = TextEditingController();
  TextEditingController jarakKePucukController = TextEditingController();
  TextEditingController sudutKompasKeTDController = TextEditingController();
  TextEditingController sudutKompasKeTPController = TextEditingController();
  TextEditingController arahTP1Controller = TextEditingController();
  TextEditingController jarakTP1Controller = TextEditingController();
  TextEditingController pucukXController = TextEditingController();
  TextEditingController pucukYController = TextEditingController();
  TextEditingController jaupanXController = TextEditingController();
  TextEditingController jaupanYController = TextEditingController();
  TextEditingController sasaranXController = TextEditingController();
  TextEditingController sasaranYController = TextEditingController();
  TextEditingController arahTengahSektorController = TextEditingController();

  // Nilai toggle aktif
  String arahPilihan = "Kanan";
  String gerakPilihan = "Maju";
  int currentMode = 1;

  // build Mode1
  Widget _buildMode1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputRow("Arah ke TD", "mil", arahTDController),
        const SizedBox(height: 12),
        _buildInputRow("Jarak ke TD", "meter", jarakTDController),
        const SizedBox(height: 12),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Permintaan Tembakan",
            style: TextStyle(color: Colors.red, fontSize: 14),
          ),
        ),
        const SizedBox(height: 12),
        _buildInputRow("Sudut Kompas", "mil", sudutKompasController),
        const SizedBox(height: 12),
        _buildInputToggleRow(
          label: "Dari TD",
          controller: dariTD1Controller,
          options: ["Kiri", "Kanan"],
          selectedValue: arahPilihan,
          onChanged: (val) {
            setState(() {
              arahPilihan = val;
            });
          },
        ),
        const SizedBox(height: 12),
        _buildInputToggleRow(
          label: "Dari TD",
          controller: dariTD2Controller,
          options: ["Mundur", "Maju"],
          selectedValue: gerakPilihan,
          onChanged: (val) {
            setState(() {
              gerakPilihan = val;
            });
          },
        ),
      ],
    );
  }

  // build Mode2
  Widget _buildMode2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputRow("Arah ke TD", "mil", arahTDController),
        const SizedBox(height: 12),
        _buildInputRow("Jarak ke TD", "meter", jarakTDController),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(
              child: Text(
                "Penunjukkan Tempat Peninjau",
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                "Permintaan Tembak",
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
                child: _buildInputRow(
                    "Sudut Kompas ke TD", "mil", sudutKompasController)),
            const SizedBox(width: 16),
            Expanded(
                child: _buildInputRow(
                    "Sudut Kompas", "mil", sudutKompasController)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
                child:
                    _buildInputRow("Jarak ke TD", "meter", dariTD2Controller)),
            const SizedBox(width: 16),
            Expanded(
                child: _buildInputRow(
                    "Jarak Peninjau", "meter", jarakPeninjauController)),
          ],
        ),
      ],
    );
  }

  // build Mode3
  Widget _buildMode3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputRow("Arah ke TD", "mil", arahTDController),
        const SizedBox(height: 12),
        _buildInputRow("Jarak ke TD", "meter", jarakTDController),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(
              child: Text(
                "Penunjukkan Tempat Peninjau",
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                "Permintaan Tembakan",
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildInputRow(
                  "Sudut Kompas ke Pucuk", "mil", dariTD1Controller),
            ),
            const SizedBox(width: 16),
            Expanded(
              child:
                  _buildInputRow("Sudut Kompas", "mil", sudutKompasController),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildInputRow(
                  "Jarak ke Pucuk", "meter", jarakKePucukController),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInputRow(
                  "Jarak Peninjau", "meter", jarakPeninjauController),
            ),
          ],
        ),
      ],
    );
  }

  // build Mode4
  Widget _buildMode4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputRow("Arah ke TD", "mil", arahTDController),
        const SizedBox(height: 12),
        _buildInputRow("Jarak ke TD", "meter", jarakTDController),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(
              child: Text(
                "Penunjukkan Tempat Peninjau",
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                "Permintaan Tembakan",
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildInputRow(
                  "Sudut Kompas ke TD", "mil", sudutKompasKeTDController),
            ),
            const SizedBox(width: 16),
            Expanded(
              child:
                  _buildInputRow("Sudut Kompas", "mil", sudutKompasController),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildInputRow(
                  "Sudut Kompas ke Pucuk", "mil", dariTD1Controller),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInputRow(
                  "Jarak Peninjau", "meter", jarakPeninjauController),
            ),
          ],
        ),
      ],
    );
  }

  // build Mode5
  Widget _buildMode5() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildInputRow("Arah ke TD", "mil", arahTDController),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInputRow("Arah ke TP1", "mil", arahTP1Controller),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildInputRow("Jarak ke TD", "meter", jarakTDController),
            ),
            const SizedBox(width: 16),
            Expanded(
              child:
                  _buildInputRow("Jarak ke TP1", "meter", jarakTP1Controller),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(
              child: Text(
                "Penunjukkan Tempat Peninjau",
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                "Permintaan Tembakan",
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildInputRow(
                  "Sudut Kompas ke TD", "mil", sudutKompasKeTDController),
            ),
            const SizedBox(width: 16),
            Expanded(
              child:
                  _buildInputRow("Sudut Kompas", "mil", sudutKompasController),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildInputRow(
                  "Sudut Kompas ke TP", "mil", sudutKompasKeTPController),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInputRow(
                  "Jarak Peninjau", "meter", jarakPeninjauController),
            ),
          ],
        ),
      ],
    );
  }

// build Mode6
  Widget _buildMode6() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDoubleInputRow("Pucuk Co", pucukXController, pucukYController),
        const SizedBox(height: 12),
        _buildDoubleInputRow("Jaupan Co", jaupanXController, jaupanYController),
        const SizedBox(height: 12),
        _buildDoubleInputRow(
            "Sasaran Co", sasaranXController, sasaranYController),
        const SizedBox(height: 12),
        _buildInputRow("Arah Tengah Sektor", "mil", arahTengahSektorController),
        const SizedBox(height: 12),
        _buildInputRow("Sudut Kompas", "mil", sudutKompasController),
      ],
    );
  }

  Widget _buildInputRow(
      String label, String satuan, TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(label, style: const TextStyle(fontSize: 16)),
        ),
        Expanded(
          flex: 5,
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              border: UnderlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(satuan, style: const TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  Widget _buildInputToggleRow({
    required String label,
    required TextEditingController controller,
    required List<String> options,
    required String selectedValue,
    required Function(String) onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(label, style: const TextStyle(fontSize: 16)),
        ),
        Expanded(
          flex: 4,
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              border: UnderlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Row(
            children: options.map((opt) {
              final isSelected = opt == selectedValue;
              return Flexible(
                child: GestureDetector(
                  onTap: () => onChanged(opt),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(
                        vertical: 6, horizontal: 8), // ⬅️ lebih ramping
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.grey.shade800 : Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        opt,
                        style: TextStyle(
                          fontSize: 13, // ⬅️ ukuran font lebih kecil
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDoubleInputRow(String label, TextEditingController xController,
      TextEditingController yController) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(label, style: const TextStyle(fontSize: 16)),
        ),
        Expanded(
          flex: 3,
          child: TextField(
            controller: xController,
            decoration: const InputDecoration(
              hintText: "X",
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              border: UnderlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: TextField(
            controller: yController,
            decoration: const InputDecoration(
              hintText: "Y",
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              border: UnderlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapScreen(controller: _mapController),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.grey.shade900,
              padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18), // Menyesuaikan padding bar status
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .start, // Agar tombol tidak tersebar merata
                children: [
                  // Tombol untuk CCU
                  // _statusGroup(backgroundColor: Colors.black, children: [
                  //   ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.black,
                  //       foregroundColor: Colors.green,
                  //       side: BorderSide(
                  //           color: const Color.fromARGB(255, 0, 0, 0),
                  //           width: 2),
                  //       padding:
                  //           EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(4)),
                  //     ),
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const BinocularViewPage()),
                  //       );
                  //     },
                  //     child: Row(
                  //       children: const [
                  //         Icon(Icons.circle, color: Colors.green, size: 12),
                  //         SizedBox(width: 4),
                  //         Text('CCU', style: TextStyle(color: Colors.green)),
                  //       ],
                  //     ),
                  //   ),
                  // ]),

                  SizedBox(width: 3), // Jarak antar tombol

                  // Tombol untuk ID Pucuk
                  _statusGroup(
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                            foregroundColor: Colors.green,
                            side: BorderSide(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                width: 2),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Icon(Icons.change_history, color: Colors.green),
                              SizedBox(width: 4),
                              Text('6133 2876',
                                  style: TextStyle(color: Colors.green)),
                            ],
                          ),
                        ),
                      ]),

                  SizedBox(width: 3), // Jarak antar tombol

                  // Tombol untuk KO PUCUK
                  _statusGroup(
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                            foregroundColor: Colors.red,
                            side: BorderSide(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                width: 2),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          onPressed: () {
                            setState(() {
                              _isKoPucukDialogVisible = true;
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.arrow_upward, color: Colors.red),
                              SizedBox(width: 8),
                              Text('KO PUCUK',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ],
                          ),
                        ),
                      ]),

                  SizedBox(width: 3), // Jarak antar tombol

                  // Tombol untuk info lainnya
                  _statusGroup(backgroundColor: Colors.black, children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.orange,
                        side: BorderSide(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            width: 2),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      onPressed: () {
                        setState(() {
                          _isArahAmunisiVisible = !_isArahAmunisiVisible;
                        });
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.electric_bolt, color: Colors.orange),
                          SizedBox(width: 4),
                          Text('100/', style: TextStyle(color: Colors.red)),
                          Text('200/', style: TextStyle(color: Colors.orange)),
                          Text('300', style: TextStyle(color: Colors.amber)),
                        ],
                      ),
                    ),
                  ]),

                  SizedBox(width: 3), // Jarak antar tombol

                  // Tombol untuk Battery info
                  _statusGroup(backgroundColor: Colors.black, children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        side: BorderSide(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            width: 2),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: const [
                          Icon(Icons.battery_full, color: Colors.white),
                          SizedBox(width: 2),
                          Text('CCU 100%',
                              style: TextStyle(color: Colors.white)),
                          SizedBox(width: 8),
                          Icon(Icons.battery_full, color: Colors.white),
                          SizedBox(width: 2),
                          Text('DISPLAY 100%',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ]),

                  SizedBox(width: 3), // Jarak antar tombol

                  // Tombol untuk Timestamp
                  _statusGroup(
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                            foregroundColor: Colors.green,
                            side: BorderSide(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                width: 2),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Icon(Icons.folder, color: Colors.green),
                              SizedBox(width: 4),
                              Text('071559 FEB 2025',
                                  style: TextStyle(color: Colors.green)),
                            ],
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          ),

          // Sidebar kiri
          Positioned(
            left: 10,
            top: 80,
            child: Column(
              children: [
                _menuButton(Icons.chat, "Chat", () {
                  setState(() => _isSMSVisible = !_isSMSVisible);
                }),
                _menuButton(Icons.cloud, "Weather", () {
                  setState(() => _isWeatherVisible = !_isWeatherVisible);
                }),
                _menuButton(Icons.photo_library, "Galeri Tembak", () {
                  setState(
                      () => _isDataSasaranVisible = !_isDataSasaranVisible);
                }),
                _menuButton(Icons.list, "Targets", () {
                  setState(
                      () => _isDaftarTembakVisible = !_isDaftarTembakVisible);
                }),
                _menuButton(Icons.explore, "Kompas", () {
                  setState(
                      () => _isDaftarObjekVisible = !_isDaftarObjekVisible);
                }),
              ],
            ),
          ),

          // Pop-up fitur
          if (_isSMSVisible)
            Positioned(
              left: 80,
              top: 120,
              child:
                  SMSPage(onClose: () => setState(() => _isSMSVisible = false)),
            ),
          if (_isWeatherVisible)
            Positioned(
              left: 80,
              top: 120,
              child: CuacaPage(
                  onClose: () => setState(() => _isWeatherVisible = false)),
            ),
          if (_isDataSasaranVisible)
            Positioned(
              left: 80,
              top: 120,
              child: DataSasaranPage(
                  onClose: () => setState(() => _isDataSasaranVisible = false)),
            ),
          if (_isDaftarTembakVisible)
            Positioned(
              left: 80,
              top: 120,
              child: DaftarTembakPage(
                  onClose: () =>
                      setState(() => _isDaftarTembakVisible = false)),
            ),
          if (_isDaftarObjekVisible)
            Positioned(
              bottom: 16,
              right: 16,
              child: CompassWidget(),
            ),

          // Tombol kanan atas
          Positioned(
            right: 10,
            top: 80,
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.blueGrey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isNavBarVisible = !_isNavBarVisible;
                    });
                  },
                  child: Icon(
                    _isNavBarVisible ? Icons.close : Icons.menu,
                    color: Colors.white,
                  ),
                ),
                if (_isNavBarVisible) _buildNavBar(),
              ],
            ),
          ),

          // Dialog input (Posisi Pucuk)
          if (_isKoPucukDialogVisible)
            Positioned(
              top: 150,
              left: 50,
              right: 50,
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Container(
                  width: 700,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Center(
                        child: const Text(
                          "Masukan Posisi Pucuk",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 10),

                      // Input Fields
                      _buildTextField(_idPucukController, 'ID Pucuk'),
                      SizedBox(height: 8),
                      _buildTextField(_latitudeController, 'Latitude Pucuk'),
                      SizedBox(height: 8),
                      _buildTextField(_longitudeController, 'Longitude Pucuk'),
                      SizedBox(height: 8),
                      _buildTextField(_altitudeController, 'Altitude Pucuk'),
                      SizedBox(height: 20),

                      // Save and Cancel buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isKoPucukDialogVisible = false;
                                  _showSuccessAlert =
                                      true; // Show success alert
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: Colors.grey.shade300,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text(
                                "SIMPAN",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isKoPucukDialogVisible = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: Colors.grey.shade300,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text(
                                "BATAL",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

          if (_isModeDialogVisible)
            Positioned(
              top: 150,
              left: 50,
              right: 50,
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Container(
                  width: 600,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_left),
                            onPressed: () {
                              setState(() {
                                if (currentMode > 1) currentMode--;
                              });
                            },
                          ),
                          Text(
                            "Mode $currentMode",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_right),
                            onPressed: () {
                              setState(() {
                                if (currentMode < 7) currentMode++;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // ✨ INI YANG DIUBAH: konten berbeda tiap mode
                      if (currentMode == 1)
                        _buildMode1()
                      else if (currentMode == 2)
                        _buildMode2()
                      else if (currentMode == 3)
                        _buildMode3()
                      else if (currentMode == 4)
                        _buildMode4()
                      else if (currentMode == 5)
                        _buildMode5()
                      else if (currentMode == 6)
                        _buildMode6()
                      else
                        Text("Mode belum diimplementasikan"),

                      const SizedBox(height: 24),

                      // Tombol HITUNG dan BATAL
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() => _isModeDialogVisible = false);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("HITUNG"),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() => _isModeDialogVisible = false);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("BATAL"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

          if (_isArahAmunisiVisible)
            Center(
              child: Container(
                width: 400,
                margin: const EdgeInsets.only(bottom: 100),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(8)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Amunisi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isArahAmunisiVisible = false;
                              });
                            },
                            child: const Icon(Icons.close, color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    // Label atas (simbol dan teks warna)
                    Container(
                      color: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(Icons.arrow_upward, color: Colors.green),
                          Text('TJ',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)),
                          Text('ASP',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold)),
                          Text('CHY',
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),

                    // Nilai-nilai amunisi
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(8)),
                      ),
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(),
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                          3: FlexColumnWidth(),
                        },
                        border: TableBorder.symmetric(
                          inside: BorderSide(color: Colors.black, width: 0.5),
                        ),
                        children: [
                          TableRow(
                            children: [
                              _amunisiTextCell('1'),
                              _amunisiTextCell('32'),
                              _amunisiTextCell('30'),
                              _amunisiTextCell('24'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          if (_showSuccessAlert)
            Positioned(
              top: 100,
              left: 50,
              right: 50,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 300, // Fixed width for the alert
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 24, // Adjust size if necessary
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Posisi Berhasil Disimpan',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black),
                          overflow: TextOverflow
                              .ellipsis, // Ensure text doesn't overflow
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            _showSuccessAlert = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _statusGroup(
      {required Color backgroundColor, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: children),
    );
  }

  Widget _menuButton(IconData icon, String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(16),
          backgroundColor: Colors.black,
        ),
        onPressed: onPressed,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  Widget _buildNavBar() {
    return Column(
      children: [
        _navButton(Icons.add, "Zoom In", () {
          _mapController.move(_mapController.center, _mapController.zoom + 1);
        }),
        _navButton(Icons.remove, "Zoom Out", () {
          _mapController.move(_mapController.center, _mapController.zoom - 1);
        }),
        _navButton(Icons.my_location, "Locate Me", () async {
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          final myLoc = LatLng(position.latitude, position.longitude);
          _mapController.move(myLoc, 15);
        }),
        _navButton(Icons.layers, "Layer Options", () {}),
        _navButton(
          _isModeDialogVisible ? Icons.toggle_on : Icons.toggle_off,
          "Mode",
          () {
            setState(() {
              _isModeDialogVisible = !_isModeDialogVisible;
            });
          },
        ),
        _navButton(Icons.settings, "Settings", () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SettingsPage()));
        }),
      ],
    );
  }

  Widget _navButton(IconData icon, String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(16),
          backgroundColor: Colors.black,
        ),
        onPressed: onPressed,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

// Helper method to build TextField
Widget _buildTextField(TextEditingController controller, String label) {
  return Container(
    width: double.infinity,
    child: TextField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
    ),
  );
}

// Helper method to group buttons
Widget _statusGroup(
    {required Color backgroundColor, required List<Widget> children}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(3),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: children),
  );
}

// Helper method to build menu button
Widget _menuButton(IconData icon, String label, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
        backgroundColor: Colors.black,
      ),
      onPressed: onPressed,
      child: Icon(icon, color: Colors.white),
    ),
  );
}
