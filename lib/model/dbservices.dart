class Motor {
  String? id_motor; // Tambahkan properti id_motor
  final String deskripsi;
  final String dryWeight;
  final String engine;
  final String frontSuspension;
  final String fuelSystem;
  final String gearbox;
  final String harga;
  final String image;
  final String merek;
  final String power;
  final String seri;
  final String tahun;
  final String tipe;

  Motor({
    required this.id_motor, // Inisialisasi properti id_motor dalam konstruktor
    required this.deskripsi,
    required this.dryWeight,
    required this.engine,
    required this.frontSuspension,
    required this.fuelSystem,
    required this.gearbox,
    required this.harga,
    required this.image,
    required this.merek,
    required this.power,
    required this.seri,
    required this.tahun,
    required this.tipe,
  });

  factory Motor.fromJson(Map<String, dynamic> json) {
    return Motor(
      id_motor: json['id_motor'],
      deskripsi: json['deskripsi'],
      dryWeight: json['dryweight'],
      engine: json['engine'],
      frontSuspension: json['frontsuspension'],
      fuelSystem: json['fuelsystem'],
      gearbox: json['gearbox'],
      harga: json['harga'],
      image: json['image'],
      merek: json['merek'],
      power: json['power'],
      seri: json['seri'],
      tahun: json['tahun'],
      tipe: json['tipe'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_motor': id_motor,
      'deskripsi': deskripsi,
      'dryweight': dryWeight,
      'engine': engine,
      'frontsuspension': frontSuspension,
      'fuelsystem': fuelSystem,
      'gearbox': gearbox,
      'harga': harga,
      'image': image,
      'merek': merek,
      'power': power,
      'seri': seri,
      'tahun': tahun,
      'tipe': tipe,
    };
  }
}

class Favorite {
  final String idMotor;
  final String idUser;

  Favorite({
    required this.idMotor,
    required this.idUser,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      idMotor: json['id_motor'],
      idUser: json['id_user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_motor': idMotor,
      'id_user': idUser,
    };
  }
}

class MyUser {
  final String nama;
  final String email;
  final String noTlp;
  final String alamat;
  final String kategori;

  MyUser({
    required this.nama,
    required this.email,
    required this.noTlp,
    required this.alamat,
    required this.kategori,
  });

  Map<String, dynamic> toJson() {
    return {
      "nama": nama,
      "email": email,
      "noTlp": noTlp,
      "alamat": alamat,
      "kategori": kategori,
    };
  }

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
      nama: json["nama"],
      email: json["email"],
      noTlp: json["noTlp"],
      alamat: json["alamat"],
      kategori: json["kategori"],
    );
  }
}
