import 'package:flutter/material.dart';

//classification of a category as a single unit of class Categoory.
class Category
{
  final String id;
  final String title;
  final Color color;

  //const is a must as the constructer calls are const in dummy_data
  const Category
  (
    {
      @required this.id,
      @required this.title,
      this.color=Colors.orange,            
    }
  );
}