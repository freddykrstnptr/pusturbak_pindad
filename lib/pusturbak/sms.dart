import 'package:flutter/material.dart';

class SMSPage extends StatefulWidget {
  final VoidCallback onClose;

  const SMSPage({required this.onClose, Key? key}) : super(key: key);

  @override
  _SMSPageState createState() => _SMSPageState();
}

class _SMSPageState extends State<SMSPage> {
  final TextEditingController _controller = TextEditingController();

  // Chat berbeda untuk Jaupan dan BMS
  List<String> jaupanMessages = ["Test"];
  List<String> bmsMessages = ["Test"];

  bool isJaupanActive = true; // Menandakan tab aktif

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        if (isJaupanActive) {
          jaupanMessages.add(_controller.text);
        } else {
          bmsMessages.add(_controller.text);
        }
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 450, // ✅ Popup lebih tinggi, tapi tab tetap normal
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: const Color.fromARGB(255, 255, 255, 255), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // 🔹 Header dengan tombol tutup (X) - TIDAK BERUBAH UKURAN
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "SMS  :",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: widget.onClose,
                  padding: EdgeInsets.all(4),
                  constraints: BoxConstraints(),
                ),
              ],
            ),
          ),

          // 🔹 Tab antara "Jaupan" dan "BMS" - TETAP NORMAL
          Container(
            height: 40, // Tetap normal
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isJaupanActive = true;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color:
                          isJaupanActive ? Colors.green[700] : Colors.grey[300],
                      child: Text(
                        "Jaupan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isJaupanActive ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isJaupanActive = false;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color:
                          isJaupanActive ? Colors.grey[300] : Colors.green[700],
                      child: Text(
                        "BMS",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isJaupanActive ? Colors.grey : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Tanggal
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Expanded(child: Divider(color: Colors.black)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("5 March 2025",
                      style: TextStyle(fontSize: 12, color: Colors.black)),
                ),
                Expanded(child: Divider(color: Colors.black)),
              ],
            ),
          ),

          // 🔹 Chat List (Bagian ini yang bertambah tinggi)
          Expanded(
            child: ListView.builder(
              itemCount:
                  isJaupanActive ? jaupanMessages.length : bmsMessages.length,
              itemBuilder: (context, index) {
                String message =
                    isJaupanActive ? jaupanMessages[index] : bmsMessages[index];
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pusturbak",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(message,
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "15:30",
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // 🔹 Input Pesan + Tombol Kirim (Tetap normal)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ketik pesan...",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                ElevatedButton(
                  onPressed: _sendMessage,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text("Kirim",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
