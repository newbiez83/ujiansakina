import 'package:flutter/material.dart';

class KategoriIcons extends StatelessWidget {
  KategoriIcons({super.key});

  final List<Map> categories = [
    {'icon': Icons.calendar_month, 'text': 'Jadwal'},
    {'icon': Icons.people, 'text': 'Antrian'},
    {'icon': Icons.app_registration, 'text': 'Daftar'},
    {'icon': Icons.local_pharmacy, 'text': 'News'},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var category in categories)
          CategoryIcon(
            icon: category['icon'],
            text: category['text'],
          ),
      ],
    );
  }
}

class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String text;

  const CategoryIcon({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(20),
      child: InkWell(
        splashColor: Colors.grey,
        onTap: () {},
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
