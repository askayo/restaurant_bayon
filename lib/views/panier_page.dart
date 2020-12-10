import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_bayon/main.dart';
import 'package:restaurant_bayon/model/Character.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_bayon/model/Character.dart';
import 'package:restaurant_bayon/providers/CommandeModel.dart';

class PanierPage extends StatelessWidget {
  final List<Plat> plats;
  final int index;


  PanierPage(this.plats, this.index);

  Widget build(BuildContext context) {
    var imageurl = "assets/"+this.plats[this.index].images;

    return Container(
      margin: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
      child: AspectRatio(
        aspectRatio: 3 / 1,
        child: Container(
          child: Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1 / 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        imageurl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          this.plats[this.index].name,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          this.plats[this.index].description,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          this.plats[this.index].prix,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  var newindex = this.plats.length == 0 ? this.plats.length : this.index;
                  animKey.currentState.removeItem
                    (
                    newindex, (_, animation) => SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(-1, 0),
                        end: Offset(0, 0),
                      ).animate(animation),
                      child: PanierPage(this.plats, newindex)
                  ),
                      duration: const Duration(milliseconds: 300),
                  );
                   Provider.of<CommandeModel>(context, listen: false)
                       .remove(this.index);



                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red[600],
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
