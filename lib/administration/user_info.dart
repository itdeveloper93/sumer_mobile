import 'package:flutter/material.dart';

import '../dashboard/global_drawer.dart';
import '../dashboard/global_appBar.dart';

class UserInfo extends StatelessWidget {
  String get data => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GlobalDrawer(),
      appBar: GlobalAppBar(
        title: Container(
          transform: Matrix4.translationValues(-20, 1, 0),
          child: Text(
            'User Info',
            style: TextStyle(
                color: Color(0xFF293148),
                fontFamily: "Roboto",
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Card(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                    ),
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(
                      top: 30,
                    ),
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                          "https://d2uqwoe9jzxxtn.cloudfront.net/images/music/cover/Mohsen-Chavoshi-Khas-CVR.jpg"),
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Мирзоев Искандар',
                      style: TextStyle(
                        color: Color(0xFF293148),
                        fontFamily: "Roboto",
                        fontSize: 19.6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      'Бухгалтерия › First Position',
                      style: TextStyle(
                        color: Color(0xFF858CA2),
                        fontFamily: "Roboto",
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 5,
            ),
            child: Card(
              child: Container(
                padding: EdgeInsets.only(left: 25, bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'Дата рождения',
                        style: TextStyle(
                          color: Color(0xFF293148),
                          fontFamily: "Roboto",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        '10.09.2019',
                        style: TextStyle(
                          color: Color(0xFF858CA2),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black26,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Подразделение',
                        style: TextStyle(
                          color: Color(0xFF293148),
                          fontFamily: "Roboto",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Бухгалтерия',
                        style: TextStyle(
                          color: Color(0xFF858CA2),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black26,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Позиция',
                        style: TextStyle(
                          color: Color(0xFF293148),
                          fontFamily: "Roboto",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'First Position',
                        style: TextStyle(
                          color: Color(0xFF858CA2),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black26,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Дата приема на работу',
                        style: TextStyle(
                          color: Color(0xFF293148),
                          fontFamily: "Roboto",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        '10.09.2019',
                        style: TextStyle(
                          color: Color(0xFF858CA2),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black26,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Телефон',
                        style: TextStyle(
                          color: Color(0xFF293148),
                          fontFamily: "Roboto",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        '+(992) 918 55 44 92',
                        style: TextStyle(
                          color: Color(0xFF858CA2),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black26,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Email',
                        style: TextStyle(
                          color: Color(0xFF293148),
                          fontFamily: "Roboto",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'itdeveloper@mig.tj',
                        style: TextStyle(
                          color: Color(0xFF858CA2),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black26,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Фактический адрес',
                        style: TextStyle(
                          color: Color(0xFF293148),
                          fontFamily: "Roboto",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Tajikistan/Dushanbe/Shohmansur',
                        style: TextStyle(
                          color: Color(0xFF858CA2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        onPressed: () {
          print('Clicked');
        },
      ),
    );
  }
}
