import 'package:flutter/material.dart';

class AppoinmentCard extends StatelessWidget {
  const AppoinmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://sakinaidaman.com/wp-content/uploads/2020/08/dr.-Rina-Fatmawati-Sp.OG-2-min-1536x1536.jpg'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('dr. Rina Fatmawati, Sp.OG',
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'Dokter Spesialis Obsteri & Ginekologi',
                                  style: TextStyle(color: Colors.black),
                                  overflow: TextOverflow.fade,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Colors.black,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Mon, July 29',
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.access_alarm,
                              color: Colors.black,
                              size: 17,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Text(
                                '11:00 ~ 12:10',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
