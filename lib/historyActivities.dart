import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('activities').snapshots(),
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
                      builder: (context) => DetailActivity(activity: activity),
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
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

class DetailActivity extends StatelessWidget {
  final QueryDocumentSnapshot activity;

  const DetailActivity({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(activity['namaKegiatan'] ?? 'No name'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nama Kegiatan: ${activity['namaKegiatan'] ?? 'N/A'}'),
            Text('Batas Registrasi: ${activity['batasRegistrasi'] ?? 'N/A'}'),
            Text('Lokasi: ${activity['lokasi'] ?? 'N/A'}'),
            Text('Waktu Pelaksanaan: ${activity['tanggalKegiatan'] ?? 'N/A'}'),
          ],
        ),
      ),
    );
  }
}
