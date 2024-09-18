import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:short_news_app/models/news_channel_headlines_model.dart';
import 'package:short_news_app/view%20model/news_view_model.dart';
import 'package:short_news_app/view/categories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList {bbcNews, aryNews, independent, reuters, cnn, aljazeera}



class _HomeScreenState extends State<HomeScreen> {


  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedMenu;

  final format = DateFormat('MMMM dd, yyyy');

  String name = 'bbc news';


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesScreen()),);
          },
          icon: Image.asset(
            'images/category_icon.png',
            height: 30,
            width: 30,
          ),
        ),
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,

        actions: [
          PopupMenuButton<FilterList>(
            onSelected: (FilterList item){
              if(FilterList.bbcNews.name == item.name){
                name = 'bbc-news';
              }
              if(FilterList.aryNews.name == item.name){
                name = 'ary-news';
              }
              if(FilterList.independent.name == item.name){
                name = 'independent-news';
              }
              if(FilterList.reuters.name == item.name){
                name = 'reuters-news';
              }
              if(FilterList.cnn.name == item.name){
                name = 'cnn-news';
              }
              if(FilterList.aljazeera.name == item.name){
                name = 'al-jazeera-english';
              }
             newsViewModel.fetchNewsChannelHeadlinesApi();
            },
            icon: Icon(Icons.more_vert, color: Colors.black,),
            initialValue: selectedMenu,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>> [
                PopupMenuItem<FilterList>(
                  value: FilterList.bbcNews,
                  child: Text('BBC News'),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.aryNews,
                  child: Text('ARY News'),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.independent,
                  child: Text('Independent News'),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.reuters,
                  child: Text('Reuters News'),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.cnn,
                  child: Text('CNN News'),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.aljazeera,
                  child: Text('Al-Jazeera News'),
                ),
              ]
          ),
        ],

      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelHeadlinesApi(),
              builder: (BuildContext context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                }
                else{
                 return ListView.builder(
                   itemCount: snapshot.data!.articles!.length,
                     scrollDirection: Axis.horizontal,
                     itemBuilder: (context, index){
                     
                     DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                     
                     
                       return SizedBox(
                         child: Stack(
                           alignment: Alignment.center,
                           children: [
                             Container(
                               height: height * 0.6,
                               width: width * .9,
                               padding: EdgeInsets.symmetric(
                                 horizontal: height * 0.02,
                               ),
                               child: ClipRRect(
                                 borderRadius: BorderRadius.circular(15),
                                 child: CachedNetworkImage(
                                     imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                   fit: BoxFit.cover,
                                   placeholder: (context, url) =>Container(
                                     child: spinkit2,
                                   ),
                                   errorWidget: (context, url, error) => Icon(Icons.error_outline, color: Colors.red,),
                                 ),
                               ),
                             ),
                             Positioned(
                               bottom: 20,
                               child: Card(
                                 elevation: 5,
                                 color: Colors.white,
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(12),
                                 ),
                                 child: Container(
                                   padding: EdgeInsets.all(15),
                                   alignment: Alignment.bottomCenter,
                                   height: height * .22,
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                       Container(
                                         width: width * 0.7,
                                         child: Text(snapshot.data!.articles![index].title.toString(),
                                         maxLines: 3,
                                         overflow: TextOverflow.ellipsis,
                                         style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700),
                                         ),
                                       ),
                                       Spacer(),
                                   Container(
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                       children: [
                                         Text(
                                           snapshot.data!.articles![index].source!.name.toString(),
                                           maxLines: 2,
                                           overflow: TextOverflow.ellipsis,
                                           style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                                         ),
                                         SizedBox(width: 75,),
                                         Text(
                                           format.format(dateTime),
                                           maxLines: 2,
                                           overflow: TextOverflow.ellipsis,
                                           style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                                         ),
                                       ],
                                     ),
                                   ),


                                   ],
                                   ),
                                 ),

                               ),
                             )
                           ],
                         ),
                       );
                     }
                 );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);