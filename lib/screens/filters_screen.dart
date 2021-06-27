import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

//The screen responsible for displaying all the filters.
class FiltersScreen extends StatefulWidget 
{
  static const routeName='/filters';

  //for saving the filter options set by user
  final Function saveFilters;

  //cuurent filter options
  Map<String,bool> currentFilters;

  FiltersScreen(this.currentFilters,this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen>
{
  bool _glutenFree= false;
  bool _vegan= false;
  bool _vegetarian= false;
  bool _lactoseFree= false;    
  
  @override
  void initState() //initialising with current filter data
  {
    _glutenFree=widget.currentFilters['glutenfree'];
    _lactoseFree=widget.currentFilters['lactosefree'];
    _vegan=widget.currentFilters['vegan'];
    _vegetarian=widget.currentFilters['vegetarian'];
    super.initState();
  }

  //builder for creating switch List tile for diff filters
  Widget _buildSwitchTile(String title,String subTitle,bool currVal,Function updateVal)
  {
    return SwitchListTile
    (
      title: Text(title),//'Gluten-free'
      subtitle: Text(subTitle),//'Only include Gluten-free meals.'
      value: currVal,//_glutenFree
      onChanged: updateVal,/*(newValue)
      {
        setState(() {
          _glutenFree=newValue;
        });
      } */
    );
  }  
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text('Filters'),
        actions: 
        [
          IconButton
          (
            icon:Icon(Icons.save),            
            onPressed: ()
            {
              //sending the selected filter options back to main.dart for updations
              final selectedFilters=
              {
                'glutenfree':_glutenFree,
                'lactosefree':_lactoseFree,
                'vegan':_vegan,
                'vegetarian':_vegetarian,
              }; 
              widget.saveFilters(selectedFilters);
            },
          ),          
        ],
      ),
      drawer: MainDrawer(),//for displaying the main drawer
      body: Column
      (
        children: 
        [
          Container
          (
            padding: EdgeInsets.all(20),
            child: Text
            (
              'Adjust your meal select.',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded
          (
            child: ListView
            (
              children: 
              [
                _buildSwitchTile
                (
                  'Gluten-free', 
                  'Only include Gluten-free meals.',
                  _glutenFree,
                  (newValue)
                  {
                    setState(() {
                      _glutenFree=newValue;
                    });
                  } 
                ),
                 _buildSwitchTile
                (
                  'Lactose-free', 
                  'Only include Lactose-free meals.',
                  _lactoseFree,
                  (newValue)
                  {
                    setState(() {
                      _lactoseFree=newValue;
                    });
                  } 
                ),
                 _buildSwitchTile
                (
                  'Vegetarian', 
                  'Only include Vegetarian meals.',
                  _vegetarian,
                  (newValue)
                  {
                    setState(() {
                      _vegetarian=newValue;
                    });
                  } 
                ),
                 _buildSwitchTile
                (
                  'vegan', 
                  'Only include Vegan meals.',
                  _vegan,
                  (newValue)
                  {
                    setState(() {
                      _vegan=newValue;
                    });
                  } 
                ),
              ],
            ),
          ),
        ],
      ),      
    );
  }
}