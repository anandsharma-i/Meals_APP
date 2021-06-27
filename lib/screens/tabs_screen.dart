import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import './favourite_screen.dart';
import './catergories_screen.dart';

//The home screen responsible for displaying two tabs
//one for all categories and one for fav meals.
class TabsScreen extends StatefulWidget 
{    
  final List<Meal> favouriteMeals;  
  TabsScreen(this.favouriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> 
{
  //For storing the categories screen and favourite screen.
  List<Map<String,Object>> _pages;
    
  //for storing the index of the current screen.
  int _selectedPageIndex=0;

  //updating the ui and the screen index
  void _selectPage(int index)
  {
    setState(() {
     _selectedPageIndex=index; 
    });
  } 
  
  @override
  void initState() //initialising the pages to be displayed in diff abs
  {
    _pages=
  [
    {'page':CategoriesScreen(),'title':'Categories'},
    {'page':FavouriteScreen(widget.favouriteMeals),'title':'Your Favourite'},
  ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) 
  {
    return /*DefaultTabController
    (
      length: 2, 
      child: */
      Scaffold
      (
        appBar: AppBar
        (
          title: Text(_pages[_selectedPageIndex]['title']),
          /*bottom: TabBar
          (
            tabs: 
            [
              Tab
              (
                icon: Icon(Icons.category),
                text: 'Categories',
              ),
              Tab
              (
                icon: Icon(Icons.star),
                text: 'Favourites',
              ),
            ]
          ),*/
        ),
        drawer:MainDrawer(),//for displaying the main drawer
        body: 
        /*TabBarView
        (
          children: 
          [
            CategoriesScreen(),
            FavouriteScreen(),
          ]
        ),*/
        _pages[_selectedPageIndex]['page'],

        //Setting up the bottom navigation bar.
        bottomNavigationBar: BottomNavigationBar
        (
          //on tap action of tapping one of the bottom nav bar item.
          onTap: _selectPage,          
          backgroundColor:Theme.of(context).primaryColor,

          //setting the color for selected item.
          selectedItemColor: Theme.of(context).accentColor,

          //setting the color for unselected item.
          unselectedItemColor: Colors.white,

          //for storing the current page index.
          currentIndex: _selectedPageIndex,

          //items
          items: 
          [
            BottomNavigationBarItem
            (
              icon: Icon(Icons.category),
              title: Text('Categories'),
            ),
    	      BottomNavigationBarItem
            (
              icon: Icon(Icons.star),
              title: Text('Favourites'),
            ),
          ],

        ),
      );
    //);
  }
}