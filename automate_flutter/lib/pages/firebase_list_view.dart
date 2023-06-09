import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:home_automation/models/device.dart';

DatabaseReference mainReference = FirebaseDatabase.instance.reference();

class FirebaseListView extends StatelessWidget {
  final documents;
  final id;
  FirebaseListView({this.documents, this.id});

  String _findIcon(title) {
    String a = "https://i.imgur.com/O774D8O.png";
    switch (title) {
      case "AC":
        a = "https://i.imgur.com/O774D8O.png";
        break;
      case "Heater":
        a = "https://i.imgur.com/Yljp3a9.png";
        break;
      case "Fan":
        a = "https://i.imgur.com/gvwNMq0.png";
        break;
      case "LED":
      case "Tubelight":
        a = "https://i.imgur.com/5G2G8Aq.png";
        break;
    }
    return a;
  }

  @override
  Widget build(BuildContext context) {
    // print(documents);
    if (documents.length != 0) {
      return ListView.builder(
        itemCount: documents.length,
        itemBuilder: (BuildContext context, int index) {
          DeviceEntry object = documents[index];
          // print(object);
          String title = object.name;
          // print(title);
          bool status = object.status;
          String url = _findIcon(title);
          Color c = (status == true) ? Colors.indigo : Colors.grey;
          Color iconColor = (status == true) ? Colors.greenAccent : Colors.grey;
          return Card(
            elevation: 4.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            color: c,
            child: InkWell(
              onTap: () {
                status = !status;
                mainReference
                    .child('devices')
                    .child(id)
                    .child(object.key)
                    .set({"name": title, "status": status});
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(64, 75, 96, .9),
                ),
                child: ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: url,
                    // placeholder: new CircularProgressIndicator(),
                    errorWidget: new Icon(Icons.error),
                    height: 32.0,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  title: Text(
                    title,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.all(6.0),
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: iconColor,
                          )),
                      // Text("", style: TextStyle(color: Colors.white))
                    ],
                  ),
                  trailing: Switch(
                    activeColor: Colors.white,
                    value: status,
                    onChanged: (e) {
                      status = !status;
                      mainReference
                          .child('devices')
                          .child(id)
                          .child(object.key)
                          .set({"name": title, "status": status});
                    },
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'No devices',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
              // SizedBox(height: 30.0),
              // Image.asset(
              //   'assets/empty.png',
              //   height: 200.0,
              // ),
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage('assets/empty.png'),
                height: 200.0,
              ),
            ]),
      );
    }
  }
}
