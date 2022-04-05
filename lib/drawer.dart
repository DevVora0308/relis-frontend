import 'package:flutter/material.dart';
import 'package:relis/arguments/pagearguments.dart';
import 'package:relis/globals.dart';
import 'package:relis/view/homePage.dart';
import 'package:relis/view/pageView.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer();

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  ScrollController drawerScrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color(0xFFdbb018),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width>1000 ? MediaQuery.of(context).size.width*0.3 : MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width*0.3),
        color: Color(0xFF032f4b),
        child: Drawer(
          elevation: 5.0,
          child: ListView(
            padding: EdgeInsets.zero,
            controller: drawerScrollController,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.4,
                padding: EdgeInsets.all(5.0),
                color: Color(0xFFdbb018),
                child: const DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('ReLis.gif',),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    border: Border(
                      top: BorderSide(color: Color(0xFF032f4b), width: 5.0),
                      bottom: BorderSide(color: Color(0xFF032f4b), width: 5.0),
                      left: BorderSide(color: Color(0xFF032f4b), width: 5.0),
                      right: BorderSide(color: Color(0xFF032f4b), width: 5.0),
                    ),
                    color: Color(0xFFdbb018),
                  ),
                  child: Text(""),
                ),
              ),
              ListTile(
                tileColor: Color(0xFF032f4b),
                leading: Icon(Icons.home_rounded, color: Color(0xFFdbb018), size: 22,),
                title: const Text(
                  'Home',
                  style: TextStyle(
                    color: Color(0xFFdbb018),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                hoverColor: Color(0xFF2C3E50),
                enableFeedback: true,
                selected: isPageOpened("Home"),
                selectedTileColor: selectedDrawerTile,
                onTap: () {
                  changePage("Home");
                  gotToRoute(context, pageType.none);
                },
              ),
              SizedBox(height: 2,),
              ListTile(
                tileColor: Color(0xFF032f4b),
                leading: Icon(Icons.category_rounded, color: Color(0xFF00ff00), size: 22,),
                title: const Text(
                  'Genre',
                  style: TextStyle(
                    color: Color(0xFF00ff00),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                hoverColor: Color(0xFF2C3E50),
                enableFeedback: true,
                selected: isPageOpened("Genre"),
                selectedTileColor: selectedDrawerTile,
                onTap: () {
                  changePage("Genre");
                  gotToRoute(context, pageType.category);
                },
              ),
              SizedBox(height: 2,),
              ListTile(
                tileColor: Color(0xFF032f4b),
                leading: Icon(Icons.trending_up_sharp, color: Color(0xFFff5d73), size: 22,),
                title: const Text(
                  'Trending',
                  style: TextStyle(
                    color: Color(0xFFff5d73),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                hoverColor: Color(0xFF2C3E50),
                enableFeedback: true,
                selected: isPageOpened("Trending"),
                selectedTileColor: selectedDrawerTile,
                onTap: () {
                  changePage("Trending");
                  gotToRoute(context, pageType.trending);
                },
              ),
              SizedBox(height: 2,),
              ListTile(
                tileColor: Color(0xFF032f4b),
                leading: Icon(Icons.favorite_rounded, color: Color(0xFFff0000), size: 22,),
                title: const Text(
                  'Favourites',
                  style: TextStyle(
                    color: Color(0xFFff0000),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                hoverColor: Color(0xFF2C3E50),
                enableFeedback: true,
                selected: isPageOpened("Favourites"),
                selectedTileColor: selectedDrawerTile,
                onTap: () {
                  changePage("Favourites");
                  gotToRoute(context, pageType.favourite);
                },
              ),
              SizedBox(height: 2,),
              ListTile(
                tileColor: Color(0xFF032f4b),
                leading: Icon(Icons.bookmark_rounded, color: Color(0xFFffffff), size: 22,),
                title: const Text(
                  'Wish List',
                  style: TextStyle(
                    color: Color(0xFFffffff),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                hoverColor: Color(0xFF2C3E50),
                enableFeedback: true,
                selected: isPageOpened("Wish List"),
                selectedTileColor: selectedDrawerTile,
                onTap: () {
                  changePage("Wish List");
                  gotToRoute(context, pageType.wishList);
                },
              ),
              SizedBox(height: 2,),
              ListTile(
                tileColor: Color(0xFF032f4b),
                leading: Icon(Icons.history, color: Color(0xFFdbb018), size: 22,),
                title: const Text(
                  'History',
                  style: TextStyle(
                    color: Color(0xFFdbb018),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                hoverColor: Color(0xFF2C3E50),
                enableFeedback: true,
                selected: isPageOpened("History"),
                selectedTileColor: selectedDrawerTile,
                onTap: () {
                  gotToRoute(context, pageType.history);
                },
              ),
              SizedBox(height: 2,),
              ListTile(
                tileColor: Color(0xFF032f4b),
                leading: Icon(Icons.book_rounded, color: Color(0xFF00ff00), size: 22,),
                title: const Text(
                  'Books Bought',
                  style: TextStyle(
                    color: Color(0xFF00ff00),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                hoverColor: Color(0xFF2C3E50),
                enableFeedback: true,
                selected: isPageOpened("Bought"),
                selectedTileColor: selectedDrawerTile,
                onTap: () {
                  gotToRoute(context, pageType.bought);
                },
              ),
              SizedBox(height: 2,),
              ListTile(
                tileColor: Color(0xFF032f4b),
                leading: Icon(Icons.timelapse_rounded, color: Color(0xFFff5d73), size: 22,),
                title: const Text(
                  'Books Rented',
                  style: TextStyle(
                    color: Color(0xFFff5d73),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                hoverColor: Color(0xFF2C3E50),
                enableFeedback: true,
                selected: isPageOpened("Rented"),
                selectedTileColor: selectedDrawerTile,
                onTap: () {
                  changePage("Rented");
                  gotToRoute(context, pageType.rented);
                },
              ),
              SizedBox(height: 2,),
            ],
          ),
        ),
      ),
    );
  }
}
