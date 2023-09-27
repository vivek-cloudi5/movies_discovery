import 'package:movies_discovery/provider/favorite_provider.dart';
import 'package:movies_discovery/res/colors.dart';
import 'package:movies_discovery/res/styles.dart';
import 'package:movies_discovery/util/global.dart';
import 'package:provider/provider.dart';

import '../common_config.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoriteProvider>(
        create: (context) => FavoriteProvider(),
        child: Builder(
        builder: (context) {
          return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xff3C3261),
                    ),
                  ),
                  title: Text(
                    "Favorite Movie",
                    style: zzRegular35,
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
                body: Consumer<FavoriteProvider>(
                  builder: (context, favority,child){
                    return   SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.red.shade100,
                              Colors.green.shade100,
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            ...favority.myWishListProductList.asMap().entries.map((e) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Card(
                                  surfaceTintColor: black,
                                  borderOnForeground: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 10,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          color: Colors.grey,
                                          image: DecorationImage(
                                              image: NetworkImage(e.value.poster.toString()),
                                              fit: BoxFit.fill),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.white,
                                                blurRadius: 5.0,
                                                offset: Offset(2.0, 5.0))
                                          ],
                                        ),
                                        child: SizedBox(
                                          width: 110.0,
                                          height: 130.0,
                                          child: CachedNetworkImage(
                                            imageUrl: e.value.poster.toString(),
                                            placeholder: (context, url) => const Center(
                                                child: CircularProgressIndicator()),
                                            errorWidget: (context, url, error) =>
                                            const Center(child: Icon(Icons.error)),
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
                                                  style: GoogleFonts.lato(
                                                      fontStyle: FontStyle.italic,
                                                      fontSize: 25.0,
                                                      color: const Color(0xff3C3261)),
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
                                                  ),
                                                ),
                                                const SizedBox(height: 10.0),
                                                Row(
                                                  children: [
                                                    Text.rich(TextSpan(
                                                        children: [
                                                          TextSpan(text: e.value.rating,style: const TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 30.0,
                                                          )),
                                                          const TextSpan(text: '/10',style: TextStyle(
                                                              fontSize: 20
                                                          ))
                                                        ]
                                                    )),
                                                    const Spacer(),
                                                    IconButton(icon: const Icon(Icons.favorite_sharp,color: red,size: 25),onPressed: (){
                                                      localDBHelper!
                                                          .deleteWishList(int.parse(e.value.id.toString()))
                                                          .then((value) {
                                                        showSuccessSnackBar(
                                                          "Wishlist has been removed..!",
                                                          context,
                                                        );
                                                        if (mounted) {
                                                          setState(() {
                                                            favority.isWishList = false;
                                                            favority.getWishListProducts();
                                                          });
                                                        }
                                                      });
                                                    },)
                                                  ],
                                                )
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            }).toList()
                          ],
                        ),
                      ),
                    );
                  },
                )
              ));
        }));


  }
}
