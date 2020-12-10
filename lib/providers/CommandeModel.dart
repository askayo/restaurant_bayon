import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_bayon/model/Character.dart';
import 'package:restaurant_bayon/model/Panier.dart';



class CommandeModel extends ChangeNotifier{
  final Panier _panier = new Panier([], 0 , 0);

  UnmodifiableListView<Plat> get plats => UnmodifiableListView<Plat>(this._panier.listPlats);

  CommandeModel();


  void add(Plat plat){
    this._panier.listPlats.add(plat);
    notifyListeners();
  }

  void remove(int index){
    this._panier.listPlats.removeAt(index);
    notifyListeners();
  }

  void addAll(Iterable<Plat> plats){
    this._panier.listPlats.addAll(plats);
    notifyListeners();
  }


}
