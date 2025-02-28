import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:icons_plus/icons_plus.dart';

class SelectDokterInput extends StatefulWidget {
  const SelectDokterInput({
    super.key,
    required this.hint,
    required this.controller,
    this.nextFocus,
    required this.textFocus,
  });

  final String hint;
  final TextEditingController controller;
  final FocusNode textFocus;
  final FocusNode? nextFocus;

  @override
  State<SelectDokterInput> createState() => _SelectDokterInputState();
}

class _SelectDokterInputState extends State<SelectDokterInput> {
  Color? currentColor;

  @override
  void initState() {
    super.initState();
    // currentColor = widget.borderColor;
    widget.textFocus.addListener(_focusListener);
  }

  void _focusListener() {
    if (widget.textFocus.hasFocus) {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => _showDialogStream(),
      );
    }
  }

  void _showDialogStream() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return GiffyDialog.image(
          Image.network(
            "https://sakinaidaman.com/wp-content/uploads/elementor/thumbs/Logo-Sakina-qqjll7myultpdn6rtvavxk7jvezwbfj3xjqi2n0jxw.png",
            height: 50,
            width: 50,
            fit: BoxFit.contain,
          ),
          title: Text(
            'Silahkan Pilih Dokter',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: Container(
            child: StreamSelectDokter(
              dokterTujuan: (String poli) {
                widget.controller.text = poli;
                // widget.sink.add(namajeniscuti);
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.pop(context, 'selected');
                });
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'CANCEL'),
              child: const Text('CANCEL'),
            ),
          ],
        );
      },
    ).then(
      (value) {
        if (widget.nextFocus != null && value != null) {
          FocusScope.of(context).requestFocus(widget.nextFocus);
        } else {
          FocusScope.of(context).requestFocus(FocusNode());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.textFocus,
      controller: widget.controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          left: 20,
          top: 10,
          bottom: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          // borderSide: BorderSide.none,
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: Colors.black26,
          fontSize: 14,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class StreamSelectDokter extends StatefulWidget {
  const StreamSelectDokter({
    super.key,
    required this.dokterTujuan,
  });

  final Function(String namadokter) dokterTujuan;

  @override
  State<StreamSelectDokter> createState() => _StreamSelectDokterState();
}

class _StreamSelectDokterState extends State<StreamSelectDokter> {
  final CollectionReference fetchDokter =
      FirebaseFirestore.instance.collection("dokter");

  String? jeniscuti;

  void _pilihDokter(String namadokternya) {
    widget.dokterTujuan(namadokternya);
    setState(() {
      jeniscuti = namadokternya;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fetchDokter.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(documentSnapshot['foto']),
                ),
                title: Text(
                  documentSnapshot['nama_dokter'],
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  documentSnapshot['spesialis'],
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                trailing: Icon(
                  OctIcons.diff_added,
                  size: 15,
                ),
                onTap: () => _pilihDokter(documentSnapshot['nama_dokter']),
              );
            },
          );
        }
        return Center(
            child: SizedBox(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}
