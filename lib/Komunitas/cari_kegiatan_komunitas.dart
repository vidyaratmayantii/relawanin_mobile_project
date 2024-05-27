import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:relawanin_mobile_project/DetailKegiatan/DetailKegiatan.dart';

class CariKegiatanKomunitas extends StatefulWidget {
  const CariKegiatanKomunitas({super.key});

  @override
  State<CariKegiatanKomunitas> createState() => _CariKegiatanKomunitasState();
}

class _CariKegiatanKomunitasState extends State<CariKegiatanKomunitas> {
  int itemCount = 5;
  bool _isLoading = false;
  bool _isEmpty = false;
  ScrollController _scrollController = ScrollController();
  List<DocumentSnapshot> activities = [];
  User? currentUser;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading) {
      _loadMoreData();
    }
  }

  Future<void> _fetchCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      currentUser = user;
    });
    _fetchData();
  }

  Future<void> _fetchData() async {
    if (currentUser == null) return;

    setState(() {
      _isLoading = true;
    });

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('activities')
        .where('userId', isEqualTo: currentUser!.uid)
        .get();

    setState(() {
      activities = querySnapshot.docs;
      _isLoading = false;
    });
  }

  Future<void> _loadMoreData() async {
    setState(() {
      _isLoading = true;
    });
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      itemCount += 5;
      _isLoading = false;
    });
  }

  Future<void> _refresh() async {
    setState(() {
      _isLoading = true;
    });
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));
    // Re-fetch the data
    await _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: _isEmpty
                  ? Center(child: Text("Tidak ada kegiatan tersedia"))
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: activities.length < itemCount
                          ? activities.length
                          : itemCount,
                      itemBuilder: (context, index) {
                        if (index >= activities.length) {
                          return Center(child: CircularProgressIndicator());
                        }
                        var doc = activities[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailKegiatan(
                                      activityData:
                                          doc.data() as Map<String, dynamic>),
                                ),
                              );
                            },
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(doc['imageUrl'],
                                      height: 190,
                                      width: 349,
                                      fit: BoxFit.contain),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, top: 11),
                                    child: Text(doc['namaKegiatan'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Text(doc['aktivitasKegiatan'],
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 13, left: 13),
                                    child: Row(
                                      children: [
                                        Icon(Icons.calendar_month_outlined,
                                            color:
                                                Color.fromRGBO(0, 137, 123, 1)),
                                        Text(doc['tanggalKegiatan'],
                                            style: TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 9, left: 13),
                                    child: Row(
                                      children: [
                                        Icon(Icons.pin_drop_rounded,
                                            color:
                                                Color.fromRGBO(0, 137, 123, 1)),
                                        Text(doc['lokasi'],
                                            style: TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
          if (_isLoading) Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
