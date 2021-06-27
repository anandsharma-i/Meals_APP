import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

//The screen responsible for displaying all the fav meals.
class FavouriteScreen extends StatelessWidget 
{  
  final List<Meal> favouriteMeals;
  FavouriteScreen(this.favouriteMeals);

  @override
  Widget build(BuildContext context) 
  {
    if(favouriteMeals.isEmpty)//if ther is not fav meal
    {
      return Center
      (
        child: Container
        (
          child: Text('You have no favourites yet - start adding some!'),
        ),
      );
    }
    else
    {
      return ListView.builder
      (
        itemBuilder: (ctx,index)
        {
          return MealItem
          (
            id: favouriteMeals[index].id,
            affordability: favouriteMeals[index].affordability, 
            complexity: favouriteMeals[index].complexity, 
            duration: favouriteMeals[index].duration, 
            imageUrl: favouriteMeals[index].imageUrl, 
            title: favouriteMeals[index].title,
            //removeItem: _removeMeal,
          );
        },
        itemCount: favouriteMeals.length,
      );
    }
    
  }
}