import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motor/model/dataclass.dart';
import 'package:motor/model/dbservices.dart';

class Detail extends StatefulWidget {
  Detail({required this.idMotor});
  final String idMotor;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late Stream<DocumentSnapshot<Map<String, dynamic>>> motorStream;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Future<bool> isFavorite;

  @override
  void initState() {
    super.initState();
    motorStream = FirebaseFirestore.instance
        .collection('motorcycle')
        .doc(widget.idMotor)
        .snapshots();
    refreshFavoriteStatus();
  }

// Function to refresh the favorite status
  Future<void> refreshFavoriteStatus() async {
    setState(() {
      isFavorite = Database.cekFavorite(
          idMotor: widget.idMotor, idUser: _auth.currentUser?.email ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    void toggleFavoriteStatus() async {
      if (await isFavorite) {
        // Handle logic for when it is a favorite
        String? idFavorite = await Database.ambilFavorite(
            idMotor: widget.idMotor, idUser: _auth.currentUser?.email ?? "");
        await Database.deletefavorite(idMotor: idFavorite ?? "");
      } else {
        Favorite suka = Favorite(
            idMotor: widget.idMotor, idUser: _auth.currentUser?.email ?? "");
        await Database.tambahfavorite(fv: suka);
      }
      // Refresh the favorite status after the user interaction
      refreshFavoriteStatus();
    }

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: motorStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Text("Motor not found.");
          }

          Map<String, dynamic> motorData = snapshot.data!.data()!;
          String image = motorData['image'] ?? '';
          String seri = motorData['seri'] ?? '';
          String merek = motorData['merek'] ?? '';
          String tahun = motorData['tahun'] ?? '';
          String harga =
              motorData['harga'] != null ? '${motorData['harga']}' : '';
          String deskripsi = motorData['deskripsi'] ?? '';
          String engine = motorData['engine'] ?? '';
          String power = motorData['power'] ?? '';
          String tipe = motorData['tipe'] ?? '';
          String gearbox = motorData['gearbox'] ?? '';
          String fuelSystem = motorData['fuelsystem'] ?? '';
          String frontSuspension = motorData['frontsuspension'] ?? '';
          String dryWeight = motorData['dryweight'] ?? '';

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      child: Image(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 20, // Adjust the position as needed
                      left: 8, // Adjust the position as needed
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                          size: 30,
                          // You can adjust the size and other properties as needed
                        ),
                        onPressed: () {
                          // Handle back button press
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: width,
                        height: 50,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16), // Adjust padding as needed
                        color: Colors.black
                            .withOpacity(0.6), // Adjust opacity as needed
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                seri,
                                style: TextStyle(
                                  color: Color(0xFFE1EFFF),
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'roboto',
                                ),
                              ),
                            ),
                            Container(
                              child: IconButton(
                                icon: FutureBuilder<bool>(
                                  future: isFavorite,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Icon(Icons.favorite,
                                          color: Colors.grey,
                                          size: 40); // Set a fixed size
                                    } else {
                                      return Icon(
                                        Icons.favorite,
                                        color: snapshot.data ?? false
                                            ? Colors.red
                                            : Colors.grey,
                                        size: 40,
                                      );
                                    }
                                  },
                                ),
                                onPressed: () {
                                  toggleFavoriteStatus();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 14),
                Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      detail(Color.fromARGB(255, 255, 128, 0), "Merek", merek,
                          "image/motor-icon.png"),
                      detail(Color.fromARGB(255, 255, 128, 0), "Keluaran",
                          tahun, "image/schedule_3652191.png"),
                      detail(Color.fromARGB(255, 255, 128, 0), "Harga", harga,
                          "image/price-icon.png")
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey, // Warna garis
                          width: 1.0, // Lebar garis
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      deskripsi,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: Text(
                    "Spesifikasi Lengkap",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataTable(
                  columnSpacing: 120,
                  headingRowColor: MaterialStateColor.resolveWith((states) =>
                      Color.fromARGB(255, 255, 128,
                          0)), // Warna latar belakang untuk baris judul

                  columns: [
                    DataColumn(label: Text('Spesifikasi')),
                    DataColumn(label: Text('Detail')),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text("Engine")),
                      DataCell(Text(engine)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Power")),
                      DataCell(Text(power)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Tipe")),
                      DataCell(Text(tipe)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Gearbox")),
                      DataCell(Text(gearbox)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Fuel System")),
                      DataCell(Text(fuelSystem)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Front Suspension")),
                      DataCell(Text(frontSuspension)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Dry Weight")),
                      DataCell(Text(dryWeight)),
                    ]),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Container detail(Color warna, String isi, String detail, String urlImage) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    isi,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    detail,
                    style: TextStyle(
                      color: warna,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
