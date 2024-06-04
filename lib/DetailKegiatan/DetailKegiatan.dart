import 'package:flutter/material.dart';
import 'ButtonGabung.dart';
import 'ButtonHubungi.dart';
import 'MyCard.dart';
import 'package:relawanin_mobile_project/SQLite/sqlite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailKegiatan extends StatefulWidget {
  static const String logoImage = 'assets/logo.png';
  final Map<String, dynamic> activityData;

  DetailKegiatan({Key? key, required this.activityData}) : super(key: key);

  @override
  _DetailKegiatanState createState() => _DetailKegiatanState();
}

class _DetailKegiatanState extends State<DetailKegiatan> {
  late SharedPreferences _prefs;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    final id = widget.activityData['id'];
    _isFavorite = _prefs.getBool('favorite_$id') ?? false;
    setState(() {});
  }

  Future<void> _toggleFavorite() async {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    final databaseHelper = DatabaseHelper();
    final id = widget.activityData['id'];
    if (_isFavorite) {
      _showSnackBar('Kegiatan telah ditambahkan ke favorit');
      final activity = {
        'id': id,
        'namaKegiatan': widget.activityData['namaKegiatan'],
        'lokasi': widget.activityData['lokasi'],
        'deskripsiKegiatan': widget.activityData['deskripsiKegiatan'],
        'aktivitasKegiatan': widget.activityData['aktivitasKegiatan'],
        'ketentuanKegiatan': widget.activityData['ketentuanKegiatan'],
        'tanggalKegiatan': widget.activityData['tanggalKegiatan'],
        'batasRegistrasi': widget.activityData['batasRegistrasi'],
        'estimasiPoint': widget.activityData['estimasiPoint'],
        'imageUrl': widget.activityData['imageUrl']
      };
      await databaseHelper.insertFavoriteActivity(activity);
    } else {
      _showSnackBar('Kegiatan telah dihapus dari favorit');
      await databaseHelper.deleteFavoriteActivity(id);
    }

    if (_isFavorite) {
      _prefs.setBool('favorite_$id', true);
    } else {
      _prefs.remove('favorite_$id');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void gabung() {}
  void hubungi() {}

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Color(0xFF00897B),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Image.asset(DetailKegiatan.logoImage),
            ),
            actions: [
              GestureDetector(
                onTap: _toggleFavorite,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            // Use a default image if activityData['imageUrl'] is null
            Image.network(
              widget.activityData['imageUrl'] ??
                  'https://via.placeholder.com/150',
              width: double.infinity,
              height: screenHeight * 0.4,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.activityData['namaKegiatan'] ?? 'No Name',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    widget.activityData['lokasi'] ?? 'No Location',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF00897B),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    widget.activityData['deskripsiKegiatan'] ??
                        'No Description',
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Aktivitas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    widget.activityData['aktivitasKegiatan'] ?? 'No Activity',
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Ketentuan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    widget.activityData['ketentuanKegiatan'] ?? 'No Activity',
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.green),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'Tanggal Kegiatan: ${widget.activityData['tanggalKegiatan'] ?? 'No Date'}'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.map, color: Colors.green),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            'Lokasi: ${widget.activityData['lokasi'] ?? 'No Location'}'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.dangerous_outlined, color: Colors.red),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Batas registrasi: ${widget.activityData['batasRegistrasi'] ?? 'No Registration Limit'}',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: screenHeight * 0.1,
              color: const Color.fromARGB(255, 191, 191, 191),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text('Estimated Poin'),
                  ),
                  SizedBox(width: 150),
                  Text(widget.activityData['estimasiPoint']?.toString() ??
                      'No Points'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  ButtonGabung(
                    onTap: gabung,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
