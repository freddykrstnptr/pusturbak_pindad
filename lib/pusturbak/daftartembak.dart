import 'package:flutter/material.dart';

class DaftarTembakPage extends StatelessWidget {
  final VoidCallback onClose;

  const DaftarTembakPage({required this.onClose, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataTembak = List.generate(
        3,
        (index) => {
              'tanggal': '141613 Jun 2024',
              'id': '1718356388933',
              'arah': '6057',
              'jarak': '1949',
              'jenis': 'Tajam',
            });

    return Container(
      width: 400,
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Daftar Tembak",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: onClose,
                ),
              ],
            ),
          ),
          // Konten daftar tembak
          Expanded(
            child: ListView.builder(
              itemCount: dataTembak.length,
              itemBuilder: (context, index) {
                final item = dataTembak[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Kolom kiri hijau
                        Container(
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'No.${index + 1}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Konten kanan
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(item['tanggal'] ?? '',
                                        style:
                                            TextStyle(color: Colors.grey[700])),
                                    Text(item['id'] ?? '',
                                        style:
                                            TextStyle(color: Colors.grey[700])),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(child: Text('Arah')),
                                    Text(item['arah'] ?? ''),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(child: Text('Jarak')),
                                    Text(item['jarak'] ?? ''),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(child: Text('Jenis Amunisi')),
                                    Text(item['jenis'] ?? ''),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
