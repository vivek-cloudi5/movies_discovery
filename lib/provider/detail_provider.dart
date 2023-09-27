

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_discovery/util/global.dart';
import 'package:share_plus/share_plus.dart';

import '../model/movie_model.dart';


class DetailProvider extends ChangeNotifier{
  Color mainColor = const Color(0xff3C3261);
  String? movieDate;
  bool isWishList = false;
  MovieModel model = MovieModel();

  DetailProvider(){
    isWishList = true;
    notifyListeners();
  }

  void allDetails(MovieModel movieModel){
    model = movieModel;
    debugPrint('SHOW THE PRINT::${model.releasedate}');
   try{
     if(model.releasedate != null){
       DateTime dt = DateTime.fromMillisecondsSinceEpoch(
           int.parse(model.releasedate.toString()));
       movieDate = DateFormat('dd MMM yyyy').format(dt);
     } else {
       checkIsAddedToWishList();
     }
   } catch(e){
     debugPrint('e');
   }
    notifyListeners();
  }

  void addWishListToDb(BuildContext context) {
    try {
      if (isWishList) {
        localDBHelper!
            .deleteWishList(int.parse(model.id!))
            .then((value) {
          showSuccessSnackBar(
            "Wishlist has been removed..!",
            context,
          );
          isWishList = false;
        });
      } else {
        Map<String, dynamic> data = <String, dynamic>{};
        data['movie_id'] = model.id!;
        data['title'] = model.title!;
        data['poster'] = model.poster!;
        data['overview'] = model.overview!;
        data['release_date'] = movieDate;
        data['rating'] = model.rating!;
        localDBHelper!.insertIntoWishListTable(data).then((value) {
          isWishList = true;
          showSuccessSnackBar(
            "Wishlist successfully added..!",
            context,
          );
        });
      }
    } catch (e) {
      debugPrint("$e");
    }
    notifyListeners();
  }


  void checkIsAddedToWishList() {
    try {
      localDBHelper!
          .getSingleWishList(int.parse(model.id!))
          .then((value) {
        if(value.isNotEmpty) {
          isWishList = true;
        } else {
          isWishList = false;
        }
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  void onShare(context) {
    notifyListeners();
    try {
      final box = context.findRenderObject() as RenderBox?;
      Share.share(
        model.poster.toString(),
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    } catch (e) {
      debugPrint("$e");
    }
  }


}