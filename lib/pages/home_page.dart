import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foody_app/widgets/banner_widget_area.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWeight = MediaQuery.of(context).size.width;

    Future<List<Widget>> createList() async {
      List<Widget> items = <Widget>[];
      String dataString = await DefaultAssetBundle.of(context)
          .loadString('assets/data/data.json');
      List<dynamic> dataJSON = jsonDecode(dataString);

      dataJSON.forEach((object) {
        items.add(
          Padding(
            padding: EdgeInsets.all(
              2.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 2.0,
                      blurRadius: 5.0,
                    ),
                  ]),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    child: Image.asset(
                      object['placeImage'],
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
      return items;
    }

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWeight,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5, 10.0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.menu),
                      ),
                      Text(
                        'Foody',
                        style:
                            TextStyle(fontSize: 50.0, fontFamily: 'Samantha'),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.person),
                      ),
                    ],
                  ),
                ),
                BannerWidgetArea(),
                Container(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FutureBuilder(
                          initialData: Text(''),
                          future: createList(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ListView(),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          })),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
