import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

//The screen responsible for displaying all the meals for each categories.
class CategoryMealsScreen extends StatefulWidget 
{
  /*String categoryId,categoryTitle;

  CategoryMealsScreen(this.categoryId,this.categoryTitle);*/

  //storing the route name of the current screen.
  static const routeName='/category-item';
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> 
{
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData=false;//to store whether initial data is stored or not.

  //initstate can't be called for any .of(context) objects. 
  /*@override
  void initState()
  {       
    super.initState();
  }*/
  
  //This is called whenever the dependencies
  //of the state object changes.
  //Eg - when the first time element/widget tree is formed.
  //Eg - When we delete the meal item from meal detail screen
  //dependencies are changing.
  @override  

  //this was done to make sure the depencies change affects the initial loaded
  //data only once(done for the removeMeal() func later was discarded.)
  void didChangeDependencies() 
  {        
    if(_loadedInitData!=null)
    {      
      //for recieving the arguements sent through
      // .pushedNamed (when screens are changed).
      //recieved category title and id from the categories screen.
      final routeArgs=ModalRoute.of(context).settings.arguments as Map<String,String>;
      categoryTitle=routeArgs['title'];
      final categoryId=routeArgs['id'];

      //for storing the meals to be displayed
      // after the temporary deleting takes place.
      displayedMeals=widget.availableMeals.where
      (
        //checks every meals from meal.dart
        (meal)
        {
          //checks every categories of each meals
          //that matches with current category id
          //and adds those meals to categoryMeals.
          return meal.categories.contains(categoryId);
        }
      ).toList();
      print('didChangeDependencies() is called');
      _loadedInitData=true;//To make sure above changes happens only once.
    }    
    super.didChangeDependencies();
  }

  //used for deleting the meal from meal item screen temporarily 
  //only to get it back again on screen on re-visiting
  //the meal item screen. Later this funct is not used anymore.
  void _removeMeal(String mealId)
  {
    print('Item removed');
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id==mealId);
    });    
  }
  @override
  Widget build(BuildContext context) 
  {    
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text(categoryTitle),
      ),
      body: ListView.builder//for displaying dif meals for current category
      (
        itemBuilder: (ctx,index)
        {
          return MealItem//creating meals for current category.
          (
            id: displayedMeals[index].id,
            affordability: displayedMeals[index].affordability, 
            complexity: displayedMeals[index].complexity, 
            duration: displayedMeals[index].duration, 
            imageUrl: displayedMeals[index].imageUrl, 
            title: displayedMeals[index].title,
            //removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}