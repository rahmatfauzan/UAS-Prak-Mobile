import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motor/detail_page.dart';
import 'package:motor/model/dataclass.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var height, width;
  String selectedBrand = 'ALL';

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: width,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('image/coba.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: Text(
                        "BIKE INFO",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          decoration: TextDecoration.none,
                          fontFamily: 'roboto',
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(2.0, 2.0),
                              blurRadius: 15.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 269,
                left: 0,
                child: Container(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  width: width,
                  height: height - 269,
                  decoration: BoxDecoration(
                    color: Color(0xFFE1EFFF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            buildCategoryItem('ALL'),
                            buildCategoryItem('Kawasaki'),
                            buildCategoryItem('Yamaha'),
                            buildCategoryItem('Honda'),
                            buildCategoryItem('Ducati'),
                            buildCategoryItem('Zero'),
                            buildCategoryItem('Husqvarna'),
                            buildCategoryItem('Suzuki'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: selectedBrand == 'ALL'
                              ? Database
                                  .getData() // Call your new method for 'ALL'
                              : Database.getDataByBrand(selectedBrand),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    const Color.fromARGB(115, 206, 43, 43),
                                  ),
                                ),
                              );
                            } else if (snapshot.hasData) {
                              List<DocumentSnapshot> items =
                                  snapshot.data!.docs.toList();
                              print(items);

                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot mt = items[index];
                                  String lvimage = mt["image"];
                                  String lvseri = mt["seri"];
                                  String lvmerek = mt["merek"];
                                  String lVdetail = mt["deskripsi"];
                                  String documentId = mt.id;
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Detail(idMotor: documentId),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            imagee(lvimage),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(height: 2),
                                                        Text(
                                                          lvseri,
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    128,
                                                                    0),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        SizedBox(height: 2),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          child: Text(
                                                            lvmerek,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color
                                                                  .fromARGB(255,
                                                                      30, 0, 0),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 2),
                                                        Text(
                                                          lVdetail,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w400,
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
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  const Color.fromARGB(115, 206, 43, 43),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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

  Widget buildCategoryItem(String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBrand = category;
        });
      },
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: category == selectedBrand
              ? Color.fromARGB(255, 255, 128, 0)
              : Colors.white60,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            category,
            style: TextStyle(
              color: category == selectedBrand
                  ? Colors.white
                  : Color.fromARGB(255, 51, 77, 169),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
