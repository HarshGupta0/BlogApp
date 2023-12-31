import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:subspace/model/get_model.dart';
import 'package:subspace/view/glitch.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}
//globally initializing
List<NewsQueryModel> newsModelList1 = <NewsQueryModel>[];
String imgurl = '';
String head = '';
class HomeState extends State<Home> {
  bool isLoading = true;
  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];
  fetchBlogs() async {
    final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    final String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        // List blogs=body_data["blogs"];
        setState(() {
          data["blogs"].forEach((element) {
            NewsQueryModel newsQueryModel = new NewsQueryModel();
            newsQueryModel = NewsQueryModel.fromMap(element);
            newsModelList.add(newsQueryModel);
            setState(() {
              isLoading = false;
            });
          });
        });
        print('Response data: ${response.body}');
      } else {
        // Request failed
        print('Request failed with status code: ${response.statusCode}');
        print('Response data: ${response.body}');
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      print('Error: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchBlogs();
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.black,
              title: GlithEffect(
                child: Text(
                  'New Blogs',
                  style: TextStyle(
                    letterSpacing: 1,
                  ),
                ),
              ),
              centerTitle: true,
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ), //BoxDecoration
                    child: UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      accountName: Text(
                        "HARSH GUPTA",
                        style: TextStyle(fontSize: 18),
                      ),
                      accountEmail: Text("iharshgupta.2003@gmail.com"),
                      currentAccountPictureSize: Size.square(50),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(.6),
                        child: Text(
                          "H",
                          style: TextStyle(fontSize: 30.0, color: Colors.black),
                        ), //Text
                      ), //circleAvatar
                    ), //UserAccountDrawerHeader
                  ), //DrawerHeader
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(' My Profile '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.workspace_premium),
                    title: Text(' Go Premium '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.video_label),
                    title: Text(' Saved Blogs '),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Liked()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text(' Edit Profile '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('LogOut'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: GlithEffect(
                                        child: Text(
                                          "LATEST NEWS ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 28,
                                              color: Colors.white,
                                              fontFamily: 'Acme-Regular',
                                              letterSpacing: 2),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              isLoading
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              450,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: newsModelList.length,
                                      itemBuilder: (context, index) {
                                        try {
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  imgurl = newsModelList[index]
                                                      .newsImg;
                                                  head = newsModelList[index]
                                                      .newsHead;
                                                });
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LargeTab()));
                                              },
                                              child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  elevation: 1.0,
                                                  child: Stack(
                                                    children: [
                                                      ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child: Image.network(
                                                            newsModelList[index]
                                                                .newsImg,
                                                            fit: BoxFit
                                                                .fitHeight,
                                                            height: 230,
                                                            width:
                                                                double.infinity,
                                                          )),
                                                      Positioned(
                                                          left: 0,
                                                          right: 0,
                                                          bottom: 0,
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          15),
                                                                  gradient: LinearGradient(
                                                                      colors: [
                                                                        Colors
                                                                            .black12
                                                                            .withOpacity(0),
                                                                        Colors
                                                                            .black
                                                                      ],
                                                                      begin: Alignment
                                                                          .topCenter,
                                                                      end: Alignment
                                                                          .bottomCenter)),
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          15,
                                                                          15,
                                                                          10,
                                                                          8),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    newsModelList[
                                                                            index]
                                                                        .newsHead,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    newsModelList[index].newsHead.length >
                                                                            50
                                                                        ? "${newsModelList[index].newsHead.substring(0, 55)}...."
                                                                        : newsModelList[index]
                                                                            .newsHead,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12),
                                                                  )
                                                                ],
                                                              )))
                                                    ],
                                                  )),
                                            ),
                                          );
                                        } catch (e) {
                                          print(e);
                                          return Container();
                                        }
                                      }),
                            ],
                          ),
                        )

                        // isLoading
                        //     ? Container(
                        //         height: MediaQuery.of(context).size.height - 450,
                        //         child: Center(
                        //           child: CircularProgressIndicator(),
                        //         ),
                        //       )
                        //     :
                        // ListView.builder(
                        //         physics: NeverScrollableScrollPhysics(),
                        //         shrinkWrap: true,
                        //         itemCount: newsModelList.length,
                        //         itemBuilder: (context, index) {
                        //
                        //           return Container(
                        //             child:SingleChildScrollView(child: Column(
                        //               children: [
                        //                 Text(newsModelList[index].newsHead),
                        //               ],
                        //             ),),
                        //           );
                        //         }),
                      ],
                    ),
                  )
                ],
              ),
            ),
        ),
    );
  }
}

