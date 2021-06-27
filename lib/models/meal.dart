import 'package:flutter/foundation.dart';

//to store complexity values
enum Complexity
{
  Simple,
  Challenging,
  Hard
}

//to store affordability values
enum Affordability
{
  Affordable,
  Pricey,
  Luxurious,
}

//classification of a meal as a single unit of class Meal.
class Meal 
{
 final String  id,title,imageUrl;
 final List<String> categories,ingredients,steps; 
 final int duration;
 final Complexity complexity;
 final Affordability affordability;
 final bool isGlutenFree;
 final bool isLactoseFree;
 final bool isVegan;
 final bool isVegetarian;

  //const is a must as the constructer calls are const in dummy_data
  const Meal
  (
    {
      @required this.title,
      @required this.affordability,
      @required this.categories,
      @required this.complexity,
      @required this.duration,
      @required this.id,
      @required this.imageUrl,
      @required this.ingredients,
      @required this.isGlutenFree,
      @required this.isLactoseFree,
      @required this.isVegan,
      @required this.isVegetarian,
      @required this.steps,          
    }
  );

}