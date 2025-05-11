import 'package:flutter/material.dart';

class InformasiPerangkatPage extends StatefulWidget {
  final VoidCallback onClose;

  const InformasiPerangkatPage({Key? key, required this.onClose})
      : super(key: key);

  @override
  _InformasiPerangkatPageState createState() => _InformasiPerangkatPageState();
}

class _InformasiPerangkatPageState extends State<InformasiPerangkatPage> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: 500, // Dialog width
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFF212121), // Dark background
          border: Border.all(
            color: Color(0xFFFFEB3B), // Yellow border
            width: 2, // Border width
          ),
        ),
        child: Stack(
          children: [
            // Wrapping the main content in a SingleChildScrollView
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center the content
                children: [
                  // Title with a seamless yellow border on the bottom and sides
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFFFEB3B), // Yellow border for bottom
                          width: 2, // Border thickness
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center title
                      children: [
                        Text(
                          'Informasi Perangkat',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Aplikasi Sisbak Section
                  _buildSectionTitle('Aplikasi Sisbak'),
                  _buildInfoRow('Aplikasi Sisbak', ':'),
                  _buildInfoRow('Build Number', ': 25.02.13 15:57:35'),

                  SizedBox(height: 20),
                  // Unit Display Section
                  _buildSectionTitle('Unit Display'),
                  _buildInfoRow('OS Versi', ': 8.1.0'),
                  _buildInfoRow('Layar', ': OPM1.171019.026release-keys'),
                  _buildInfoRow('Resolusi', ': {2070, 1080}'),
                  _buildInfoRow('Kapasitif', ': Capacitive Multi Touch'),
                  _buildInfoRow('Antarmuka', ': T91EUE1'),
                  _buildInfoRow('Versi Incremental', ': T91_4.4.1'),
                  _buildInfoRow('SDK', ': 27'),
                  _buildInfoRow('Board', ': sdm945'),
                  _buildInfoRow('User', ': Root'),

                  // Additional Information from the first image (example text)
                  SizedBox(height: 20),
                  _buildSectionTitle('Unit Kontrol'),
                  _buildInfoRow('Kernel', ': Linux 4.14,78-hdte-k100+'),
                  _buildInfoRow('Arsitektur', ': armv71'),
                  _buildInfoRow('Processor', ': armv71'),
                  _buildInfoRow('RAM', ': 516 MB'),
                  _buildInfoRow('Penyimpanan Internal', ': 3660771'),
                  _buildInfoRow('Status', ': Aktif'),

                  // Adding the missing "Status Sensor" section next to the button
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Status Sensor',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 20), // Space between label and button
                      ElevatedButton(
                        onPressed: () {
                          // Action for the Status Sensor button
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 255,
                              255), // Yellow background for button
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Status Sensor',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Positioned OK Button at the bottom-right
            Positioned(
              bottom: 10,
              right: 10,
              child: ElevatedButton(
                onPressed: widget.onClose, // Close the dialog
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.yellow, // Yellow background for button
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  // Method to create information rows
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center align the text
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
