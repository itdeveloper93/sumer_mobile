import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sumer_mobile/administration/user_info.dart';
import 'package:sumer_mobile/model/profile_model.dart';
import 'package:sumer_mobile/services/auth_service.dart';

import '../dashboard/global_drawer.dart';
import '../dashboard/global_appBar.dart';
import '../global.dart';

class EditUserInfo extends StatefulWidget {
  @override
  _EditUserInfoState createState() => _EditUserInfoState();
}

class _EditUserInfoState extends State<EditUserInfo> {
  static String email;
  static String factualAddress;
  bool isLoading = false;

  // void fetchProducts() {
  //   http
  //       .get('https://flutter-products.firebaseio.com/products.json')
  //       .then((http.Response response) {
  //     final List<Profile> fetchedProductList = [];
  //     final Map<String, dynamic> productListData = json.decode(response.body);
  //     productListData.forEach((String productId, dynamic productData) {
  //       final Profile userInfo = Profile(
  //           id: productId,
  //           title: productData['title'],
  //           description: productData['description'],
  //           image: productData['image'],
  //           price: productData['price'],
  //           userEmail: productData['userEmail'],
  //           userId: productData['userId']);
  //       fetchedProductList.add(userInfo);
  //     });
  //     _products = fetchedProductList;
  //     notifyListeners();
  //   });
  // }

  Future<Profile> fetchMyProfile() async {
    final response = await http.get(
      URL + "api/Account/MyInfo",
      // Send authorization headers to the backend.
      headers: await AuthService.addAuthTokenToRequest(),
    );

    if (response.statusCode == 200) {
      Map decoded = json.decode(response.body);
      email = decoded['data']['email'];
      factualAddress = decoded['data']['factualAddress'];

      return Profile.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    fetchMyProfile();
    super.initState();
  }

  signIn(String email, factualAddress) async {
    Map data = {
      'email': email,
      'factualAddress': factualAddress,
    };
    var jsonResponse;
    var response = await http.put(
      URL + "api/Account",
      body: json.encode(data),
      headers: await AuthService.addAuthTokenToRequest(),
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => UserInfo()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.body);
    }
  }

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      // padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        'Редактирование данных',
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      child: RaisedButton(
        onPressed:
            // emailController.text == "" || factualAddressController.text == ""
            //     ? null
            //     :
            () {
          setState(() {
            isLoading = true;
          });
          signIn(emailController.text, factualAddressController.text);
        },
        elevation: 0.0,
        color: Colors.indigoAccent[700],
        child: Text("Сохранить", style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController emailController =
      TextEditingController(text: email);
  final TextEditingController factualAddressController =
      TextEditingController(text: factualAddress);

  Container textSection() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              controller: factualAddressController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Фактический адрес',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GlobalDrawer(),
      appBar: GlobalAppBar(
        title: Container(
          transform: Matrix4.translationValues(-20, 1, 0),
          child: Text(
            'Edit User Info',
            style: TextStyle(
                color: Color(0xFF293148),
                fontFamily: "Roboto",
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: FutureBuilder<Profile>(
          future: fetchMyProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
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
                              backgroundImage:
                                  NetworkImage(snapshot.data.photoPathSmall),
                              backgroundColor: Colors.blueAccent,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            child: Text(
                              snapshot.data.fullName,
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
                              snapshot.data.departmentName +
                                  ' › ' +
                                  snapshot.data.positionName,
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
                        padding: EdgeInsets.only(
                            top: 20, right: 25, bottom: 25, left: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            headerSection(),
                            textSection(),
                            buttonSection(),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              ),
            );
          },
        ),
      ),
    );
  }
}
