
import 'package:movies_discovery/model/movie_model.dart';
import 'package:movies_discovery/provider/list_provider.dart';
import 'package:movies_discovery/res/colors.dart';
import 'package:movies_discovery/res/styles.dart';
import 'package:movies_discovery/ui/favorite.dart';
import 'package:movies_discovery/ui/view_photo.dart';
import 'package:provider/provider.dart';

import '../common_config.dart';
import 'movie_detail.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListProvider>(
        create: (context) => ListProvider(),
        child: Builder(
        builder: (context) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text("Movie Discovery",
                  style: zzRegular35),
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
                actions: [
                  IconButton(onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const FavoriteScreen(),
                      ),
                    );
                  }, icon: const Icon(Icons.favorite,size:35,color: Color(0xff3C3261)))
                ],
              ),
              body: Consumer<ListProvider>(
                builder: (context,provider,child){
                  return Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 190.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.red.shade100,
                              white,
                            ],
                          ),),
                        child: ListView.builder(
                            itemCount: provider.myMovies.length,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(5),
                            itemBuilder: (BuildContext context,int i){
                              MovieModel model = provider.myMovies[i];
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ViewFullScreenImage(model.poster.toString(),model.title.toString()),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CachedNetworkImage(
                                    imageUrl: model.poster.toString(),
                                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                    fit: BoxFit.fill, // Image fit mode
                                  ),
                                ),
                              );
                            }),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.red.shade200,
                                  Colors.green.shade200,
                                  Colors.blue.shade200,
                                ],
                              ),),
                            child: Column(
                              children: [
                                ...provider.myMovies.asMap().entries.map((e) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                    child: Card(
                                      surfaceTintColor: black,
                                      borderOnForeground: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      elevation: 10,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => MovieDetail(movieModel: e.value,),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              margin: const EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                color: Colors.grey,
                                                image: DecorationImage(
                                                    image:
                                                    NetworkImage(e.value.poster.toString()),
                                                    fit: BoxFit.fill),
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: Colors.white,
                                                      blurRadius: 5.0,
                                                      offset: Offset(2.0, 5.0))
                                                ],
                                              ),
                                              child: Container(
                                                width: 110.0,
                                                height: 130.0,
                                                child: CachedNetworkImage(
                                                  imageUrl: e.value.poster.toString(),
                                                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                                  fit: BoxFit.fill, // Image fit mode
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: Container(
                                                  margin:
                                                  const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        e.value.title.toString(),
                                                        style: GoogleFonts.lato(fontStyle: FontStyle.italic,fontSize: 25.0,color: const Color(0xff3C3261)),
                                                        /*   style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff3C3261)),*/
                                                      ),
                                                      const SizedBox(
                                                        height: 2.0,
                                                      ),
                                                      const Divider(
                                                        color: Colors.black,
                                                      ),
                                                      const SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Text(
                                                        e.value.overview.toString(),
                                                        maxLines: 3,
                                                        style: const TextStyle(
                                                            color: Color(0xff8785A4),
                                                            fontFamily: 'Arvo'),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )
            ),
          );
        }));

  }
}
