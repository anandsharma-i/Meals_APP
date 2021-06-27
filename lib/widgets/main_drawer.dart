import 'package:flutter/material.dart';
import 'package:meals_app/screens/filters_screen.dart';

//Main drawer on the left side of screen with hamburger icon.
class MainDrawer extends StatelessWidget 
{
  //builder method for creating cutom widgets to avoid code dupclicacy.
  Widget buildListTile(String title,IconData icon,Function tapHandler)
  {
    return ListTile
          (
            leading: Icon
            (
              icon,size: 26,
            ),
            title: Text
            (
              title,
              style: TextStyle
              (
                fontFamily:'RobotoCondensed' ,
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            ),
            onTap:tapHandler ,
          );
  }

  @override
  Widget build(BuildContext context) 
  {
    return Drawer//resposible for creating the drawer.
    (
      child: Column
      (
        children: 
        [
          Container
          (
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text
            (
              'Cooking Up!',
              style: TextStyle
              (
                fontWeight:FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(height: 20,),
          buildListTile//meal option(for going to home screen)
          (
            'Meals',
            Icons.restaurant,
            ()=>Navigator.of(context).pushReplacementNamed('/'),
          ),        
          buildListTile//filter option(for going to filters screen)
          (
            'Filters',
            Icons.settings,
            ()=>Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName),
          ),        
        ],
      ),
    );
  }
}