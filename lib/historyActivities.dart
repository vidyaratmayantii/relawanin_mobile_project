import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:relawanin_mobile_project/editActivity.dart';

import 'DetailKegiatan/DetailKegiatan.dart';

class MyActivitiesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Activities'),
      ),
      body: MyActivitiesListView(),
    );
  }
}

class MyActivitiesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dapatkan UID pengguna yang saat ini masuk
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('activities')
          .where('userId', isEqualTo: uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text('No activities found'),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var activity = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailKegiatan(activityData: activity.data() as Map<String, dynamic>),
                    ),
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text(activity['namaKegiatan'] ?? 'No name'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Batas Registrasi: ${activity['batasRegistrasi'] ?? 'N/A'}'),
                        Text('Lokasi: ${activity['lokasi'] ?? 'N/A'}'),
                        Text('Waktu Pelaksanaan: ${activity['tanggalKegiatan'] ?? 'N/A'}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Handle logic for updating activity
                            _updateActivity(context, activity);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteActivity(context, activity);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  void _updateActivity(BuildContext context, DocumentSnapshot activity) {
  // Buka layar formulir untuk memperbarui aktivitas
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditActivityForm(activity: activity),
    ),
  );
}

  void _deleteActivity(BuildContext context, DocumentSnapshot activity) async {
  try {
    // Dapatkan URL gambar dari dokumen aktivitas
    String? imageUrl = activity['imageUrl'];

    // Hapus dokumen aktivitas dari Firestore
    await FirebaseFirestore.instance
        .collection('activities')
        .doc(activity.id)
        .delete();

    // Jika terdapat URL gambar, hapus juga gambar dari Firebase Storage
    if (imageUrl != null) {
      await FirebaseStorage.instance.refFromURL(imageUrl).delete();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Activity deleted successfully')),
    );
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to delete activity: $error')),
    );
  }
}

}


