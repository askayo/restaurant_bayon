import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_bayon/model/Character.dart';
import 'package:provider/provider.dart';

const urlget = "https://my-json-server.typicode.com/askayo/demo/plats";

Future<RestaurantModel> loadModelFromInternet() async {
  final model = RestaurantModel();
  final plats = await getRestaurantInfo();
  model.addAll(plats);
  return model;
}


Future <Iterable<Plat>> getRestaurantInfo( )async{
  try{
    final response = await http.get(urlget);
    if(response.statusCode == 200){
      List jsonRes = jsonDecode(response.body);
      final plats = jsonRes.map((item) => new Plat.fromJson(item)).toList();
      return plats;
    }
  }catch(error){
    print(error);
  }
  return [];
}

class RestaurantModel extends ChangeNotifier{
  final List<Plat> _plats = [];
  UnmodifiableListView<Plat> get plats => UnmodifiableListView<Plat>(_plats);
  bool finishedDownloading = false;


  RestaurantModel(){
      _plats.add(Plat(name: "Poulet citronnelle",description: "Poulet citronnelle avec courgette, poivrons et oignons", images: "pouletcitronnelle.jpeg",prix: "6.30€"));
      finishedDownloading = true;
      notifyListeners();
  }

  void add(Plat character){
    _plats.add(character);
    notifyListeners();
  }

  void remove(int index){
    _plats.removeAt(index);
    notifyListeners();
  }

  void addAll(Iterable<Plat> plats){
    _plats.addAll(plats);
    notifyListeners();
  }







}
