import 'package:flutter/material.dart';

class KalkulatorDeklinasiPage extends StatefulWidget {
  final VoidCallback onClose;

  const KalkulatorDeklinasiPage({required this.onClose, Key? key})
      : super(key: key);

  @override
  State<KalkulatorDeklinasiPage> createState() =>
      _KalkulatorDeklinasiPageState();
}

class _KalkulatorDeklinasiPageState extends State<KalkulatorDeklinasiPage> {
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController altitudeController = TextEditingController();

  String selectedDay = "31";
  String selectedMonth = "DES";
  String selectedYear = "2017";

  final List<String> days = ["31", "01", "02"];
  final List<String> months = ["DES", "JAN", "FEB"];
  final List<String> years = ["2017", "2018", "2019"];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 500,
          height: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.yellow, width: 2),
          ),
          child: Column(
            children: [
              // 🔹 Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        "Kalkulator Deklinasi",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: widget.onClose,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // 🔹 Bagian Form Input & Date, Sekarang lebih rapi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextField("Latitude", latitudeController),
                          _buildTextField("Longitude", longitudeController),
                          _buildTextField("Altitude", altitudeController,
                              unit: "meter"),
                        ],
                      ),
                    ),
                    Container(
                      width: 1.5,
                      height: 110,
                      color: Colors.black,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    Expanded(
                      flex: 2,
                      child: _buildDateSection(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // 🔹 Deklinasi
              const Text(
                "Deklinasi",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Text(
                "° / Mill",
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 20),

              // 🔹 Tombol Hitung dan Tutup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton("Hitung", Colors.black, Colors.white),
                  const SizedBox(width: 10),
                  _buildButton("Tutup", Colors.red, Colors.white,
                      onPressed: widget.onClose),
                ],
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Widget untuk Field Input Latitude, Longitude, Altitude
  Widget _buildTextField(String label, TextEditingController controller,
      {String unit = ""}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(label, style: _labelTextStyle())),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          if (unit.isNotEmpty) ...[
            const SizedBox(width: 5),
            Text(unit, style: _labelTextStyle()),
          ],
        ],
      ),
    );
  }

  // 🔹 Widget untuk bagian input tanggal (DATE)
  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "DATE",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDropdown(days, selectedDay, (value) {
              setState(() {
                selectedDay = value!;
              });
            }),
            const SizedBox(width: 5),
            _buildDropdown(months, selectedMonth, (value) {
              setState(() {
                selectedMonth = value!;
              });
            }),
            const SizedBox(width: 5),
            _buildDropdown(years, selectedYear, (value) {
              setState(() {
                selectedYear = value!;
              });
            }),
          ],
        ),
      ],
    );
  }

  // 🔹 Widget untuk Dropdown Input Tanggal
  Widget _buildDropdown(List<String> items, String selectedValue,
      ValueChanged<String?> onChanged) {
    return Container(
      width: 60,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          isExpanded: true,
          onChanged: onChanged,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Center(child: Text(value)),
            );
          }).toList(),
        ),
      ),
    );
  }

  // 🔹 Widget untuk Tombol
  Widget _buildButton(String label, Color bgColor, Color textColor,
      {VoidCallback? onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // Sudut tidak terlalu tajam
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      onPressed: onPressed ?? () {},
      child: Text(label, style: TextStyle(color: textColor, fontSize: 16)),
    );
  }

  TextStyle _labelTextStyle() {
    return const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  }
}
