import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'pageSearch.dart';
import 'dashboard_page.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications',
        style: TextStyle(
              color: Colors.white,
              fontSize: 20,    
              fontWeight: FontWeight.bold,
            ),),
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
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const pageSearch()),
              );
            } else if (index == 0){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DashboardPage()),
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
    return ListView.builder(
      itemCount: _notifications.length, 
      itemBuilder: (context, index) {
        final notification = _notifications[index]; 

        return ListTile(
          title: Text(notification.title),
          subtitle: Text(notification.body),
          leading: Icon(Icons.notifications), 
          onTap: () {
            // Tambahkan logika untuk menangani ketika notifikasi diklik
            // Contohnya bisa menampilkan detail notifikasi atau membuka halaman terkait notifikasi
          },
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

List<NotificationModel> _notifications = [
  NotificationModel(
    title: 'New Message',
    body: 'You have received a new message.',
  ),
  NotificationModel(
    title: 'Reminder',
    body: 'Don\'t forget your appointment tomorrow!',
  ),
  NotificationModel(
    title: 'Alert',
    body: 'High priority alert.',
  ),
];
