import 'package:flutter/material.dart';

class cariberita extends StatefulWidget {
  const cariberita({super.key});

  @override
  State<cariberita> createState() => _cariberitaState();
}

class _cariberitaState extends State<cariberita> {
  int itemCount = 8;
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
          itemCount += 8;
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
                            child: Text("Judul Berita", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
