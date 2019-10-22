import 'package:SAMR/dashboard/global_appBar.dart';
import 'package:SAMR/dashboard/global_drawer.dart';
import 'package:SAMR/model/files_list_model.dart';
import 'package:SAMR/requests/files_request.dart';
import 'package:flutter/material.dart';

class Files extends StatefulWidget {
  @override
  _FilesState createState() => _FilesState();
}

class _FilesState extends State<Files> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f7f8),
      drawer: GlobalDrawer(),
      appBar: GlobalAppBar(
        title: Container(
          transform: Matrix4.translationValues(-20, 1, 0),
          child: Text(
            'Файловый архив',
            style: TextStyle(
                color: Color(0xFF293148),
                fontFamily: "Roboto",
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FutureBuilder(
          future: FilesRequest().loadFiles(1),
          builder: (BuildContext c, AsyncSnapshot snapshots) {
            if (snapshots.hasError) return Text("Error Occurred");
            switch (snapshots.connectionState) {
              case ConnectionState.waiting:
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.blueAccent,
                ));
              case ConnectionState.none:
                return Center(
                    child: Text(
                  'No data exist!',
                  style: TextStyle(color: Colors.black),
                ));
              case ConnectionState.done:
                return FilesList(
                  filesData: snapshots.data,
                );
              default:
                return Container();
            }
          }),
    );
  }
}

class FilesList extends StatefulWidget {
  final FilesPages filesData;
  const FilesList({
    this.filesData,
    Key key,
  }) : super(key: key);

  @override
  _FilesListState createState() => _FilesListState();
}

class _FilesListState extends State<FilesList> {
  ScrollController scrollController = new ScrollController();
  List<FilesModel> files;
  int currentPage = 1;

  @override
  void initState() {
    files = widget.filesData.results;
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        FilesRequest().loadFiles(currentPage + 1).then((val) {
          currentPage = val.page;
          setState(() {
            files.addAll(val.results);
          });
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: files.length,
      controller: scrollController,
      itemBuilder: (BuildContext c, int i) {
        return Card(
          margin: EdgeInsets.only(bottom: 15),
          elevation: 0.3,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        left: 17,
                        bottom: 5,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.797,
                        child: Text(
                          files[i].title != null ? files[i].title : '',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: files[i].isActive
                          ? Container(
                              width: 11,
                              child: Image.asset('assets/green-icon.png'),
                            )
                          : Container(
                              width: 16,
                              child: Image.asset('assets/red-icon.png'),
                            ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, top: 1, bottom: 10),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.folder,
                        size: 16,
                        color: Color(0xff9da1ac),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        files[i].fileCategoryName != null
                            ? files[i].fileCategoryName
                            : '',
                        style: TextStyle(
                          color: Color(0xff9da1ac),
                          fontSize: 13,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.date_range,
                        size: 16,
                        color: Color(0xff9da1ac),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        files[i].createdAt != null ? files[i].createdAt : '',
                        style: TextStyle(
                          color: Color(0xff9da1ac),
                          fontSize: 13,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 16))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    files[i].description.toString(),
                    style: TextStyle(
                      color: Color(0xff30384d),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(0, 17, 0),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      child: ClipOval(
                        child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: 'assets/noavatar.jpg',
                          image: files[i].photoPath,
                        ),
                      ),
                    ),
                    title: Container(
                      transform: Matrix4.translationValues(-5, 4, 0),
                      child: Text(
                        files[i].fullName.isNotEmpty
                            ? files[i].fullName
                            : 'Full Name',
                        style: TextStyle(
                          color: Color(0xffa9b3d3),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    subtitle: Container(
                      transform: Matrix4.translationValues(-5, -1, 0),
                      child: Text(
                        files[i].positionName != null
                            ? files[i].positionName
                            : 'Position',
                        style: TextStyle(
                          color: Color(0xffa9b3d3),
                          fontSize: 12,
                        ),
                      ),
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
