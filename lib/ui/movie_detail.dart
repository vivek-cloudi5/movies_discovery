import 'package:flutter/material.dart';
import 'package:movies_discovery/model/movie_model.dart';
import 'package:movies_discovery/provider/detail_provider.dart';
import 'package:movies_discovery/res/styles.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';

import 'view_photo.dart';

class MovieDetail extends StatefulWidget {
  final MovieModel? movieModel;
  const MovieDetail( {
    super.key,
    this.movieModel,
  });

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {

@override
  void initState() {
  Provider.of<DetailProvider>(context, listen: false).allDetails(widget.movieModel!);
    super.initState();
  }
  @override
  Widget build(BuildContext buildContext) {
  return Consumer(builder: (BuildContext context, details ,child) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(buildContext).pop();
                },
                icon: const Icon(Icons.arrow_back,
                    color: Color(0xff3C3261))),
            title: Text(
              "Movie Discovery",
              style: zzRegular35
            ),
            titleSpacing: 00.0,
            centerTitle: true,
            toolbarHeight: 60.2,
            toolbarOpacity: 0.8,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
            ),
            elevation: 0.00,
            backgroundColor: Colors.green.shade200,
          ),
          body: Consumer<DetailProvider>(
              builder: (context, details, child) {
                return Stack(fit: StackFit.expand, children: [
                  Image.network(
                    details.model.poster.toString(),
                    fit: BoxFit.fill,
                  ),
                  BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        details.model.poster.toString()),
                                    fit: BoxFit.fill),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 20.0,
                                      offset: Offset(0.0, 10.0))
                                ]),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ViewFullScreenImage(
                                        details.model.poster.toString(),
                                        details.model.title.toString()),
                                  ),
                                );
                              },
                              child: const SizedBox(
                                width: 400.0,
                                height: 400.0,
                              ),
                            ),
                          ),
                          Container(
                            padding:
                            const EdgeInsets.only(top: 20, bottom: 2),
                            margin:
                            const EdgeInsets.only(left: 0.0, right: 0.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Text(
                                      details.model.title.toString(),
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 30.0),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: <Widget>[
                                const Text(
                                  'Release Date :',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25.0),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  details.movieDate!.toString(),
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 25.0),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(details.model.overview.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20)),
                          const Padding(padding: EdgeInsets.all(20.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                    width: 150.0,
                                    height: 60.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                        color: const Color(0xaa3C3261)),
                                    child: Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text:
                                          details.model.rating.toString(),
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 30.0,
                                          )),
                                      const TextSpan(
                                          text: '/10',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25.0,
                                          ))
                                    ])),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      details.onShare(context);
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                        color: const Color(0xaa3C3261)),
                                    child: const Icon(
                                      Icons.share,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  details.addWishListToDb(context);
                                },
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          color: const Color(0xaa3C3261)),
                                      child: Icon(
                                        details.isWishList
                                            ? Icons.favorite_sharp
                                            : Icons.favorite_border,
                                        color: details.isWishList
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ]);
              })),
    );
  });
  }
}
