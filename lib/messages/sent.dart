import 'package:SAMR/dashboard/global_appBar.dart';
import 'package:SAMR/dashboard/global_drawer.dart';
import 'package:SAMR/messages/sent_detail.dart';
import 'package:SAMR/model/messages_model.dart';
import 'package:SAMR/requests/message_request.dart';
import 'package:flutter/material.dart';

class Sent extends StatefulWidget {
  @override
  _SentState createState() => _SentState();
}

class _SentState extends State<Sent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f7f8),
      drawer: GlobalDrawer(),
      appBar: GlobalAppBar(
        title: Container(
          transform: Matrix4.translationValues(-20, 1, 0),
          child: Text(
            'Отправленные',
            style: TextStyle(
                color: Color(0xFF293148),
                fontFamily: "Roboto",
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FutureBuilder(
        future: MessagesRequest().loadSent(1, null, null, null),
        builder: (BuildContext c, AsyncSnapshot snapshots) {
          if (snapshots.hasError) return Text("Error Occurred");
          switch (snapshots.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              ));
            case ConnectionState.none:
              return Center(child: Text('No data exist!'));
            case ConnectionState.done:
              return SentList(
                sentData: snapshots.data,
              );
            default:
              return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(
          Icons.filter_list,
          color: Colors.white,
        ),
        onPressed: () {
          // _settingModalBottomSheet(context);
        },
      ),
    );
  }
}

class SentList extends StatefulWidget {
  final SentPages sentData;
  const SentList({
    this.sentData,
    Key key,
  }) : super(key: key);

  @override
  _SentListState createState() => _SentListState();
}

class _SentListState extends State<SentList> {
  ScrollController scrollController = new ScrollController();
  List<SentModel> sent;
  int currentPage = 1;

  request() {
    MessagesRequest()
        .loadSent(currentPage + 1, nameController.text, fromDateController.text,
            toDateController.text)
        .then((val) {
      currentPage = val.page;
      setState(() {
        sent.addAll(val.results);
      });
    });
  }

  @override
  void initState() {
    sent = widget.sentData.results;
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        request();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Container textSection() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Заголовок или имя',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              controller: fromDateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Сообщения с',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              controller: toDateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Сообщения по',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row buttonSection() {
    return Row(
      mainAxisSize: MainAxisSize
          .min, // this will take space as minimum as posible(to center)
      children: <Widget>[
        ButtonTheme(
          minWidth: 174.0,
          height: 60.0,
          child: RaisedButton(
            onPressed:
                // emailController.text == "" || factualAddressController.text == ""
                //     ? null
                //     :
                () {
              setState(() {
                request();
              });
              Navigator.pop(context);
            },
            elevation: 0.0,
            color: Colors.indigoAccent[700],
            child: Text("Найти", style: TextStyle(color: Colors.white)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        ButtonTheme(
          minWidth: 174.0,
          height: 60.0,
          child: RaisedButton(
            onPressed: () {
              // Navigator.pop(context);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Sent()));
            },
            elevation: 0.0,
            color: Color(0xFFecf0f5),
            child: Text("Сбросить", style: TextStyle(color: Color(0xFF888fa3))),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ],
    );
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sent.length,
      controller: scrollController,
      itemBuilder: (BuildContext c, int i) {
        return Card(
          margin: EdgeInsets.only(),
          child: Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            SentMessageDetail(sent[i].id.toString()),
                      ),
                    );
                  },
                  trailing: Icon(Icons.navigate_next),
                  leading: Container(
                    width: 50,
                    height: 50,
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: 'assets/noavatar.jpg',
                        image: sent[i].photoPath,
                      ),
                    ),
                  ),
                  title: Text(sent[i].title),
                  subtitle: Text(
                    sent[i].createdAt,
                    style: TextStyle(
                      color: Color(0xff9da1ac),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
