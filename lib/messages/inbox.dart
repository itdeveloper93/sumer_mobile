import 'package:SAMR/dashboard/global_appBar.dart';
import 'package:SAMR/dashboard/global_drawer.dart';
import 'package:SAMR/messages/inbox_detail.dart';
import 'package:SAMR/model/messages_model.dart';
import 'package:SAMR/requests/message_request.dart';
import 'package:flutter/material.dart';

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  DateTime selectedfromDate = DateTime.now();
  Future<Null> _selectfromDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedfromDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedfromDate)
      setState(() {
        selectedfromDate = picked;
        var date = DateTime.parse(picked.toString());
        var formattedDate = "${date.day}-${date.month}-${date.year}";
        fromDateController.value = TextEditingValue(text: formattedDate);
      });
  }

  DateTime selectedtoDate = DateTime.now();
  Future<Null> _selecttoDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedtoDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedtoDate)
      setState(() {
        selectedtoDate = picked;
        var date = DateTime.parse(picked.toString());
        var formattedDate = "${date.day}-${date.month}-${date.year}";
        toDateController.value = TextEditingValue(text: formattedDate);
      });
  }

  TextEditingController nameController = new TextEditingController();
  TextEditingController fromDateController = new TextEditingController();
  TextEditingController toDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f7f8),
      drawer: GlobalDrawer(),
      appBar: GlobalAppBar(
        title: Container(
          transform: Matrix4.translationValues(-20, 1, 0),
          child: Text(
            'Входящие',
            style: TextStyle(
                color: Color(0xFF293148),
                fontFamily: "Roboto",
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FutureBuilder(
        future: MessagesRequest().loadInbox(1, null, null, null),
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
              return InboxList(
                inboxData: snapshots.data,
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
          return showModalBottomSheet(
            context: context,
            builder: (BuildContext bc) {
              return AnimatedPadding(
                padding: MediaQuery.of(context).viewInsets,
                duration: const Duration(milliseconds: 100),
                curve: Curves.decelerate,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 25),
                  child: Wrap(
                    children: <Widget>[
                      Container(
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
                              child: GestureDetector(
                                onTap: () => _selectfromDate(context),
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: fromDateController,
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                      hintText: 'Сообщения с',
                                      suffixIcon: Icon(
                                        Icons.date_range,
                                        color: Colors.blueAccent,
                                      ),
                                      border: OutlineInputBorder(),
                                      labelText: 'Сообщения с',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: GestureDetector(
                                onTap: () => _selecttoDate(context),
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: toDateController,
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                      hintText: 'Сообщения с',
                                      suffixIcon: Icon(
                                        Icons.date_range,
                                        color: Colors.blueAccent,
                                      ),
                                      border: OutlineInputBorder(),
                                      labelText: 'Сообщения по',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
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
                                setState(() {});
                                Navigator.pop(context);
                              },
                              elevation: 0.0,
                              color: Colors.indigoAccent[700],
                              child: Text("Найти",
                                  style: TextStyle(color: Colors.white)),
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
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) => Inbox()));
                              },
                              elevation: 0.0,
                              color: Color(0xFFecf0f5),
                              child: Text("Сбросить",
                                  style: TextStyle(color: Color(0xFF888fa3))),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class InboxList extends StatefulWidget {
  final InboxPages inboxData;
  const InboxList({
    this.inboxData,
    Key key,
  }) : super(key: key);

  @override
  _InboxListState createState() => _InboxListState();
}

class _InboxListState extends State<InboxList> {
  ScrollController scrollController = new ScrollController();
  List<InboxModel> inbox;
  int currentPage = 1;

  InboxList test;

  request() {
    MessagesRequest()
        .loadInbox(currentPage + 1, nameController.text,
            fromDateController.text, toDateController.text)
        .then((val) {
      currentPage = val.page;
      setState(() {
        inbox.addAll(val.results);
      });
    });
  }

  @override
  void initState() {
    inbox = widget.inboxData.results;
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

  final TextEditingController nameController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: inbox.length,
      controller: scrollController,
      itemBuilder: (BuildContext c, int i) {
        return Card(
          margin: EdgeInsets.only(),
          elevation: 0,
          child: Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            InboxMessageDetail(inbox[i].id.toString()),
                      ),
                    );
                  },
                  leading: Container(
                    width: 50,
                    height: 50,
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: 'assets/noavatar.jpg',
                        image: inbox[i].photoPath,
                      ),
                    ),
                  ),
                  trailing: Icon(Icons.navigate_next),
                  title: Text(inbox[i].title),
                  subtitle: Text(
                    inbox[i].createdAt,
                    style: TextStyle(
                      color: Color(0xff9da1ac),
                      fontSize: 13,
                    ),
                  ),
                ),
                Divider(),
              ],
            ),
          ),
        );
      },
    );
  }
}
