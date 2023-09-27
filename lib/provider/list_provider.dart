
import 'package:movies_discovery/model/movie_model.dart';

import '../common_config.dart';

class ListProvider extends ChangeNotifier{
  final PageController pageController = PageController();
  List<MovieModel> myMovies = [];

  ListProvider(){
    getMovie();
  }


  void getMovie() async {
    final data = await rootBundle.loadString("assets/myMovies.json");
    var aList = jsonDecode(data.toString());
    for (var m in aList) {
      myMovies.add(MovieModel.fromJson(m));
    }
    notifyListeners();
  }
}