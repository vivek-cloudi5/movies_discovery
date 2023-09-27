import 'package:flutter/services.dart';
import 'package:movies_discovery/model/movie_model.dart';
import 'package:movies_discovery/provider/detail_provider.dart';
import 'package:movies_discovery/service/local_db_helper.dart';
import 'package:movies_discovery/ui/splash_screen.dart';
import 'package:movies_discovery/util/global.dart';
import 'package:provider/provider.dart';

import 'common_config.dart';

void main() {
  // WIDGET INITIALIZATION
  WidgetsFlutterBinding.ensureInitialized();
  // SQLITE INITIALIZATION
  localDBHelper = DbHelper();
  localDBHelper!.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    lockScreenPortrait();
    return ChangeNotifierProvider(
      create: (BuildContext context){
        var myMovieModel = DetailProvider();
        myMovieModel.allDetails(MovieModel());
        return DetailProvider();
      },
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie Discovery',
        home: SplashScreen(),
      ),
    );
  }
  lockScreenPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

}
