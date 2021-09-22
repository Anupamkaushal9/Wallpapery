import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart'as http;
import 'fullscreen.dart';


class Wallpaper extends StatefulWidget {
  const Wallpaper({Key key}) : super(key: key);

  @override
  _WallpaperState createState() => _WallpaperState();
   }

class _WallpaperState extends State<Wallpaper> {
 List images = [];
 int page = 1;

 loadmore()async{
   setState(() {
     page = page + 1;
   });
   String url =
       'https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString();
   await http.get(Uri.parse(url), headers: {'Authorization': '563492ad6f91700001000001299972fdbe3944dcb0e81f4f9398566e'}).then(
           (value) {
         Map result = jsonDecode(value.body);
         setState(() {
           images.addAll(result['photos']);
         });
       });
 }

 @override
 void initState() {
   super.initState();
   fetchApi();
 }

  fetchApi()async{
   await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
       headers:{
          "Authorization":"563492ad6f91700001000001299972fdbe3944dcb0e81f4f9398566e"
   }).then((value){
     if(value.statusCode== 200) {
       Map result = jsonDecode(value.body.toString());
       setState(() {
         images = result['photos'];
       });
       print(images[0].toString());
     }
     else
       print("Error");
   });


  }
  @override
  Widget build(BuildContext context) {
    return new  Scaffold(
      body: Column(
        children: [
          Expanded(child: Container(
          child:  new StaggeredGridView.countBuilder(padding:const EdgeInsets.all(8),
              crossAxisCount: 4,itemCount: images.length,
              itemBuilder: (context,i){
              return InkWell(
                  onTap:()=> Navigator.push(context, MaterialPageRoute(builder:(context)=>Fullscreen(
                imageUrl:images[i]['src']['large2x'],
              )
              )
              ),
                child: new Material(
                elevation: 8,
                  borderRadius: new BorderRadius.all(Radius.circular(8)),
                  child: new Hero(tag: 'images',
                        child: new FadeInImage(image: new NetworkImage(images[i]['src']['tiny']),fit: BoxFit.cover,
                          placeholder: new AssetImage("assets/wallpapery.jpg") ,

                       )
                    ),
                  ),
              );
              },
              staggeredTileBuilder: (int index) =>new StaggeredTile.count(2, index.isEven?2:3),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
          ),
          ),
          ),

          InkWell(onTap: loadmore,
            child: Container(
              height: 60,
              width: double.infinity,
              child: Center(child: Text('Load More',style:TextStyle(fontSize: 20,color: Colors.white)
              ,),
              )
              ,color: Colors.black87,),
          )
        ],
      ),
    );
  }
}
