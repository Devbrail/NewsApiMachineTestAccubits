import 'package:flutter/cupertino.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/utils/helper.dart';
import 'package:news_app/utils/http.dart';
import 'package:news_app/utils/network.dart';

class NewsProvider extends ChangeNotifier {
  Fetch _fetch = Fetch();

  List<NewsModel> _headLines = List();
  List<NewsModel> _paginatesdHeadLines = List();

  List<NewsModel> get headLines => _headLines;

  List<NewsModel> get paginatesdHeadLines => _paginatesdHeadLines;

  ValueNotifier<int> networkStatus = ValueNotifier<int>(0);

  getNewsApi() async {
    try {
      var data = await _fetch.get(
          url:
              '${Urls.rootUrl}category=${Urls.sportsCategory}&apiKey=${Urls.apiKey}');

      if (data != null && data['status'] == 'ok') {
        _headLines = List();

        if (data['articles'] != null && data['articles'].length > 0) {
          networkStatus.value = 1;
          for (var i = 0; i < data['articles'].length; i++) {
            _headLines.add(NewsModel.fromJson(data['articles'][i]));

            print('ddddd');
            // for taking first five result

            if (i <= 5) {
              _paginatesdHeadLines.add(NewsModel.fromJson(data['articles'][i]));
            }

            notifyListeners();
          }
        } else
          networkStatus.value = 2;
      } else
        networkStatus.value = 2;
    } catch (e, s) {
      print(s);
    }
  }

  Future<bool> loadMore() async {
    print("onLoadMore   ${_paginatesdHeadLines.length} ${_headLines.length}");
    await Future.delayed(Duration(seconds: 2,));

    if(_paginatesdHeadLines.length==_headLines.length){
      return false;
    }

    int nextCount = _paginatesdHeadLines.length + 5 <= _headLines.length
        ? _paginatesdHeadLines.length + 5
        :  _paginatesdHeadLines.length;
    printData(nextCount.toString());
    printData(nextCount.toString());
    for (int i = _paginatesdHeadLines.length - 1; i < nextCount; i++) {
      _paginatesdHeadLines.add(_headLines[i]);
      notifyListeners();
    }
    return true;
  }
}
