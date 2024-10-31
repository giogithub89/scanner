import 'package:flutter/material.dart';

import 'buttons/SaveButton.dart';
import 'model/ingredientsListModel.dart';

class Calculator extends StatefulWidget {
  final List<IngredientList>? recipeList;
  const Calculator({super.key, this.recipeList});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  List<IngredientList> ingList = [];


  @override
  void initState() {
    super.initState();
    ingList = (widget.recipeList ?? []);
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('calculator',
              style: TextStyle(fontSize:  20)),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.add,
              ),
              onPressed: (){},
            ),
            IconButton(
              icon: const Icon(
                Icons.add_a_photo,
              ),
              onPressed: (){},
            ),
          ],
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  icon: Icon( Icons.delete_forever,
                    color: ingList.isEmpty ? Colors.white : Colors.black87,
                  ),
                  onPressed: (){
                    if(ingList.isEmpty){
                      return;
                    }else{

                    }
                  }
              );
            }, //
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.70,
                child: ingList.isEmpty ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('add ingredients',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey),
                    ),
                  ),
                )
                    : ListView.builder(
                  itemBuilder: (context, index) {
                    return rowItems(context, index);
                  },
                  itemCount: ingList.length,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SaveButton(
                text: 'calculate'.toUpperCase(),
                onPressed: () {
                  if(ingList.isEmpty){
                    //emptyListDialog(context);
                    return;
                  }else{
                    //_showModalBottomSheet(context);
                  }
                },
                /* style: ingList.isEmpty ? ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange.shade100)
                      : ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),*/

              ),
            ),
          ],
        )
        );
  }
  Widget rowItems(context, index) {
    return Dismissible(
      key: Key(ingList[index].name),
      onDismissed: (direction) {
        var ingredient = ingList[index];

      },
      background: deleteBgItem(),
      child: Card(
        margin: const EdgeInsets.all(5),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 5.0),
                child: Text(
                  ingList[index].name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                ingList[index].quantity,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  deleteBgItem(){

  }
}
