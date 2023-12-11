import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motor/model/dbservices.dart';

CollectionReference tblMotor =
    FirebaseFirestore.instance.collection("motorcycle");
CollectionReference tblfavorites =
    FirebaseFirestore.instance.collection("favorites");
CollectionReference tblUser = FirebaseFirestore.instance.collection("user");

class Database {
  // ------------- METHOD TAMPIL SEMUA DATA -------------
  static Stream<QuerySnapshot> getData() {
    return tblMotor.snapshots();
  }

  // ------------- METHOD TAMPIL DATA FILTER-------------
  static Future<Map<String, dynamic>?> getMotorById(String motorId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await tblMotor
          .doc(motorId)
          .get() as DocumentSnapshot<Map<String, dynamic>>;

      if (documentSnapshot.exists) {
        // Dokumen ditemukan, kembalikan data
        return {
          'id': documentSnapshot.id,
          ...documentSnapshot.data()!,
        };
      } else {
        // Dokumen tidak ditemukan
        return null;
      }
    } catch (e) {
      print("Error getting motor by ID: $e");
      return null;
    }
  }

  static Future<void> tambahfavorite({required Favorite fv}) async {
    DocumentReference docref = tblfavorites.doc();
    await docref
        .set(fv.toJson())
        .whenComplete(() => "favorite berhasil")
        .catchError((e) => print(e));
  }

  static Future<bool> cekFavorite({
    required String idMotor,
    required String idUser,
  }) async {
    try {
      QuerySnapshot querySnapshot = await tblfavorites
          .where('id_motor', isEqualTo: idMotor)
          .where('id_user', isEqualTo: idUser)
          .get();

      // Check if there is at least one document in the result
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking favorite: $e");
      // Handle the error as needed
      return false;
    }
  }

  static Future<String?> ambilFavorite({
    required String idMotor,
    required String idUser,
  }) async {
    try {
      QuerySnapshot querySnapshot = await tblfavorites
          .where('id_motor', isEqualTo: idMotor)
          .where('id_user', isEqualTo: idUser)
          .get();

      // Check if there is at least one document in the result
      if (querySnapshot.docs.isNotEmpty) {
        // Return the document ID of the first matching document
        return querySnapshot.docs.first.id;
      } else {
        // Return null if no matching document is found
        return null;
      }
    } catch (e) {
      print("Error checking favorite: $e");
      // Handle the error as needed
      return null;
    }
  }

  static Future<void> deletefavorite({required String idMotor}) async {
    DocumentReference docRef = tblfavorites.doc(idMotor);
    try {
      await docRef.delete();
      print("Delete berhasil");
    } catch (e) {
      print("Error saat menghapus data favorite: $e");
      throw e;
    }
  }

  static Future<MyUser> getUser({required String email}) async {
    QuerySnapshot querySnapshot =
        await tblUser.where("email", isEqualTo: email).get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot docSnapshot = querySnapshot.docs.first;
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      return MyUser.fromJson(data); // Sesuaikan dengan model data pengguna Anda
    } else {
      throw Exception("Data dengan email $email tidak ditemukan");
    }
  }

  static Future<void> tambahUser({required MyUser user}) async {
    DocumentReference docref = tblUser.doc(user.email);
    await docref
        .set(user.toJson())
        .whenComplete(() => "Pengguna berhasil ditambahkan")
        .catchError((e) => print(e));
  }

  static Future<List<Motor>> getFavoriteMotors(String userId) async {
    List<Motor> favoriteMotors = [];

    QuerySnapshot favoriteSnapshot =
        await tblfavorites.where('id_user', isEqualTo: userId).get();
    print(userId);

    for (QueryDocumentSnapshot favoriteDoc in favoriteSnapshot.docs) {
      String motorId = favoriteDoc['id_motor'];
      DocumentSnapshot motorSnapshot = await tblMotor.doc(motorId).get();

      if (motorSnapshot.exists) {
        Map<String, dynamic> data =
            motorSnapshot.data() as Map<String, dynamic>;
        Motor motor = Motor.fromJson(data);

        // Tambahkan id_motor ke objek Motor setelah objek Motor ditambahkan ke daftar
        favoriteMotors.add(motor);
        favoriteMotors.last.id_motor = motorId;
      }
    }

    print(favoriteMotors);
    return favoriteMotors;
  }

  static Stream<QuerySnapshot> getDataByBrand(String brand) {
    return tblMotor.where('merek', isEqualTo: brand).snapshots();
  }
}
