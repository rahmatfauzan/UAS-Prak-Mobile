import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motor/home.dart';
import 'package:motor/model/FirebaseAuthService.dart'; // Sesuaikan dengan struktur folder dan nama file model

class TambahDataPage extends StatefulWidget {
  const TambahDataPage({Key? key}) : super(key: key);

  @override
  _TambahDataPageState createState() => _TambahDataPageState();
}

class _TambahDataPageState extends State<TambahDataPage> {
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController dryWeightController = TextEditingController();
  final TextEditingController engineController = TextEditingController();
  final TextEditingController frontSuspensionController =
      TextEditingController();
  final TextEditingController fuelSystemController = TextEditingController();
  final TextEditingController gearboxController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController merekController = TextEditingController();
  final TextEditingController powerController = TextEditingController();
  final TextEditingController seriController = TextEditingController();
  final TextEditingController tahunController = TextEditingController();
  final TextEditingController tipeController = TextEditingController();

  final CollectionReference motorCollection = FirebaseFirestore.instance
      .collection('motorcycle'); // Sesuaikan dengan nama koleksi di Firestore

  Future<void> tambahDataMotor() async {
    try {
      await motorCollection.add({
        'deskripsi': deskripsiController.text,
        'dryweight': dryWeightController.text,
        'engine': engineController.text,
        'frontsuspension': frontSuspensionController.text,
        'fuelsystem': fuelSystemController.text,
        'gearbox': gearboxController.text,
        'harga': hargaController.text,
        'image': imageController.text,
        'merek': merekController.text,
        'power': powerController.text,
        'seri': seriController.text,
        'tahun': tahunController.text,
        'tipe': tipeController.text,
      });

      // Setelah tambah data, kembalikan ke halaman sebelumnya
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    } catch (e) {
      print('Error tambah data motor: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data Motor'),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 128, 0),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: deskripsiController,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            TextField(
              controller: dryWeightController,
              decoration: InputDecoration(labelText: 'Dry Weight'),
            ),
            TextField(
              controller: engineController,
              decoration: InputDecoration(labelText: 'Engine'),
            ),
            TextField(
              controller: frontSuspensionController,
              decoration: InputDecoration(labelText: 'Front Suspension'),
            ),
            TextField(
              controller: fuelSystemController,
              decoration: InputDecoration(labelText: 'Fuel System'),
            ),
            TextField(
              controller: gearboxController,
              decoration: InputDecoration(labelText: 'Gearbox'),
            ),
            TextField(
              controller: hargaController,
              decoration: InputDecoration(labelText: 'Harga'),
            ),
            TextField(
              controller: imageController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: merekController,
              decoration: InputDecoration(labelText: 'Merek'),
            ),
            TextField(
              controller: powerController,
              decoration: InputDecoration(labelText: 'Power'),
            ),
            TextField(
              controller: seriController,
              decoration: InputDecoration(labelText: 'Seri'),
            ),
            TextField(
              controller: tahunController,
              decoration: InputDecoration(labelText: 'Tahun'),
            ),
            TextField(
              controller: tipeController,
              decoration: InputDecoration(labelText: 'Tipe'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: tambahDataMotor,
              child: Text('Tambah Data'),
            ),
          ],
        ),
      ),
    );
  }
}
