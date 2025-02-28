import 'package:flutter/material.dart';
import 'package:rsusakina/screen/pasien_baru.dart';
import 'package:rsusakina/screen/pasien_lama.dart';

class Pendaftaran extends StatefulWidget {
  const Pendaftaran({super.key});

  @override
  State<Pendaftaran> createState() => _PendaftaranState();
}

class _PendaftaranState extends State<Pendaftaran> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Pendaftaran Pasien',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size(50.0, 50.0),
            child: TabBar(
              indicatorColor: Colors.green,
              labelColor: Colors.green,
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              labelStyle: TextStyle(fontSize: 16),
              tabs: const [
                Tab(
                  text: 'Pasien Baru',
                ),
                Tab(text: 'Pasien Lama'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            PasienBaruDaftar(),
            PasienLamaDaftar(),
          ],
        ),
      ),
    );
  }
}
