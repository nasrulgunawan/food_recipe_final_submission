import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_recipes/views/detail/detail_screen.dart';
import 'package:food_recipes/network/response.dart';
import 'package:food_recipes/model/foods.dart';

class Menu extends StatefulWidget {
  Menu({Key key, this.category}) : super(key: key);
  final String category;

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Future<List<Food>> foods;
  List<Food> _foods = List<Food>();
  DataSearch _dataSearch;

  @override
  void initState() {
    super.initState();
    foods = Response().fetchFood(widget.category);
    foods.then((value) {
      setState(() {
        _foods.addAll(value);
        _dataSearch = DataSearch(_foods, widget.category);
      });
    });

  }

//  @override
//  void didChangeDependencies(){
//    super.didChangeDependencies();
//
//    setState(() {
//      foods = Response().fetchFood(widget.category);
//      foods.then((value) {
//        setState(() {
//          _foods.addAll(value);
//          _dataSearch = DataSearch(_foods, widget.category);
//        });
//      });
//    });
//
//  }

  Widget _mealThumb(data) {
    return Hero(
      tag: "hero-${data.id}",
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: CachedNetworkImage(
          imageUrl: data.image,
          placeholder: (context, url) => Container(
              padding: EdgeInsets.all(50),
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.pink))),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _mealName(data) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        data.meal,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _listItem(data, index) {
    return GestureDetector(
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: EdgeInsets.all(10),
        child: Stack(
          children: <Widget>[
            Positioned.fill(child: _mealThumb(data[index])),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: _mealName(data[index]),
              ),
            )
          ],
        ),
      ),
      onTap: () => _goToDetail(context, data[index]),
    );
  }

  Widget _menu() {
    return Container(
      child: FutureBuilder<List<Food>>(
          future: foods,
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: _foods.length,
                  itemBuilder: (context, index) {
                    return _listItem(_foods, index);
                  });
            } else if (snapshot.hasError) {
              return Center(child: Text("Gagal memuat data"));
            }

            return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.pink)));
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Recipe ${widget.category}"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearchPage(context, _dataSearch);
              })
        ],
      ),
      body: _menu(),
    );
  }

  //Shows Search result
  void showSearchPage(BuildContext context, DataSearch dataSearch) async {
    final String selected = await showSearch<String>(
      context: context,
      delegate: dataSearch,
    );

    if (selected != null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Your Word Choice: $selected'),
        ),
      );
    }
  }
}

void _goToDetail(context, data) {
  final snackBar = SnackBar(content: Text("Recipe: ${data.meal} Clicked!"));

  Navigator.pushNamed(context, DetailScreen.routeName,
      arguments: FoodArguments(data.id));

  Scaffold.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}

class DataSearch extends SearchDelegate<String> {

  final List<Food> _foods;
  final List<String> _history;
  final String _foodCategory;

  DataSearch(List<Food> foods, String foodCategory)
      : _foods = foods,
        //pre-populated history of words
        _history = <String>['apple', 'orange', 'banana', 'watermelon'],
        _foodCategory = foodCategory,
        super();

//  DataSearch(this.foods);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? []
        : _foods.where((food) {
            var foodName = food.meal.toLowerCase();
            return foodName.contains(query);
          }).toList();

//    return Text("TEST DATA LOG ${suggestionList}");


    if (suggestionList.length > 0) {
      return ListView.builder(
        itemBuilder: (context, index) => Card(
//          margin: EdgeInsets.only(lef),
            child: ListTile(
                contentPadding: EdgeInsets.all(10),
                onTap: () {
                  _goToDetail(context, suggestionList[index]);
                },
                leading: _MenuState()._mealThumb(suggestionList[index]),
                title: Text(suggestionList[index].meal),
                subtitle: Text(_foodCategory),
            ),
        ),
        itemCount: suggestionList.length);
    } else {
      return Container(
        child: Text("Search Data", textAlign: TextAlign.center),
        padding: EdgeInsets.all(20),
      );
    }


//
  }
}
