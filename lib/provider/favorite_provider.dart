import 'package:flutter/cupertino.dart';
import 'package:movies_discovery/model/movie_model.dart';
import 'package:movies_discovery/util/global.dart';

class FavoriteProvider extends ChangeNotifier{
  List<MovieModel> myWishListProductList = [];
  bool isWishList = false;


  FavoriteProvider(){
    getWishListProducts();
  }

  void getWishListProducts() {
    try {
      localDBHelper!.getWishListList().then((value) {
        notifyListeners();
        if (value.isNotEmpty) {
          myWishListProductList = [];
          for (var d in value) {
            MovieModel model = MovieModel();
            model.id = d['movie_id'].toString();
            model.title = d['title'];
            model.releasedate = d['release_date'];
            model.overview = d['overview'];
            model.poster = d['poster'];
            model.rating = d['rating'].toString();
            myWishListProductList.add(model);
            isWishList = false;
          }
        } else {
          myWishListProductList = [];
          isWishList = true;
        }
      });
    } catch (e) {
      debugPrint("$e");
    }
  }
}