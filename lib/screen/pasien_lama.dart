import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rsusakina/widget/input_select.dart';

class PasienLamaDaftar extends StatefulWidget {
  const PasienLamaDaftar({super.key});

  @override
  State<PasienLamaDaftar> createState() => _PasienLamaDaftarState();
}

class _PasienLamaDaftarState extends State<PasienLamaDaftar> {
  String? selectedValue;

  final TextEditingController _jajalan = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  final FocusNode _jajalFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("poli").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Some error occured ${snapshot.error}"),
            );
          }
          List<DropdownMenuItem> programItems = [];
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            final selectProgram = snapshot.data?.docs.reversed.toList();
            if (selectProgram != null) {
              for (var program in selectProgram) {
                programItems.add(
                  DropdownMenuItem(
                    value: program.id,
                    child: Text(
                      program['nama_poli'],
                    ),
                  ),
                );
              }
            }
            return CustomTextField(
              controller: _jajalan,
              hint: "E-mail Adress",
              textFocus: _jajalFocus,

              // onChanged: () {},
            );
          }
        },
      ),
    );
  }
}
