import 'package:flutter/material.dart';

class carikegiatan extends StatefulWidget {
  const carikegiatan({super.key});

  @override
  State<carikegiatan> createState() => _carikegiatanState();
}

class _carikegiatanState extends State<carikegiatan> {
  int itemCount = 5;
  bool _isLoading = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
      setState(() {
        _isLoading = true;
      });
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          itemCount += 5;
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Filter", style: TextStyle(color: Colors.grey, fontSize: 20))
            ],
          ),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Cari",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 13),
            child: Text("Teratas saat ini",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: itemCount + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == itemCount && _isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('path/to/your/image', height: 190, width: 349, fit: BoxFit.contain),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 11),
                            child: Text("Judul Kegiatan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text("Nama komunitas", style: TextStyle(fontSize: 12)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 13, left: 13),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_month_outlined, color: Color.fromRGBO(0, 137, 123, 1)),
                                Text("Tanggal kegiatan", style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 9, left: 13),
                            child: Row(
                              children: [
                                Icon(Icons.pin_drop_rounded, color: Color.fromRGBO(0, 137, 123, 1)),
                                Text("Lokasi Kegiatan", style: TextStyle(fontSize: 12)),
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
        ],
      ),
    );
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    setState(() {
      itemCount += 5;
    });
  }
}
