import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class PengaturanAkunPage extends StatefulWidget {
  final VoidCallback onClose;

  const PengaturanAkunPage({Key? key, required this.onClose}) : super(key: key);

  @override
  State<PengaturanAkunPage> createState() => _PengaturanAkunPageState();
}

class _PengaturanAkunPageState extends State<PengaturanAkunPage> {
  bool _obscureText = true;
  final TextEditingController _passwordController = TextEditingController();
  bool _showSisbakPage = false;

  @override
  Widget build(BuildContext context) {
    return _showSisbakPage
        ? const PengaturanSisbakMortirPage()
        : Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF212121),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFFEB3B), width: 1),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Pengaturan Akun",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: widget.onClose,
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Kata Sandi",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                              color: Color(0xFFFFEB3B), width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                              color: Color(0xFFFFEB3B), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                              color: Color(0xFFFFEB3B), width: 2),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(
                              color: Color(0xFFFFEB3B), width: 2),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _showSisbakPage = true;
                        });
                      },
                      child: const Text("OK"),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}

class PengaturanSisbakMortirPage extends StatefulWidget {
  const PengaturanSisbakMortirPage({Key? key}) : super(key: key);

  @override
  State<PengaturanSisbakMortirPage> createState() =>
      _PengaturanSisbakMortirPageState();
}

