import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:subspace/model/get_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];
  Future<void> fetchBlogs() async {
    int i = 0;
    Map element;
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
          for (element in data["blogs"]) {
            try {
              i++;

              NewsQueryModel newsQueryModel = new NewsQueryModel();
              newsQueryModel = NewsQueryModel.fromMap(element);
              newsModelList.add(newsQueryModel);
              setState(() {
                isLoading = false;
              });

              if (i == 20) {
                break;
              }
            } catch (e) {
              print(e);
            }
            ;
          }
        });
        // final blogs=json['blogs'] as List<dynamic>;
        // final transformed= blogs.map((e){
        //   return NewsQueryModel(
        //     newsHead: e['title'],
        //     newsImg: e['image_url'],
        //   );
        // }).toList();
        // // Request successful, handle the response data here
        // setState(() {
        //     // newsModelList =transformed;
        //   // data['blogs'].forEach((element) {
        //   //   NewsQueryModel newsQueryModel = new NewsQueryModel();
        //   //   newsQueryModel = NewsQueryModel.fromMap(element);
        //   //   // newsModelList.add(newsQueryModel);
        //   //   setState(() {
        //   //     isLoading = false;
        //   //   });
        //   //
        //   // });
        // });
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
  void setState(VoidCallback fn) {
    // TODO: implement setState
    fetchBlogs();
    super.setState(fn);
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(15, 25, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "LATEST NEWS ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                    ],
                  ),
                ),
                // isLoading
                //     ? Container(
                //         height: MediaQuery.of(context).size.height - 450,
                //         child: Center(
                //           child: CircularProgressIndicator(),
                //         ),
                //       )
                //     :
                ListView.builder(
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
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => NewsView(
                                  //             newsModelList[index].newsUrl)));
                                },
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    elevation: 1.0,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              newsModelList[index].newsImg,
                                              fit: BoxFit.fitHeight,
                                              height: 230,
                                              // width: double.infinity,
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
                                                          Colors.black12
                                                              .withOpacity(0),
                                                          Colors.black
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter)),
                                                padding: EdgeInsets.fromLTRB(
                                                    15, 15, 10, 8),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      newsModelList[index]
                                                          .newsHead,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      newsModelList[index]
                                                                  .newsHead
                                                                  .length >
                                                              50
                                                          ? "${newsModelList[index].newsHead.substring(0, 55)}...."
                                                          : newsModelList[index]
                                                              .newsHead,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12),
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
    )));
  }
}
// final user=newsModelList[index];
