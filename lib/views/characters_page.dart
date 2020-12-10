import 'package:badges/badges.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_bayon/model/Character.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_bayon/model/Character.dart';
import 'package:restaurant_bayon/providers/CommandeModel.dart';

class PlatContainer extends StatelessWidget {
  final List<Plat> plats;
  final int index;

  PlatContainer(this.plats, this.index);

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
                              fontSize: 18, fontWeight: FontWeight.bold),
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
                  Provider.of<CommandeModel>(context, listen: false)
                      .add(this.plats[this.index]);
                  var plat = this.plats[this.index].name;
                  Fluttertoast.showToast(
                    msg: "Vous avez commandé: $plat",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                    webPosition: "center",
                  );
                },
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.brown[600],
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}
