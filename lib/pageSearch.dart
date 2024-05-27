import 'package:relawanin_mobile_project/cariberita.dart';
import 'package:relawanin_mobile_project/cari_kegiatan_page.dart';
import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/notification_page.dart';
import 'package:relawanin_mobile_project/dashboard_page.dart';
import 'package:relawanin_mobile_project/profile_page.dart';

class pageSearch extends StatefulWidget {
  const pageSearch({super.key});

  @override
  _pageSearchState createState() => _pageSearchState();
}

class _pageSearchState extends State<pageSearch>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Menyembunyikan tombol "back"

          title: Text(
            'Search',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          ),
          backgroundColor: Color.fromRGBO(0, 137, 123, 1),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10), // Add padding here
              child: Container(
                width: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 137, 123, 1),
                    border: Border.all(
                        width: 0, color: Color.fromRGBO(0, 137, 123, 1)),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    TabBar(
                      unselectedLabelColor: Colors.white,
                      labelColor: Colors.black,
                      indicatorColor: const Color.fromARGB(255, 255, 255, 255),
                      indicatorWeight: 5,
                      indicatorPadding: EdgeInsets.only(left: -100, right: -75),
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      controller: tabController,
                      tabs: [
                        Tab(text: 'Kegiatan'),
                        Tab(
                          text: 'Berita',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10), // Add padding here
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search...',
                    icon: Icon(Icons.search,
                        color: Color.fromRGBO(0, 137, 123, 1)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  carikegiatan(searchQuery: _searchController.text),
                  cariberita(searchQuery: _searchController.text),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 1,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Color(0xFF00897B),
          onTap: (int index) {
            if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            } else if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DashboardPage()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
