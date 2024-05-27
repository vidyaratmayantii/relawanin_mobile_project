import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/Komunitas/dashboard_komunitas.dart';
import 'package:relawanin_mobile_project/Komunitas/editProfileKomunitas_page.dart';
import 'package:relawanin_mobile_project/Komunitas/notificationKomunitas_page.dart';
import 'package:relawanin_mobile_project/Komunitas/riwayatKomunitas_page.dart';
import 'package:relawanin_mobile_project/Komunitas/tentangkamiKomunitas_page.dart';
import 'package:relawanin_mobile_project/Authenticator/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:relawanin_mobile_project/SQLite/sqlite.dart';

class ProfilePageKomunitas extends StatefulWidget {
  const ProfilePageKomunitas({super.key});

  @override
  _ProfilePageKomunitasState createState() => _ProfilePageKomunitasState();
}

class _ProfilePageKomunitasState extends State<ProfilePageKomunitas> {
  File? _profilePic;
  String displayName = '';

  @override
  void initState() {
    super.initState();
    fetchUserName();
    _loadProfilePic();
  }

  Future<void> _loadProfilePic() async {
    String? profilePicPath = await DatabaseHelper().getProfilePic();
    if (profilePicPath != null) {
      setState(() {
        _profilePic = File(profilePicPath);
      });
    }
  }

  void _onProfilePicChanged() {
    setState(() {
      _loadProfilePic();
    });
  }

  Future<void> fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        displayName = userDoc['username'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: const Color(0xFF00897B),
            automaticallyImplyLeading: false,
            flexibleSpace: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipOval(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: _profilePic == null
                          ? DecorationImage(
                              image:
                                  AssetImage('assets/default_profile_pic.png'),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: FileImage(_profilePic!),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  displayName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0xFF00897B),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '50 Poin Terkumpul',
                        style: TextStyle(color: Colors.white),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Tukarkan',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF00897B),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Divider(),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit Profil'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePageKomunitas(
                          onProfilePicChanged: _onProfilePicChanged,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text('Riwayat'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RiwayatKomunitas()),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Tentang Kami'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TentangKamiKomunitas()),
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Keluar',
                    style: TextStyle(color: Colors.red), // warna teks
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 3,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Color(0xFF00897B),
          onTap: (int index) {
            if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePageKomunitas()),
              );
            } else if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardKomunitas()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationPageKomunitas()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationPageKomunitas()),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
