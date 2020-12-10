import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';

/// Flutter code sample for BottomNavigationBar

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_bayon/model/Character.dart';
import 'package:restaurant_bayon/providers/RestaurantModel.dart';
import 'package:restaurant_bayon/views/characters_page.dart';
import 'package:restaurant_bayon/views/panier_page.dart';

import 'providers/CommandeModel.dart';
import 'views/map_page.dart';

final List<String> imgList = [
  "assets/nouille.jpeg",
  "assets/rizcantonnais.jpeg",
];

final GlobalKey<AnimatedListState> animKey = GlobalKey<AnimatedListState>();

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(20),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      item,
                      width: 700.0,
                      fit: BoxFit.fill,
                    ),
                    Container(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Plat du moment',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                              backgroundColor: Colors.black12),
                        ))
                    // Image.network(item, fit: BoxFit.fill, width: 700.0),,
                  ],
                )),
          ),
        ))
    .toList();

void main() => {
      runApp(
        FutureProvider(
          create: (context) => loadModelFromInternet(),
          initialData: RestaurantModel(),
          child: MyApp(),
        ),
      ),
    };

/// This is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Restaurant Bayon';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CommandeModel>(
        create: (context) => CommandeModel(),
        child: MaterialApp(
          title: _title,
          home: MyStatefulWidget(),
        ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  //LISTE WIDGET AVEC LES 3 ONGLETS
  static List<Widget> _widgetOptions = <Widget>[
    Consumer<RestaurantModel>(builder: (context, restaurantModel, child) {
      return Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items: imageSliders,
          ),
          Text(
            "PLAT DU JOUR",
            style: optionStyle,
          ),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => Divider(
                      thickness: 2,
                      height: 20,
                      color: Colors.grey,
                    ),
                itemBuilder: (BuildContext context, int index) {
                  return PlatContainer(restaurantModel.plats, index);
                },
                itemCount: restaurantModel.plats.length),
          )
        ],
      );
    }),
    Consumer<CommandeModel>(builder: (context, commandeModel, child) {
      return Column(
        children: [
          Text(
            "Votre panier",
            style: optionStyle,
          ),
          Expanded(
              child: AnimatedList(
            key: animKey,
            initialItemCount: commandeModel.plats.length,
            itemBuilder: (context, index, animation) {
              return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: Offset(0, 0),
                  ).animate(animation),
                  child:
                      PanierPage(commandeModel.plats, index)); // Refer step 3
            },
          ))
        ],
      );
    }),
    MapView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Restaurant Bayon'),
        ),
        body: PageTransitionSwitcher(
          duration: Duration(seconds: 1),
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return FadeThroughTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                child: child);
          },
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar:
            Consumer<CommandeModel>(builder: (context, commandeModel, child) {
          var nb = commandeModel.plats.length;
          return BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant),
                label: 'Plats',
              ),
              BottomNavigationBarItem(
                label: 'Panier',
                icon: Badge(
                  shape: BadgeShape.circle,
                  borderRadius: BorderRadius.circular(100),
                  child: Icon(Icons.shopping_basket),
                  badgeContent: Text("$nb"),
                  badgeColor: Colors.green,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pin_drop),
                label: 'Lieu',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          );
        }));
  }
}
