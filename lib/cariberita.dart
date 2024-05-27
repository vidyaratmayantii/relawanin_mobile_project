import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'detailberita_page.dart'; // Import your DetailBeritaPage

class cariberita extends StatefulWidget {
  const cariberita({super.key});

  @override
  State<cariberita> createState() => _cariberitaState();
}

class _cariberitaState extends State<cariberita> {
  int itemCount = 8;
  bool _isLoading = false;
  bool _isEmpty = false;
  final ScrollController _scrollController = ScrollController();

  List<DocumentSnapshot> berita = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchData();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading) {
      setState(() {
        _isLoading = true;
      });
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            itemCount += 8;
            _isLoading = false;
          });
        }
      });
    }
  }

  Future<void> _fetchData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('berita').get();
    setState(() {
      berita = querySnapshot.docs;
      _isEmpty = berita.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 13),
            child: Text(
              "Teratas saat ini",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: _isEmpty
                  ? Center(child: Text("Tidak ada berita yang tersedia"))
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: itemCount + (_isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == itemCount && _isLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (index >= berita.length) {
                          return Container(); // Prevent out of range error
                        }
                        var doc = berita[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailBeritaPage(
                                    berita: doc,
                                    docId: doc.id,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(doc['img'],
                                      height: 190,
                                      width: 349,
                                      fit: BoxFit.contain),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16, top: 11),
                                    child: Text(doc['judul'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16, bottom: 10),
                                    child: Text(doc['sumber'],
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    if (mounted) {
      setState(() {
        itemCount += 5;
        _fetchData();
      });
    }
  }
}
