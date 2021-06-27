import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widgets/category_item.dart';

//The screen responsible for displaying all the categories.
class CategoriesScreen extends StatelessWidget 
{  
  @override
  Widget build(BuildContext context)
   {
    return GridView//for the organising the categories in grid pattern
      (    
        padding: EdgeInsets.all(25),

        //very important for sizing and adjusting the grids.
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent
        (
          //max width of gridview for cross axis
          maxCrossAxisExtent: 200,

          //height/width ration of each grid.
          childAspectRatio: 3/2,

          //spacing b/w each grids.
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),

        //mapping each category from dummy data with correspondin custom widgets.
        children: DUMMY_CATEGORIES.map
        (
          (catdata) => CategoryItem(id: catdata.id,title:catdata.title,color:catdata.color)
        ).toList(),      
      );    
  }
}