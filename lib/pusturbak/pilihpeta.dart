import 'package:flutter/material.dart';

class PilihPetaPage extends StatefulWidget {
  final VoidCallback onClose;

  const PilihPetaPage({required this.onClose, Key? key}) : super(key: key);

  @override
  State<PilihPetaPage> createState() => _PilihPetaPageState();
}

class _PilihPetaPageState extends State<PilihPetaPage> {
  String selectedDaerah = "Bandung";
  String selectedJenis = "Street Map";
  int minZoomLevel = 8;
  int maxZoomLevel = 19;
  bool showSuccessMessage = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 500,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.yellow, width: 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header diperlebar sesuai parent
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Pilih Peta",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: widget.onClose,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildDropdown(
                          "Daerah",
                          [
                            "Bandung",
                            "Cikalong",
                            "Lumajang",
                            "Cililin",
                            "Cipatat"
                          ],
                          selectedDaerah, (value) {
                        setState(() {
                          selectedDaerah = value!;
                        });
                      }),
                      _buildDropdown(
                          "Jenis",
                          ["Street Map", "Satellite Map", "Topografi Map"],
                          selectedJenis, (value) {
                        setState(() {
                          selectedJenis = value!;
                        });
                      }),
                      _buildDropdown(
                          "Min Zoom Level",
                          List.generate(20, (index) => "$index"),
                          "$minZoomLevel", (value) {
                        setState(() {
                          minZoomLevel = int.parse(value!);
                        });
                      }),
                      _buildDropdown(
                          "Max Zoom Level",
                          List.generate(20, (index) => "$index"),
                          "$maxZoomLevel", (value) {
                        setState(() {
                          maxZoomLevel = int.parse(value!);
                        });
                      }),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: const BorderSide(
                                    color: Color.fromARGB(255, 255, 0, 0),
                                    width: 1),
                              ),
                            ),
                            onPressed: widget.onClose,
                            child: const Text("BATAL",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: const BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    width: 1),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                showSuccessMessage = true;
                              });
                              Future.delayed(const Duration(seconds: 1), () {
                                if (mounted) {
                                  setState(() {
                                    showSuccessMessage = false;
                                  });
                                  widget.onClose();
                                }
                              });
                            },
                            child: const Text("SIMPAN",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // 🔹 Popup Berhasil Disimpan (Di Atas)
        if (showSuccessMessage)
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check, color: Colors.black),
                  const SizedBox(width: 10),
                  const Text(
                    "Peta Berhasil Disimpan",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDropdown(String label, List<String> options,
      String selectedValue, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedValue,
                  isExpanded: true,
                  dropdownColor: Colors.grey[350],
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  onChanged: onChanged,
                  items: options.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
