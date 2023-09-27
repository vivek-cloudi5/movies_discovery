import 'package:movies_discovery/res/styles.dart';
import 'package:photo_view/photo_view.dart';

import '../common_config.dart';
import '../res/colors.dart';

class ViewFullScreenImage extends StatelessWidget {
  final String? myImageUrl, myTitle;
  const ViewFullScreenImage(this.myImageUrl, this.myTitle, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back, color: Color(0xff3C3261))),
        title: Text(
          myTitle.toString(),
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
      body: PhotoView(
        imageProvider: NetworkImage(myImageUrl.toString()),
      ),
    ));
  }
}
