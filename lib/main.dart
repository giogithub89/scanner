import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scanner/buttons/SaveButton.dart';
import 'package:scanner/utils/image_cropper_class.dart';
import 'package:scanner/utils/image_picker_class.dart';
import 'RecipeScanner.dart';
import 'dialog/scannerDialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {




  @override
  Widget build(BuildContext context) {

    void showScannerDialog() {
      showDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            content:  ScannerDialog(
                onPressed: (index)  {
                  if(index == 1) {
                    pickImage(source: ImageSource.camera).then((value){
                      if (value != ''){
                        imageCropperView(value, context).then((value) {
                          if (value != '') {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    RecipeScanner(path: value)));
                          }
                        });
                      }
                    });
                    Navigator.pop(context);
                  }
                  if(index == 2){
                    pickImage(source: ImageSource.gallery).then((value){
                      if (value != ''){
                        imageCropperView(value, context).then((value) {
                          if (value != '') {

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    RecipeScanner(path: value)));
                          }
                        });
                      }
                    });
                    Navigator.pop(context);
                  }
                }
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text(
                'Add new ingredients',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(

        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: SaveButton(onPressed: () {
          showScannerDialog();
        }, text: 'scan recipe',

        )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
