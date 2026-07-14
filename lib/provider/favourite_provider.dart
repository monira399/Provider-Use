import 'package:flutter/cupertino.dart';

class FavouriteProvider extends ChangeNotifier{
  List<int> _favouriteList =[];

  List<int> get favouriteList => _favouriteList;

  int get favouriteCount => _favouriteList.length;

 bool isFavourite(int id) {
   return _favouriteList.contains(id);
 }

 void toggleFavourite(int id) {
   if(_favouriteList.contains(id)){
     _favouriteList.remove(id);
   } else {
     _favouriteList.add(id);
   }
   notifyListeners();
 }

}