class _PengaturanSisbakMortirPageState
    extends State<PengaturanSisbakMortirPage> {
  bool _isLoggedIn = false;
  String _selectedMenu = 'pengguna';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _getContentWidget() {
    if (_selectedMenu == 'pengguna') {
      return _isLoggedIn ? _buildProfilePage() : _buildLoginForm();
    } else if (_selectedMenu == 'perkakas') {
      return _buildPerkakasPopup();
    } else if (_selectedMenu == 'perangkat') {
      return _buildDataPerangkatPopup();
    } else {
      return const SizedBox();
    }
  }

  Widget _buildDataPerangkatPopup() {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Data Perangkat",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(thickness: 1),
            Table(
              border: const TableBorder(
                bottom: BorderSide(color: Colors.black12),
                horizontalInside: BorderSide(color: Colors.brown, width: 1),
              ),
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
              },
              children: const [
                TableRow(
                  decoration: BoxDecoration(color: Color(0xFFB2FFFF)),
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      child: Text(
                        "Grup",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      child: Text(
                        "3",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 1),
                      child: Center(
                        child: Text(
                          "ID",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text(
                          "Controller",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 60, 255),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () {},
                child: const Text("Ubah Identitas"),
              ),
            ),
            const SizedBox(height: 30),

            // KOMUNIKASI - LONG RANGE RADIO
            const Text("Komunikasi",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text("Long Range Radio",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const Divider(thickness: 1),
            _buildKomunikasiTable(),

            const SizedBox(height: 30),

            // KOMUNIKASI - SHORT RANGE RADIO
            const Text("Short Range Radio",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const Divider(thickness: 1),
            _buildKomunikasiTable(),
            const SizedBox(height: 30),
            const Text("Interoperabilitas",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              color: Color(0xFFB2FFFF),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Status",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("Aktif",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("Alamat Perangkat",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Divider(thickness: 1, color: Colors.black26),
            const Align(
              alignment: Alignment.centerRight,
              child: Text("-",
                  style: TextStyle(fontSize: 18, color: Colors.black54)),
            ),
            const Divider(thickness: 1, color: Colors.black26),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 60, 255),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                onPressed: () {
                  // Aksi klik
                },
                child: const Text("Pengaturan Interoperabilitas",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            const Divider(thickness: 1, color: Colors.black26),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Isi berkas konfigurasi",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black54)),
                Icon(Icons.keyboard_arrow_down, size: 22, color: Colors.black),
              ],
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

// ✅ Tambahin fungsi reusable biar ngirit baris dan gak ngulang kode
  Widget _buildKomunikasiTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
      },
      border: TableBorder.all(color: Colors.black12),
      children: const [
        TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child:
                  Text("Jenis", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Serial (Radio Internal)"),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Poll Timeout (detik)",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("2.0"),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Poll Interval (detik)",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("5.0"),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Daftar Node",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(".Observer1"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFileUpload(String label) {
    String? fileName;

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.brown.shade200),
              ),
              child: Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles();
                      if (result != null) {
                        setState(() {
                          fileName = result.files.first.name;
                        });
                      }
                    },
                    child: const Text("Choose File",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      fileName ?? "No File chosen",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget _buildPerkakasPopup() {
    return Expanded(
      // supaya scrollnya ngikut tinggi available space
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 10), // biar scroll bar ga nempel
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("Perkakas",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Divider(thickness: 1),
          Container(
            width: double.infinity,
            color: Colors.cyanAccent.withOpacity(0.4),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: const Text("Status Layanan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          Table(
            border: TableBorder.symmetric(
                inside: const BorderSide(color: Colors.black12)),
            columnWidths: const {
              0: FixedColumnWidth(60),
              1: FlexColumnWidth(),
            },
            children: [
              _perkakasRow("Sisbak Mortir"),
              _perkakasRow("Interoperability"),
              _perkakasRow("Web Configuration"),
              _perkakasRow("CCU Display"),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            color: Colors.cyanAccent.withOpacity(0.4),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: const Text("Titik Akses",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          Table(
            border: TableBorder.all(color: Colors.black26),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
            },
            children: const [
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("SSID",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("SM3–3C",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Frekuensi",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("5 GHz",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Channel",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("153 (5765 MHz)",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () {},
              child: const Text("Atur Frekuensi"),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            color: Colors.cyanAccent.withOpacity(0.4),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: const Text("Ethernet",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          Table(
            border: TableBorder.all(color: Colors.black26),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
            },
            children: const [
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Auto-negotiation",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Aktif",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Kecepatan",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("10Mb/s",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () {},
              child: const Text("Atur Frekuensi"),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            color: Colors.cyanAccent.withOpacity(0.4),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: const Text("Data Perangkat",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          Table(
            border: TableBorder.all(color: Colors.black26),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
            },
            children: const [
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Part Number",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("TA-CCU008",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("No.Serial",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("CCU009-H24-003",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () {},
              child: const Text("Atur Frekuensi"),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            color: Colors.cyanAccent.withOpacity(0.4),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: const Text("Pembaruan Perangkat",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          _buildFileUpload("Pembaruan"),
          _buildFileUpload("Checksum"),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () {
                // Aksi saat tombol diklik
              },
              child: const Text("Atur Frekuensi"),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            color: Colors.cyanAccent.withOpacity(0.4),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: const Text("Informasi Perangkat",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 20),
          Text("kernel",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87)),
          Text("Linux 4.14.78-hdte-k100+",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87)),
          SizedBox(height: 20),
          Text("CCU",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87)),
          Text("Freescale i. mx6 Ultralite (Device Tree)",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87)),
          SizedBox(height: 20),
          Text("RAM",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87)),
          Text("492.3M (516165632 B)",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87)),
          SizedBox(height: 20),
          Text("Penyimpanan",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87)),
          Text("/dev/root/3.5G",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87)),
          SizedBox(height: 20),
          Text("Alamat dan Rute IP",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87)),
          Text(
            "192.168.0.0/24 dev wlan0 proto kernel scope link src 192.168.0.1\n"
            "192.168.0.0/24 dev eth1 proto kernel scope link src 192.168.1.1 linkdown",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87),
          ),
          SizedBox(height: 20),
          Text("Versi Citra",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87)),
          Text("Sisbakmortir – 20230530",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87)),
          Text("update – 20230530 -> update – 20230821",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87)),
          Text("update – 20230530 -> update – 20230821",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87)),
          Text("update – 20230530 -> update – 20230821",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87)),
          Text("update – 20230530 -> update – 20230821",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87)),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () {},
              child: const Text("Nyalankan Ulang Perangkat"),
            ),
          ),
        ]),
      ),
    );
  }

  TableRow _perkakasRow(String namaLayanan) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          namaLayanan,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 60,
            color: const Color(0xFF3A3A3A),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pengaturan (Sisbak Mortir)",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.brown, width: 2),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.brown),
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 200,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          color: _selectedMenu == 'pengguna'
                              ? Colors.blue
                              : Colors.black,
                        ),
                        title: Text(
                          'Pengguna',
                          style: TextStyle(
                            color: _selectedMenu == 'pengguna'
                                ? Colors.blue
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _selectedMenu = 'pengguna';
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.devices,
                          color: _selectedMenu == 'perangkat'
                              ? Colors.blue
                              : Colors.black,
                        ),
                        title: Text(
                          'Data Perangkat',
                          style: TextStyle(
                            color: _selectedMenu == 'perangkat'
                                ? Colors.blue
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _selectedMenu = 'perangkat';
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.build,
                          color: _selectedMenu == 'perkakas'
                              ? Colors.blue
                              : Colors.black,
                        ),
                        title: Text(
                          'Perkakas',
                          style: TextStyle(
                            color: _selectedMenu == 'perkakas'
                                ? Colors.blue
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _selectedMenu = 'perkakas';
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _getContentWidget(),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Build 25.02.13 15:57:35",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Masuk",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        const Divider(thickness: 1),
        const SizedBox(height: 20),
        const Text("Silakan Masuk Terlebih Dahulu",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black54)),
        const SizedBox(height: 20),
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
            labelText: "Nama Pengguna",
            border: OutlineInputBorder(),
            labelStyle: TextStyle(color: Colors.black54),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: "Kata Sandi",
            border: OutlineInputBorder(),
            labelStyle: TextStyle(color: Colors.black54),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0066FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed: () {
              setState(() {
                _isLoggedIn = true;
              });
            },
            child: const Text(
              "Masuk",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfilePage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Profile",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const Divider(thickness: 1),
        const SizedBox(height: 10),
        const Text("Anda Masuk Sebagai Admin",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54)),
        const SizedBox(height: 30),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text("Ubah Kata Sandi",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoggedIn = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text("Keluar",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        )
      ],
    );
  }
}
