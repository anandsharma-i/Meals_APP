//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/catergories_screen.dart';
import './models/meal.dart';
import './dummy_data.dart';

void main() 
{
  runApp(const MyApp());
}

class MyApp extends StatefulWidget 
{
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> 
{
  //To store maintain current filter values.
  Map<String,bool> _filters=
  {
    'glutenfree':false,
    'lactosefree':false,
    'vegan':false,
    'vegetarian':false,
  };

  //To maintain current available meals to be displayed(taking count of all filters)
  List<Meal> _availableMeals=DUMMY_MEALS;

  //To maintain current fav meals.
  List<Meal> _favouriteMeals=[];

  //To update current filters and current available meals as selected by user.
  void _setFilters(Map<String,bool> filterData)
  {
    setState
    (
      () 
      {
        //update filters
        _filters=filterData;

        //update current available meals
        _availableMeals=DUMMY_MEALS.where
        (
          (meal)
          {
            if(_filters['glutenfree']&&!meal.isGlutenFree)
              return false;
            if(_filters['lactosefree']&&!meal.isLactoseFree)
              return false;
            if(_filters['vegetarian']&&!meal.isVegetarian)
              return false;
            if(_filters['vegan']&&!meal.isVegan)
              return false;  
            return true;      
          }
        ).toList();
      }
    );
  }

  //to update current fav meals.
  void _toggleFavourite(String mealId)
  {
    //to store index of current meal in the fav meal list
    final existingIndex=_favouriteMeals.indexWhere((meal) => meal.id==mealId);

    //if the current meal is already a fav meal,remove it.
    if(existingIndex>=0)
    {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);      
      });      
    }
    else//if the current meal is not a fav meal,add it.
    {
      setState(() {
        _favouriteMeals.add
        (
          DUMMY_MEALS.firstWhere((meal) => meal.id==mealId)
        );
      });
    }
  }

  //if the current meal is already a fav meal or not.
  bool _isMealFavourite(String mealId)
  {
    return _favouriteMeals.any((meal) => meal.id==mealId);
  }

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      title:'DeliMeals',
      
      //setting up the theme.
      theme: ThemeData
      (        
        primarySwatch: Colors.pink,
        accentColor: Colors.lightBlueAccent,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith
        (
          body1: TextStyle
          (
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          body2: TextStyle
          (
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          title: TextStyle
          (
            fontFamily: 'RobotoCondensed',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
        ),
      ),

      //for setting up the home screen/
      //home:CategoriesScreen(),

      //creates initial screen route.
      initialRoute: '/',//default is '/'

      //creting routes for diff screens.
      routes: 
      {
        //Alternate way of loading home screen.
        '/':(_)=>TabsScreen(_favouriteMeals),

        //For displaying diff meals when inside of a category.
        CategoryMealsScreen.routeName:(_)=>CategoryMealsScreen(_availableMeals),

        //To display details of a meal when inside of a particular meal.
        MealDetailScreen.routeName:(_)=>MealDetailScreen(_toggleFavourite,_isMealFavourite),

        //for displaying the diff meal filters for screening the meals.
        FiltersScreen.routeName:(_)=>FiltersScreen(_filters,_setFilters),
      },            
      
      //creates a dynamic screen route for screens
      //when it has no route option registered.
      onGenerateRoute: (_)=>MaterialPageRoute(builder: (_)=>CategoriesScreen()),

      //creates a dynamic screen route when onGenerateroute() fails to generate route..
      onUnknownRoute: (_)=>MaterialPageRoute(builder: (_)=>CategoriesScreen()),
    );
  }
}

