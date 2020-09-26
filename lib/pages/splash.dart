import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      newsProvider.getNewsApi();

      if (mounted) Navigator.popAndPushNamed(context, '/news_headline');
    });
    super.initState();
  }

  NewsProvider newsProvider;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    newsProvider = Provider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Helper.splashBackround,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: SizedBox(
            height: 100.0,
            child: Shimmer.fromColors(
              baseColor: Helper.fontWhite,
              highlightColor: Helper.colorGray,
              child: Text(
                'News Headlines',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
