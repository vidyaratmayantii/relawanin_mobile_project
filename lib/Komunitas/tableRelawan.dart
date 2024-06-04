import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TableRelawan());
}

class TableRelawan extends StatefulWidget {
  TableRelawan({Key? key}) : super(key: key);

  @override
  _TableRelawanState createState() => _TableRelawanState();
}

class _TableRelawanState extends State<TableRelawan> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/logo.png'),
          backgroundColor: Color.fromRGBO(0, 137, 123, 1),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('form').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final data = snapshot.data!.docs;
            final dataSource = FirestoreDataTableSource(data);
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  PaginatedDataTable(
                    source: dataSource,
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('No Tlp')),
                      DataColumn(label: Text('Umur')),
                      DataColumn(label: Text('Pekerjaan')),
                      DataColumn(label: Text('Alasan')),
                      DataColumn(label: Text('Pengalaman')),
                      DataColumn(label: Text('CV')),
                    ],
                    header:
                        const Center(child: Text('Table Registrasi Relawan')),
                    columnSpacing: 30,
                    horizontalMargin: 10,
                    rowsPerPage: 8,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class FirestoreDataTableSource extends DataTableSource {
  final List<QueryDocumentSnapshot> data;

  FirestoreDataTableSource(this.data);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length || index >= 200) return null; // Limit to 200 rows
    final item = data[index];
    return DataRow(cells: [
      DataCell(Text((index + 1).toString())), // Use index as ID
      DataCell(Text(item['nama'] ?? '')),
      DataCell(Text(item['email'] ?? '')),
      DataCell(Text(item['noTlp'] ?? '')),
      DataCell(Text(item['umur']?.toString() ?? '')),
      DataCell(Text(item['pekerjaan'] ?? '')),
      DataCell(Text(item['alasan'] ?? '')),
      DataCell(Text(item['pengalaman'] ?? '')),
      DataCell(Text(item['pdfUrl'] ?? '')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
