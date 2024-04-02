// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class carikegiatan extends StatefulWidget {
  const carikegiatan({super.key});

  @override
  _carikegiatanState createState() => _carikegiatanState();
}

class _carikegiatanState extends State<carikegiatan> {

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, top: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Cari aktivitas",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
                  Text("Filter",
                      style: TextStyle(color: Colors.grey, fontSize: 20))
                ],
              ),
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Cari",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: Text("Teratas saat ini",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context,index){
                  return
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('', height: 190, width: 349,fit: BoxFit.contain,),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top:11),
                          child: Text("Judul Kegiatan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20 ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text("Nama komunitas", style: TextStyle( fontSize: 12 )),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 13, left: 13),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_month_outlined, color:Color.fromRGBO(0, 137, 123, 1) ),
                            Text("Tanggal kegiatan", style: TextStyle( fontSize: 12 )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 9, left: 13),
                        child: Row(
                          children: [
                            Icon(Icons.pin_drop_rounded, color:Color.fromRGBO(0, 137, 123, 1) ),
                            Text("Lokasi Kegiatan", style: TextStyle( fontSize: 12 )),
                          ],
                        ),
                      )
                      ],
                    ),
                                    ),
                  );
                }),
              )       
            ],
          ),
        ),
      ),
    );
  }
}
