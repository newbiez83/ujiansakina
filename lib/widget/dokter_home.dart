import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rsusakina/screen/detail_dokter.dart';

class DokterHome extends StatelessWidget {
  DokterHome({super.key});
  final CollectionReference fetchDokter =
      FirebaseFirestore.instance.collection("dokter");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fetchDokter.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];

              return Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DetailDokter(
                              iddokter: documentSnapshot['id'].toString(),
                              namadokter:
                                  documentSnapshot['nama_dokter'].toString(),
                              spesialis:
                                  documentSnapshot['spesialis'].toString(),
                              deskripsi:
                                  documentSnapshot['deskripsi'].toString(),
                              foto: documentSnapshot['foto'].toString(),
                            );
                          },
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          //BoxDecoration Widget
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(documentSnapshot['foto']),
                              fit: BoxFit.cover,
                            ), //DecorationImage
                            border: Border.all(
                              color: Colors.green,
                              width: 2,
                            ), //Border.all
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: const Offset(
                                  5.0,
                                  5.0,
                                ), //Offset
                                blurRadius: 5.0,
                                spreadRadius: 2.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                          ), //BoxDecoration
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                documentSnapshot['nama_dokter'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                documentSnapshot['spesialis'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
