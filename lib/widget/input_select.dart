import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:icons_plus/icons_plus.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  // final Function onChanged;
  final FocusNode textFocus;
  final FocusNode? nextFocus;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.nextFocus,
    // required this.onChanged,
    required this.textFocus,
  });

  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
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
            'Silahkan Pilih Poli Tujuan',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: Container(
            child: StreamSelect(
              poliTujuan: (String poli) {
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
      onChanged: (text) {
        // if (widget.onChanged != null) {
        //   widget.onChanged(text);
        // }
        setState(() {
          // if (!widget.validator(text) || text.length == 0) {
          //   currentColor = widget.errorColor;
          // } else {
          //   currentColor = widget.baseColor;
          // }
        });
      },
      //keyboardType: widget.inputType,
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

class StreamSelect extends StatefulWidget {
  const StreamSelect({
    super.key,
    required this.poliTujuan,
  });

  final Function(String poli) poliTujuan;

  @override
  State<StreamSelect> createState() => _StreamSelectState();
}

class _StreamSelectState extends State<StreamSelect> {
  final CollectionReference fetchPoli =
      FirebaseFirestore.instance.collection("poli");

  String? jeniscuti;

  void _pilihCaraBayar(String namajeniscuti) {
    widget.poliTujuan(namajeniscuti);
    setState(() {
      jeniscuti = namajeniscuti;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fetchPoli.snapshots(),
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
                leading: Icon(
                  OctIcons.diff_added,
                  size: 15,
                ),
                title: Text(
                  documentSnapshot['nama_poli'],
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                onTap: () => _pilihCaraBayar(documentSnapshot['nama_poli']),
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
