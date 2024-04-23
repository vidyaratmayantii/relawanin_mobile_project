// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class cariberita extends StatefulWidget {
  const cariberita({super.key});

  @override
  State<cariberita> createState() => _cariberitaState();
}

class _cariberitaState extends State<cariberita> {
  @override
  Widget build(BuildContext context) {
    return
    Column(
      children: [
         Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                
                  Text("Filter",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                      textAlign: TextAlign.right,)
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
                            Image.asset('assets/images.jpeg', height: 190, width: 349,fit: BoxFit.contain,),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, top:11),
                              child: Text("Judul berita", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20 ),),
                            ),                    
                          ],
                        ),
                        ),
                      );
                    }),
                  ),
      ],
    );
  }
}