import 'package:flutter/material.dart';

import '../screens/category_meals_screen.dart';

//For defining how each category looks like on screen.
class CategoryItem  extends StatelessWidget 
{      
  final String id,title;
  final Color color;

  CategoryItem({this.id,this.color,this.title});

  //func to go to meal_item screen if any category is selected on tapping.
  void selectCategory(ctx)
  {
    Navigator.of(ctx).pushNamed
    (
      CategoryMealsScreen.routeName,

      //taking the category id and title to the category_meal screen.
      arguments:{'id':id,'title':title},
    );
  }

  @override
  Widget build(BuildContext context) 
  {
    return InkWell
    (
      onTap: ()=>selectCategory(context),

      //setting splash color for inkwell effect.
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container
      (
        padding: const EdgeInsets.all(15),
        child: Text
        (
          title,
          style: Theme.of(context).textTheme.title,
          //style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
        ),
        decoration: BoxDecoration
        (
          gradient: LinearGradient//for setting gradient color effect
          (
            colors: 
            [
              color.withOpacity(0.7),//starting color opacity
              color,//ending color opacity
            ],
            begin: Alignment.topLeft,//starting position for gradient effect
            end: Alignment.bottomRight,//ending position for gradient effect
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}