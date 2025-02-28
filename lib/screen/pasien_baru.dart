import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:intl/intl.dart';
import 'package:rsusakina/widget/input_select.dart';
import 'package:rsusakina/widget/input_select_dokter.dart';

class PasienBaruDaftar extends StatefulWidget {
  const PasienBaruDaftar({super.key});

  @override
  State<PasienBaruDaftar> createState() => _PasienBaruDaftarState();
}

class _PasienBaruDaftarState extends State<PasienBaruDaftar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _keluhanController = TextEditingController();
  final TextEditingController _jajalan = TextEditingController();
  final TextEditingController _dokterController = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  final FocusNode _jajalFocus = FocusNode();
  final FocusNode _dokterFokus = FocusNode();

  @override
  void dispose() {
    _jajalFocus.dispose();
    _dokterFokus.dispose();
    super.dispose();
  }

  String? selectedValue;
  String? dokterValue;
  String? dateUTC;
  DateTime selectedDate = DateTime.now();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    ).then(
      (date) {
        setState(
          () {
            selectedDate = date!;
            String formattedDate =
                DateFormat('dd-MM-yyyy').format(selectedDate);
            _dateController.text = formattedDate;
            dateUTC = DateFormat('yyyy-MM-dd').format(selectedDate);
          },
        );
      },
    );
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GiffyDialog.image(
          Image.network(
            "https://sakinaidaman.com/wp-content/uploads/elementor/thumbs/Logo-Sakina-qqjll7myultpdn6rtvavxk7jvezwbfj3xjqi2n0jxw.png",
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
          title: Text(
            'Pendaftaran Berhasil',
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Silahkan Cek Riwayat Pendaftaran Pada Menu Riwayat.',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home', (Route<dynamic> route) => false),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _createAppointment() async {
    // print(dateUTC + ' ' + date_Time + ':00');
    FirebaseFirestore.instance
        .collection('appointments')
        .doc(user!.email)
        .collection('pending')
        .doc()
        .set({
      'namapasien': _nameController.text,
      'tanggalkunjungan': dateUTC,
      'politujuan': _jajalan.text,
      'dokter': _dokterController.text,
      'keluhan': _keluhanController.text,
      // 'doctor': _doctorController.text,
      // 'date': DateTime.parse(dateUTC + ' ' + date_Time + ':00'),
    }, SetOptions(merge: true));

    FirebaseFirestore.instance
        .collection('appointments')
        .doc(user!.email)
        .collection('all')
        .doc()
        .set({
      'namapasien': _nameController.text,
      'tanggalkunjungan': dateUTC,
      'politujuan': selectedValue,
      'dokter': _dokterController.text,
      'keluhan': _keluhanController.text,
      // 'doctor': _doctorController.text,
      // 'date': DateTime.parse(dateUTC + ' ' + date_Time + ':00'),
    }, SetOptions(merge: true));
  }

  @override
  void initState() {
    super.initState();
    _getUser();
    // selectTime(context);
    // _doctorController.text = widget.doctor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.only(top: 0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      controller: _jajalan,
                      hint: "Poli Tujuan",
                      textFocus: _jajalFocus,

                      // onChanged: () {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SelectDokterInput(
                      controller: _dokterController,
                      hint: "Dokter Tujuan",
                      textFocus: _dokterFokus,

                      // onChanged: () {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextFormField(
                            focusNode: f1,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 20,
                                top: 10,
                                bottom: 10,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                // borderSide: BorderSide.none,
                              ),
                              // filled: true,
                              // fillColor: Colors.grey[350],
                              hintText: 'Tanggal Kunjungan',
                              hintStyle: TextStyle(
                                color: Colors.black26,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            controller: _dateController,
                            validator: (value) {
                              if (value!.isEmpty)
                                return 'Please Enter the Date';
                              return null;
                            },
                            onFieldSubmitted: (String value) {
                              f1.unfocus();
                              FocusScope.of(context).requestFocus(f1);
                            },
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: ClipOval(
                              child: Material(
                                color: Colors.green, // button color
                                child: InkWell(
                                  // inkwell color
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Icon(
                                      Icons.date_range_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: () {
                                    selectDate(context);
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _nameController,
                      focusNode: f2,
                      validator: (value) {
                        if (value!.isEmpty) return 'Please Enter Patient Name';
                        return null;
                      },
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 20, top: 10, bottom: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          // borderSide: BorderSide.none,
                        ),
                        // filled: true,
                        // fillColor: Colors.grey[350],
                        hintText: 'Nama Pasien',
                        hintStyle: TextStyle(
                          color: Colors.black26,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      onFieldSubmitted: (String value) {
                        f2.unfocus();
                        FocusScope.of(context).requestFocus(f2);
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _keluhanController,
                      focusNode: f3,
                      maxLines: 2,
                      validator: (value) {
                        if (value!.isEmpty)
                          return 'Please Enter Keluhan Pasien';
                        return null;
                      },
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 20, top: 10, bottom: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          // borderSide: BorderSide.none,
                        ),
                        // filled: true,
                        // fillColor: Colors.grey[350],
                        hintText: 'Keluhan Pasien',

                        hintStyle: TextStyle(
                          color: Colors.black26,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      onFieldSubmitted: (String value) {
                        f3.unfocus();
                        FocusScope.of(context).requestFocus(f3);
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                            backgroundColor: Colors.green),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // print(_nameController.text);
                            // print(_dateController.text);
                            // print(widget.doctor);
                            showAlertDialog(context);
                            _createAppointment();
                          }
                        },
                        child: Text(
                          "Kirim Formulir",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
