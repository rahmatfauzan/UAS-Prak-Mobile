import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motor/login.dart';
import 'package:motor/model/dataclass.dart';
import 'package:motor/model/dbservices.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MyUser? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      final email = user.email;
      if (email != null) {
        final myUser = await Database.getUser(email: email);
        if (myUser != null) {
          setState(() {
            _currentUser = myUser;
          });
        }
      }
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Tambahkan Center di sini
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Pusatkan vertikal
            crossAxisAlignment:
                CrossAxisAlignment.center, // Pusatkan horizontal
            children: [
              const SizedBox(height: 40),
              if (_currentUser != null)
                CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(
                      "https://i.pinimg.com/736x/97/26/08/972608c82bd561312153a3d36a6f0bef.jpg"),
                ),
              const SizedBox(height: 20),
              if (_currentUser == null)
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 6.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                )
              else
                Column(
                  children: [
                    Text(
                      _currentUser?.nama ?? "",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 128, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'OpenSans'),
                    ),
                    Text(
                      _currentUser?.email ?? "",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontFamily: 'OpenSans'),
                    ),
                  ],
                ),
              if (_currentUser != null)
                ElevatedButton(
                  onPressed: () {
                    _auth.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    minimumSize: MaterialStateProperty.all<Size>(Size(50, 30)),
                  ),
                  child: Text('Log Out'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
