import 'package:flutter/material.dart';

import '../dummy_data.dart';

//The screen responsible for displaying the
// meal detail screen when a meal is tapped.
class MealDetailScreen extends StatelessWidget 
{
  static const routeName='/meal-item';

  final Function toggleFavourite;
  final Function isFavourite;

  MealDetailScreen(this.toggleFavourite,this.isFavourite);

  //builder func for storing the container details for
  //the title for steps and ingredients.
  Widget buildSectionTitle(BuildContext context,String title)
  {
    return Container
    (
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text
      (
        title,
        style: Theme.of(context).textTheme.title,
      ),            
    );
  }

  //builder funcfor storing the container details for
  //the scrollable widgets that will represent
  //steps and ingredients.
  Widget buildContainer(Widget child)
  {
    return Container
    (
      decoration: BoxDecoration
      (
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),              
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 180,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) 
  {
    final mealId=ModalRoute.of(context).settings.arguments as String;
    final selectedMeal=DUMMY_MEALS.firstWhere((meal) => meal.id==mealId);

    return Scaffold
    (
      appBar: AppBar(title: Text('${selectedMeal.title}'),),
      body: SingleChildScrollView//for making whole screen scrollable
      (
        child: Column
        (
          children: 
          [
            Container
            (
              height: 300,
              width: double.infinity,
              child: Image.network
              (
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer
            (
              ListView.builder
              (
                itemBuilder: (ctx,index)
                {
                  return Card
                  (
                    color: Theme.of(context).accentColor,
                    child: Padding
                    (
                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                      child: Text
                      (
                        selectedMeal.ingredients[index],
                        style: TextStyle
                        (
                          fontSize: 17,                          
                        ),
                      ),
                    ),
                  );
                },
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer
            (
              ListView.builder
              (
                itemBuilder: (ctx,index)
                {
                  return Column
                  (
                    children: [
                      ListTile
                      (
                        leading: CircleAvatar
                        (
                          child: Text('${index+1}'),                    
                        ),
                        title: Text
                        (
                          selectedMeal.steps[index],
                          style: TextStyle(fontSize: 17,),
                        ),
                      ),
                      Divider(),//for creating a grey divider line after each step
                    ],
                  );
                },
                itemCount: selectedMeal.steps.length,
              ),              
            ),            
          ],
        ),
      ),

      //the favourite meal button
      floatingActionButton: FloatingActionButton
      (
        child: Icon
        (
          //check if the current meal is fav or not 
          //and display the fav button accordingly.
          isFavourite(mealId)?Icons.star:Icons.star_border,
        ),
        
        //update the fav meal list on tapping
        onPressed: ()=>toggleFavourite(mealId),//()=>Navigator.of(context).pop(mealId),
      ),
    );
  }
}