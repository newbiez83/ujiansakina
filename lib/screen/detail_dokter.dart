import 'package:flutter/material.dart';

class DetailDokter extends StatefulWidget {
  const DetailDokter({
    super.key,
    required this.iddokter,
    required this.namadokter,
    required this.spesialis,
    required this.deskripsi,
    required this.foto,
  });

  final String? iddokter;
  final String? namadokter;
  final String? spesialis;
  final String? deskripsi;
  final String? foto;

  @override
  State<DetailDokter> createState() => _DetailDokterState();
}

class _DetailDokterState extends State<DetailDokter> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'DETAIL DOKTER',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width,
                height: size.height * 0.3,
                //BoxDecoration Widget
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.foto.toString()),
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
                height: 20,
              ),
              Text(
                widget.namadokter.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.spesialis.toString(),
                style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black54),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'DESKRIPSI',
                style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.deskripsi.toString(),
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => BookingScreen(
                    //       doctor: document['name'],
                    //     ),
                    //   ),
                    // );
                  },
                  child: Text(
                    'Pendaftaran Poli',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