class LargeTab extends StatefulWidget {
  const LargeTab({Key? key}) : super(key: key);

  @override
  State<LargeTab> createState() => _LargeTabState();
}

class _LargeTabState extends State<LargeTab> {
  bool like=false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.black,
        title: GlithEffect(
          child: Text(
            'New Blogs',
            style: TextStyle(
              letterSpacing: 1,
            ),
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black87,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 180,
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(
                        1.0,
                        1.0,
                      ),
                      spreadRadius: (1.0),
                      blurRadius: (1.0),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Image.network(
                  imgurl,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 1.0),
                        spreadRadius: (1.0),
                        blurRadius: (1.0),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(30),
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
                  child: Text(
                    head,
                    style: TextStyle(fontSize: 18, wordSpacing: 2),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BackButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.white,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                    IconButton(
                        onPressed: (){
                          setState(() {
                             like= !like;
                            if(like){
                              newsModelList1.add(NewsQueryModel(newsImg:imgurl,newsHead: head));
                            }else{
                              newsModelList1.removeLast();
                            }
                          });
                        },
                      icon: Icon(CupertinoIcons.heart_fill
                        ,color: like?Colors.red:Colors.white,size: 30,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
class Liked extends StatefulWidget {
  const Liked({Key? key}) : super(key: key);

  @override
  State<Liked> createState() => _LikedState();
}

class _LikedState extends State<Liked> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title:Container(child: GlithEffect(
          child: Text(
          "SAVED Blogs ",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.white,
              fontFamily: 'Acme-Regular',
              letterSpacing: 2),
        ),
      ),) ,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: GlithEffect(
                                  child: Text(
                                    "Must Read ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28,
                                        color: Colors.white,
                                        fontFamily: 'Acme-Regular',
                                        letterSpacing: 2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                             ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: newsModelList1.length,
                            itemBuilder: (context, index) {
                              try {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: InkWell(
                                    onTap: () {

                                      setState(() {
                                        imgurl = newsModelList1[index]
                                            .newsImg;
                                        head = newsModelList1[index]
                                            .newsHead;

                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LargeTab()));
                                    },
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                15)),
                                        elevation: 1.0,
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(15),
                                                child: Image.network(
                                                  newsModelList1[index]
                                                      .newsImg,
                                                  fit: BoxFit
                                                      .fitHeight,
                                                  height: 230,
                                                  width:
                                                  double.infinity,
                                                )),
                                            Positioned(
                                                left: 0,
                                                right: 0,
                                                bottom: 0,
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                        gradient: LinearGradient(
                                                            colors: [
                                                              Colors
                                                                  .black12
                                                                  .withOpacity(0),
                                                              Colors
                                                                  .black
                                                            ],
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter)),
                                                    padding:
                                                    EdgeInsets
                                                        .fromLTRB(
                                                        15,
                                                        15,
                                                        10,
                                                        8),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          newsModelList1[
                                                          index]
                                                              .newsHead,
                                                          style:
                                                          TextStyle(
                                                            color: Colors
                                                                .white,
                                                            fontSize:
                                                            20,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          newsModelList1[index].newsHead.length >
                                                              50
                                                              ? "${newsModelList1[index].newsHead.substring(0, 55)}...."
                                                              : newsModelList1[index]
                                                              .newsHead,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize:
                                                              12),
                                                        )
                                                      ],
                                                    )))
                                          ],
                                        )),
                                  ),
                                );
                              } catch (e) {
                                print(e);
                                return Container();
                              }
                            }),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}


// final user=newsModelList[index];
