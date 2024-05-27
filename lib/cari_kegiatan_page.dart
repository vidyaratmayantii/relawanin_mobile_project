import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class carikegiatan extends StatefulWidget {
  final String searchQuery;
  const carikegiatan({super.key, required this.searchQuery});

  @override
  State<carikegiatan> createState() => _carikegiatanState();
}

class _carikegiatanState extends State<carikegiatan> {
  int itemCount = 5;
  bool _isLoading = false;
  bool _isEmpty = false;
  ScrollController _scrollController = ScrollController();

  List<DocumentSnapshot> activities = [];
  List<DocumentSnapshot> filteredActivities = [];

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
      _filterData();
      _isLoading = false;
    });
  }

  void _filterData() {
    List<DocumentSnapshot> _filtered = activities
        .where((doc) => doc['namaKegiatan']
            .toLowerCase()
            .contains(widget.searchQuery.toLowerCase()))
        .toList();
    setState(() {
      filteredActivities = _filtered;
      _isEmpty = filteredActivities.isEmpty;
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
    _filterData(); // Call filter function whenever build method is called

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
                      itemCount: filteredActivities.length < itemCount ? filteredActivities.length : itemCount,
                      itemBuilder: (context, index) {
                        if (index >= filteredActivities.length) {
                          return Center(child: CircularProgressIndicator());
                        }
                        var doc = filteredActivities[index];
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
