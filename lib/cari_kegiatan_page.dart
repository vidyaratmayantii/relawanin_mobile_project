import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class carikegiatan extends StatefulWidget {
  const carikegiatan({super.key});

  @override
  State<carikegiatan> createState() => _carikegiatanState();
}

class _carikegiatanState extends State<carikegiatan> {
  int itemCount = 5;
  bool _isLoading = false;
  ScrollController _scrollController = ScrollController();

  List<DocumentSnapshot> activities = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
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

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('activities').get();
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
              child: ListView.builder(
                controller: _scrollController,
                itemCount: activities.length < itemCount ? activities.length : itemCount,
                itemBuilder: (context, index) {
                  if (index >= activities.length) {
                    return Center(child: CircularProgressIndicator());
                  }
                  var doc = activities[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(doc['imageUrl'],
                              height: 190, width: 349, fit: BoxFit.contain),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 11),
                            child: Text(doc['namaKegiatan'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(doc['aktivitasKegiatan'],
                                style: TextStyle(fontSize: 12)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 13, left: 13),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_month_outlined,
                                    color: Color.fromRGBO(0, 137, 123, 1)),
                                Text(doc['tanggalKegiatan'],
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 9, left: 13),
                            child: Row(
                              children: [
                                Icon(Icons.pin_drop_rounded,
                                    color: Color.fromRGBO(0, 137, 123, 1)),
                                Text(doc['lokasi'],
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          )
                        ],
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
