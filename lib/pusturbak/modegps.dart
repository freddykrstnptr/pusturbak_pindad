import 'package:flutter/material.dart';

class ModeGPSPage extends StatefulWidget {
  final VoidCallback onClose;

  const ModeGPSPage({required this.onClose, Key? key}) : super(key: key);

  @override
  State<ModeGPSPage> createState() => _ModeGPSPageState();
}

class _ModeGPSPageState extends State<ModeGPSPage> {
  bool isGPSLocked = false;
  bool isGPSCCUSelected = true; // Default GPS CCU terpilih
  bool showSuccessMessage = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: Colors.yellow, width: 2), // Border kuning
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Pilih GPS",
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
                const SizedBox(height: 10),

                // 🔹 Pilihan GPS (Toggle antara GPS CCU dan GPS Display)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isGPSCCUSelected = true;
                            });
                          },
                          child: Container(
                            color:
                                isGPSCCUSelected ? Colors.green : Colors.grey,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Text(
                                "GPS CCU",
                                style: TextStyle(
                                  color: isGPSCCUSelected
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isGPSCCUSelected = false;
                            });
                          },
                          child: Container(
                            color:
                                isGPSCCUSelected ? Colors.grey : Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Text(
                                "GPS Display",
                                style: TextStyle(
                                  color: isGPSCCUSelected
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // 🔹 Checkbox Kunci GPS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Kunci GPS",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Checkbox(
                      value: isGPSLocked,
                      onChanged: (bool? value) {
                        setState(() {
                          isGPSLocked = value ?? true;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 🔹 Tombol Simpan & Batal
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: widget.onClose,
                      child: const Text("BATAL",
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9E9E9E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          showSuccessMessage = true;
                        });
                        Future.delayed(const Duration(seconds: 1), () {
                          setState(() {
                            showSuccessMessage = false;
                          });
                          widget.onClose();
                        });
                      },
                      child: const Text("SIMPAN",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
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
                    "GPS Berhasil Disimpan",
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
}
