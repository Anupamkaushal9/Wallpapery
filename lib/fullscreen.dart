import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class Fullscreen extends StatefulWidget {
   final String imageUrl;

  const Fullscreen({Key key, this.imageUrl}) : super(key: key);



  @override
  _FullscreenState createState() => _FullscreenState();
}

class _FullscreenState extends State<Fullscreen> {

  Future<void>setWallpaper() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);
    String result = await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(color: Colors.black87,
        child: Column(
          children: [Expanded(child: Container(child: Image.network(widget.imageUrl),)

          ),
            InkWell(onTap: (){setWallpaper();},
              child: Container(
                height: 60,
                width: double.infinity,
                child: Center(child: Text('Set Wallpaper',style:TextStyle(fontSize: 20,color: Colors.white)
                  ,),
                )
                ,color: Colors.black87,),
            )
          ],
        ),
      ),
    );
  }
}
