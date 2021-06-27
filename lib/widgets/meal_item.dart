import 'package:flutter/material.dart';

import '../screens/meal_detail_screen.dart';
import '../models/meal.dart';

//For defining how each meal looks like on screen.
class MealItem extends StatelessWidget 
{    
  final String id,title,imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  //final Function removeItem;

  MealItem
  (
    {
     @required this.id, 
     @required this.affordability,
     @required this.complexity,
     @required this.duration,
     @required this.imageUrl,
     @required this.title,
     //@required this.removeItem,
    }
  );
  //getter to extract the complexity of the meal.
  String get complexityText
  {
    switch(complexity)
    {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break; 
      default:
        return 'Unknown';     
    }
  }

  //getter to extract the affordability of the meal.
  String get affordabilityText
  {
    switch(affordability)
    {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Luxurious:
        return 'Luxurious';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      default:
        return 'Unknown';      
    }
  }

  //func to go to meal detail screen if any meal is selected on tapping.
  void selectMeal(BuildContext ctx)
  {
    Navigator.of(ctx).pushNamed//pushes a pre-registered named route desired screen above current screen. 
    (
      MealDetailScreen.routeName,
      arguments:id,//taking the required arguements to the desired screen.
    );/*.then//called when mealdetailscreen is popped.
    (
      (result)
      {
        try//also without cathing the error prog doesn't works as expected.
        {
          if(result!=null)//using if(result){} doesn't works for some reason.
          {
            print('.then is called and result is true.');
            //removeItem(result);
          }   
        }
        catch(e)
        {
          
        }             
      }
    );*/
  }
  
  @override
  Widget build(BuildContext context) 
  {
    return InkWell//display a ripple animation when tapped.
    (
      onTap: ()=>selectMeal(context), 
      child: Card
      (
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(10),
        elevation: 4,
        child: Column
        (
          children: 
          [
            //For displaying text over image.
            Stack
            (
              children: 
              [
                //For clipping the border of image in a certain shape.
                //since we cannet directly manipulate an image that does't
                //support modification.
                ClipRRect
                (
                  //According to our needs only top corners need to be clipped.
                  borderRadius: BorderRadius.only
                  (
                    topLeft:Radius.circular(15),
                    topRight:Radius.circular(15),
                  ),
                  child: Image.network
                  (
                    imageUrl,
                    height: 250,
                    width:double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                
                //This widget helps to position child of stack inside stack.
                Positioned
                (
                  bottom: 20,
                  right: 10,
                  child: Container//For controlling the text more effectively.
                  (
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical:5,horizontal: 20),
                    child: Text
                    (
                      title,
                      style: TextStyle
                      (
                        fontSize: 24,
                        color: Colors.white
                      ),
                      
                      //For adding new lines to the text if its too long.
                      softWrap: true,
                
                      //For managing the visual overflow of the text.
                      overflow: TextOverflow.fade,//fading the extra part.
                
                    ),
                  ),
                ),
              ],
            ),
            Padding
            (
              padding: EdgeInsets.all(20),
              child: Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: 
                [
                  Row//Time taken for preparing meal.
                  (
                    children: 
                    [
                      Icon(Icons.schedule),                      
                      SizedBox(width: 6,),                      
                      Text('$duration min'),                      
                    ],
                  ),
                  Row//meal complexity.
                  (
                    children: 
                    [
                      Icon(Icons.work),                      
                      SizedBox(width: 6,),                      
                      Text(complexityText),                      
                    ],
                  ),
                  Row//meal affordability.
                  (
                    children: 
                    [
                      Icon(Icons.attach_money),                      
                      SizedBox(width: 6,),                      
                      Text(affordabilityText),                      
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}