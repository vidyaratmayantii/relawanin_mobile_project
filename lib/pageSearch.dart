import 'package:relawanin_mobile_project/cariberita.dart';
import 'package:relawanin_mobile_project/carikegiatan.dart';
import 'package:flutter/material.dart';

class pageSearch extends StatefulWidget {
  const pageSearch({super.key});

  @override
  _pageSearchState createState() => _pageSearchState();
}

class _pageSearchState extends State<pageSearch> with SingleTickerProviderStateMixin {
late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

int _currentIndex = 0;
final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(0, 137, 123, 1),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
              SizedBox(height: 50),
              Container(
                  // height: 50,
                  width: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 137, 123, 1),
                      border: Border.all(width: 0, color: Color.fromRGBO(0, 137, 123, 1)),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    children: [
                      TabBar(
                        unselectedLabelColor: Colors.white,
                        labelColor: Colors.black,
                        indicatorColor: const Color.fromARGB(255, 255, 255, 255),
                        indicatorWeight: 5,
                        indicatorPadding: EdgeInsets.only(left: -118, right: -127),
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        controller: tabController,
                        tabs: [
                          Tab(
                            text: 'Kegiatan' 
                          ),
                          Tab(
                            text: 'Berita',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      carikegiatan(),
                      cariberita(),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    )
    );
  }
}