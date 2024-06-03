import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/SQLite/sqlite.dart';

import 'package:relawanin_mobile_project/DetailKegiatan/DetailKegiatan.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  late DatabaseHelper _databaseHelper;
  List<Map<String, dynamic>> _favoriteActivities = [];

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
    _getFavoriteActivities();
  }

  Future<void> _getFavoriteActivities() async {
    final favorites = await _databaseHelper.getFavoriteActivities();
    print('Favorites: $favorites'); // <--- Add this print statement
    setState(() {
      _favoriteActivities = favorites.cast<Map<String, dynamic>>();
    });
  }

  Future<void> _deleteFavoriteActivity(int id) async {
    final activityIndex =
        _favoriteActivities.indexWhere((activity) => activity['id'] == id);
    if (activityIndex != -1) {
      await _databaseHelper.deleteFavoriteActivity(id);
      setState(() {
        _favoriteActivities.removeAt(activityIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: const Color(0xFF00897B),
            title: const Text('Favorite Saya',
                style: TextStyle(color: Colors.white)),
          ),
        ),
        body: _favoriteActivities.isEmpty
            ? const Center(
                child: Text('Tidak ada aktivitas favorit'),
              )
            : ListView.builder(
                itemCount: _favoriteActivities.length,
                itemBuilder: (context, index) {
                  final activity = _favoriteActivities[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailKegiatan(activityData: activity),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(
                          activity['imageUrl'] ??
                              'https://via.placeholder.com/150',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        title: Text(activity['namaKegiatan'] ?? 'No Name'),
                        subtitle: Text(activity['lokasi'] ?? 'No Location'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _deleteFavoriteActivity(activity['id']!);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
