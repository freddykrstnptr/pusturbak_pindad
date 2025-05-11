import 'package:flutter/material.dart';

class DataSasaranPage extends StatefulWidget {
  final VoidCallback onClose;

  const DataSasaranPage({required this.onClose, Key? key}) : super(key: key);

  @override
  _DataSasaranPageState createState() => _DataSasaranPageState();
}

class _DataSasaranPageState extends State<DataSasaranPage> {
  int selectedIndex = -1;
  final List<Map<String, String>> imageList = [
    {"image": "asset/img/tes1.jpg", "name": "tes1.jpg"},
    {"image": "asset/img/tes2.jpg", "name": "tes2.jpg"},
    {"image": "asset/img/tes3.jpg", "name": "tes3.jpg"},
  ];

  // Fungsi untuk menampilkan dialog konfirmasi hapus
  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Apakah Gambar Yakin Dihapus?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pop(); // Tutup dialog terlebih dahulu
                      _deleteImage(index); // Hapus gambar
                      // Tampilkan alert berhasil hapus setelah gambar dihapus
                      _showImageDeletedAlert(context);
                    },
                    child: Text("HAPUS", style: TextStyle(color: Colors.red)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("TIDAK", style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Fungsi untuk menampilkan alert gambar berhasil dihapus
  void _showImageDeletedAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Sudut melengkung sedikit
          ),
          child: Container(
            width: 300, // Lebar dialog lebih lebar secara horizontal
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 50,
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "Gambar Berhasil Dihapus",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Menutup alert sukses hapus
                  },
                  child: Text("OK", style: TextStyle(color: Colors.green)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Fungsi untuk menghapus gambar
  void _deleteImage(int index) {
    setState(() {
      imageList.removeAt(index);
      selectedIndex = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 500,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 1),
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
                  "Data Sasaran Diterima",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: widget.onClose,
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = selectedIndex == index ? -1 : index;
                        });
                      },
                      child: _buildImageCard(
                        imageList[index]["image"]!,
                        imageList[index]["name"]!,
                        isSelected: selectedIndex == index,
                      ),
                    ),
                    if (selectedIndex == index) _buildActionButtons(index),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(String imagePath, String fileName,
      {bool isSelected = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey[200] : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.black26,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 150,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              fileName,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black26),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton("HAPUS", Colors.red, () {
            _showDeleteConfirmation(context, index);
          }),
          _buildActionButton("KIRIM", Colors.green, () {
            print('Gambar dikirim');
            setState(() {
              selectedIndex = -1;
            });
          }),
          _buildActionButton("KEMBALI", Colors.blue, () {
            print('KEMBALI dipilih');
            setState(() {
              selectedIndex = -1;
            });
          }),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
