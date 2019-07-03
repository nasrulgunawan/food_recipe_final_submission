import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_recipes/model/foods.dart';
import 'package:food_recipes/network/response.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail';

  Widget _contentText(data) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            data.meal,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black.withAlpha(170)),
            textAlign: TextAlign.left,
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 5),
            child: Text("Ingredients:",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          Text(data.ingredients),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 5),
            child: Text("Cooking Steps:",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          Text(data.instructions, textAlign: TextAlign.justify)
        ],
      ),
    );
  }

  Widget _contentImage(data) {
    return Hero(
      tag: "hero-${data.id}",
      child: Container(
        alignment: Alignment.topCenter,
        child: CachedNetworkImage(
          imageUrl: data.image,
          placeholder: (context, url) => Container(
              padding: EdgeInsets.all(50), child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final FoodArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
            title: Text('Detail Recipe')
        ),
        body: FutureBuilder(
          future: Response().fetchFoodDetail(args.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        _contentImage(snapshot.data[0]),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.all(Radius.circular(3))
                            ),
                            child: Text(snapshot.data[0].tags),
                          ),
                        )
                      ],
                    ),
                    _contentText(snapshot.data[0])
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Data gagal dimuat"));
            }

            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.pink)));
          },
        ));
  }
}
