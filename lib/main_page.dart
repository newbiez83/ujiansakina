import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rsusakina/screen/homepage.dart';
import 'package:rsusakina/screen/jadwal.dart';
import 'package:rsusakina/screen/pendaftaran.dart';
import 'package:rsusakina/screen/profile.dart';
import 'package:rsusakina/screen/tiket.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    JadwalDokter(),
    Pendaftaran(),
    TiketPendaftaran(),
    Profile(),
  ];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  // _navigate(Widget screen) {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  // }

  String shortcut = "no action set";

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: _scaffoldKey,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 20,
        selectedIconTheme: IconThemeData(color: Colors.green),
        selectedItemColor: Colors.green,
        selectedLabelStyle:
            TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            icon: Icon(OctIcons.code_of_conduct),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(OctIcons.calendar),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(
            icon: Icon(OctIcons.file_code),
            label: 'Daftar',
          ),
          BottomNavigationBarItem(
            icon: Icon(OctIcons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(OctIcons.person),
            label: 'Profile',
          ),
        ],
      ),
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(5),
      //       topRight: Radius.circular(5),
      //     ),
      //     boxShadow: [
      //       BoxShadow(
      //         blurRadius: 5,
      //         color: Colors.grey,
      //       ),
      //     ],
      //   ),
      //   child: SafeArea(
      //     child: Padding(
      //       padding:
      //           const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
      //       child: GNav(
      //         curve: Curves.easeOutExpo,
      //         rippleColor: Colors.lightGreen,
      //         hoverColor: Colors.lightGreenAccent,
      //         haptic: true,
      //         tabBorderRadius: 5,
      //         gap: 2,
      //         activeColor: Colors.white,
      //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      //         duration: Duration(milliseconds: 500),
      //         tabBackgroundColor: Colors.green,
      //         textStyle: TextStyle(
      //           color: Colors.white,
      //           fontSize: 14,
      //           fontWeight: FontWeight.bold,
      //         ),
      //         tabs: [
      //           GButton(
      //             iconSize: _selectedIndex != 0 ? 20 : 20,
      //             icon: _selectedIndex == 0 ? Icons.home : Icons.home,
      //             text: 'Home',
      //           ),
      //           GButton(
      //             iconSize: 20,
      //             icon: _selectedIndex == 1
      //                 ? Icons.calendar_month
      //                 : Icons.calendar_month,
      //             text: 'Jadwal',
      //           ),
      //           GButton(
      //             iconSize: 20,
      //             icon:
      //                 _selectedIndex == 2 ? Icons.newspaper : Icons.newspaper,
      //             text: 'Daftar',
      //           ),
      //           GButton(
      //             iconSize: 20,
      //             icon: _selectedIndex == 3
      //                 ? Icons.logout
      //                 : Icons.app_registration,
      //             text: 'Riwayat',
      //           ),
      //         ],
      //         selectedIndex: _selectedIndex,
      //         onTabChange: _onItemTapped,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
