import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailBeritaPage extends StatefulWidget {
  final DocumentSnapshot? berita;
  final String? docId;

  const DetailBeritaPage({Key? key, this.berita, this.docId}) : super(key: key);

  @override
  _DetailBeritaPageState createState() => _DetailBeritaPageState();
}

class _DetailBeritaPageState extends State<DetailBeritaPage> {
  final CollectionReference _beritaCollection = FirebaseFirestore.instance.collection('berita');
  Map<String, dynamic>? _data;
  List<DocumentSnapshot>? _beritaLainnya;

  @override
  void initState() {
    super.initState();
    if (widget.berita != null) {
      setState(() {
        _data = widget.berita!.data() as Map<String, dynamic>?;
      });
    } else if (widget.docId != null) {
      _fetchDataById(widget.docId!);
    }
    _fetchBeritaLainnya();
  }

  void _fetchDataById(String docId) async {
    DocumentSnapshot doc = await _beritaCollection.doc(docId).get();
    setState(() {
      _data = doc.data() as Map<String, dynamic>?;
    });
  }

  void _fetchBeritaLainnya() async {
    QuerySnapshot querySnapshot = await _beritaCollection.get();
    setState(() {
      _beritaLainnya = querySnapshot.docs.toList(); 
    });
  }

  Widget _buildImage(String imageData) {
    if (imageData.startsWith('data:image')) {
      // Handle base64 image
      final UriData data = Uri.parse(imageData).data!;
      Uint8List bytes = data.contentAsBytes();
      return Image.memory(bytes, fit: BoxFit.cover);
    } else {
      // Handle network image
      return Image.network(imageData, fit: BoxFit.cover);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: const Color(0xFF00897B),
          flexibleSpace: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/logo.png',
                height: 150,
              ),
            ),
          ),
        ),
      ),
      body: _data == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: 241,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(_data!['img']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 250),
                        Text(
                          _data!['judul'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _data!['sumber'],
                          style: const TextStyle(
                            color: Color(0xFF00897B),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _data!['isi'],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Berita Lainnya',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _beritaLainnya == null
                            ? Center(child: CircularProgressIndicator())
                            : SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _beritaLainnya!.length,
                                  itemBuilder: (context, index) {
                                    var berita = _beritaLainnya![index].data() as Map<String, dynamic>;
                                    String docId = _beritaLainnya![index].id;
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailBeritaPage(
                                              berita: _beritaLainnya![index],
                                              docId: docId,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Card(
                                        child: SizedBox(
                                          width: 150,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              _buildImage(berita['img']),
                                              const SizedBox(height: 8),
                                              Text(
                                                berita['judul'],
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                        const SizedBox(height: 250),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
