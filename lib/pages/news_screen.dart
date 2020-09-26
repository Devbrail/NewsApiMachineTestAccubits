import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loadmore/loadmore.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  NewsProvider newsProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    newsProvider = Provider.of(context);
    super.didChangeDependencies();
  }

  String formatDate(String date) {
    DateTime newDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(date);
    DateFormat formatter = DateFormat('dd-MMM-yyyy HH:mm a');
    String formatted = formatter.format(newDate);
    return formatted;
  }

  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Widget shimmerLoader= Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[200],
      enabled: true,
      child: ListView.builder(
        itemBuilder: (_, __) => Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Colors.black)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: width,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey[300],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: width * 0.4,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey[300],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 8,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey[300],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
    Widget headlineRow(int i){
      return  Container(
        margin:
        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: newsProvider.paginatesdHeadLines[i]
                        .urlToImage ==
                        null
                        ? NetworkImage(
                        "https://www.engenome.com/wp-content/uploads/2017/10/news-placeholder.jpg")
                        : NetworkImage(newsProvider
                        .paginatesdHeadLines[i].urlToImage),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                "${newsProvider.paginatesdHeadLines[i].title}",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Mon-Semibold",
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                "${newsProvider.paginatesdHeadLines[i].source.name}",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  fontFamily: "Mon-Semibold",
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${formatDate(newsProvider.paginatesdHeadLines[i].publishedAt)}",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontFamily: "Mon-Regular",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      launchURL(newsProvider
                          .paginatesdHeadLines[i].url);
                    },
                    child: Container(
                      width: 70,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(
                              Radius.circular(20))),
                      child: Center(
                        child: Text(
                          "Website",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: "Mon-Regular",
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
    }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:Helper.newsBackround,
      appBar: AppBar(
        title: Text(
          "Sports News",
          style: TextStyle(
            fontSize: 18,
            fontFamily: "Mon-Semibold",
          ),
        ),
      ),
      body: Center(
        child: ValueListenableBuilder(
          builder: (BuildContext context, int value, Widget child) {
            printData('value changed $value');
            if (value == 0) {
              return shimmerLoader;
            } else if (value == 1)
              return LoadMore(
                isFinish: newsProvider.paginatesdHeadLines.length ==
                    newsProvider.headLines.length,
                onLoadMore: newsProvider.loadMore,
                textBuilder: DefaultLoadMoreTextBuilder.english,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int i) {
                    return headlineRow(i);
                  },
                  itemCount: newsProvider.paginatesdHeadLines.length,
                ),
              );
            else
              return Text(
                'Something went wrong..!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              );
          },
          valueListenable: newsProvider.networkStatus,
        ),
      ),
    );
  }
}
