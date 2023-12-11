import 'package:flutter/material.dart';
import 'package:motor/detail_page.dart';
import 'package:motor/model/dataclass.dart';
import 'package:motor/model/dbservices.dart';
import 'package:firebase_auth/firebase_auth.dart';

class favorite_page extends StatefulWidget {
  const favorite_page({Key? key}) : super(key: key);

  @override
  State<favorite_page> createState() => _favorite_pageState();
}

class _favorite_pageState extends State<favorite_page> {
  List<Motor> favoriteMotors = [];
  // Motor? motor;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Panggil method getBookingsByFilmAndWaktu
    final mt = await Database.getFavoriteMotors(_auth.currentUser?.email ?? "");

    setState(() {
      favoriteMotors = mt;
    });
    print("TESSSSSSSSSSSSSSSSSS");
    print(favoriteMotors);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 128, 0),
        title: Text('Favorite Motor',
            style: TextStyle(fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false, // Ini akan menyembunyikan tombol back
      ),
      body: ListView.builder(
        itemCount: favoriteMotors.length,
        itemBuilder: (context, index) {
          Motor motor = favoriteMotors[index];
          String? motorId = motor.id_motor;
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Detail(idMotor: motorId ?? ""),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    imagee(motor.image),
                    SizedBox(width: 10),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 2),
                                Text(
                                  motor.seri,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 128, 0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    motor.merek,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 30, 0, 0),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  motor.deskripsi,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container imagee(String imageUrl) {
    return Container(
      height: 130,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
