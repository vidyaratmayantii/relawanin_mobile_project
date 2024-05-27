import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:relawanin_mobile_project/Komunitas/dashboard_komunitas.dart';
import 'package:relawanin_mobile_project/Komunitas/pageSearchKomunitas.dart';
import 'package:relawanin_mobile_project/Komunitas/profileKomunitas_page.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Simpan notifikasi ke Firestore saat aplikasi di background
  if (message.notification != null) {
    await FirebaseFirestore.instance.collection('notifications').add({
      'title': message.notification!.title,
      'body': message.notification!.body,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationPageKomunitas(),
    );
  }
}

class NotificationPageKomunitas extends StatefulWidget {
  @override
  _NotificationPageKomunitasState createState() =>
      _NotificationPageKomunitasState();
}

class _NotificationPageKomunitasState extends State<NotificationPageKomunitas> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    // Mendapatkan token FCM
    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      print("FCM Token: $token");
      // Simpan token ke Firestore
      FirebaseFirestore.instance.collection('tokens').add({
        'token': token,
        'createdAt': FieldValue.serverTimestamp(),
      });
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message: ${message.notification?.title}');
      // Simpan notifikasi ke Firestore hanya jika aplikasi berada di foreground
      if (message.notification != null) {
        FirebaseFirestore.instance.collection('notifications').add({
          'title': message.notification!.title,
          'body': message.notification!.body,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Tangani notifikasi ketika aplikasi dibuka dari keadaan background
      print('Message clicked!');
      // Tidak perlu menyimpan notifikasi di sini karena sudah ditangani
      // oleh onMessage dan onBackgroundMessage
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF00897B),
      ),
      body: _buildNotificationList(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color(0xFF00897B),
        onTap: (int index) {
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePageKomunitas()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pageSearchKomunitas()),
            );
          } else if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardKomunitas()),
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
    );
  }

  Widget _buildNotificationList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('notifications')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: snapshot.data!.docs.map((doc) {
            return ListTile(
              title: Text(doc['title']),
              subtitle: Text(doc['body']),
              leading: Icon(Icons.notifications),
              onTap: () {
                // Tambahkan logika untuk menangani ketika notifikasi diklik
                // Contohnya bisa menampilkan detail notifikasi atau membuka halaman terkait notifikasi
              },
            );
          }).toList(),
        );
      },
    );
  }
}

class NotificationModel {
  final String title;
  final String body;

  NotificationModel({required this.title, required this.body});
}
