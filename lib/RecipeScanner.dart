import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'buttons/SaveButton.dart';
import 'dialog/errorDialog.dart';
import 'model/ingredientsListModel.dart';

class RecipeScanner extends StatefulWidget {
  final String? path;
  const RecipeScanner({super.key, this.path});

  @override
  State<RecipeScanner> createState() => _RecipeScannerState();
}

class _RecipeScannerState extends State<RecipeScanner> with WidgetsBindingObserver {

  bool _isBusy = false;
  TextEditingController controller = TextEditingController();
  List<IngredientList> ingList = [];
  String? number = '';


  @override
  void initState() {
    super.initState();
    final InputImage inputImage = InputImage.fromFilePath(widget.path!);
    processImage(inputImage);
  }

  void processImage(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    setState(() {
      _isBusy = true;
    });

    debugPrint('image.filePath: ${image.filePath!}');

    try {
      final RecognizedText recognizedText = await textRecognizer.processImage(image)
          .timeout(const Duration(seconds: 10)); // Timeout set to 5 seconds
      // Process the recognized text
      List<String> recipeLines = [];
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          // Process each line to filter out non-alphanumeric characters
          String processedLine = line.text.replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');
          //scannedText = scannedText + line.text + "\n";
          // Add the processed line to the array if it's not empty
          if (processedLine.isNotEmpty) {
            recipeLines.add(processedLine);
          }
        }
      }
      for(var i = 0; i < recipeLines.length; i++) {
        /*RegExpMatch? match = RegExp(r'(\d+)\s+(.+)').firstMatch(recipeLines[i]);
        //RegExpMatch? match = RegExp(r'[a-zA-Z\s]+').firstMatch(recipeLines[i]); //only letters
        //Matching Floating-point Numbers
        RegExpMatch? numberMatch = RegExp(r'\d+(\.\d+)?').firstMatch(recipeLines[i]);
        String? number = numberMatch?.group(0);
        String? text = match?.group(0);
        //print(number);
        print('text $text');
        if(text != null && number != null) {
          ingList.add(IngredientList(text, number));
        }*/

        // Define multiple regular expressions
        RegExp pattern1 = RegExp(
            r'(.+?)\s+(\d+(\.\d+)?)'); // Matches text followed by a number
        RegExp pattern2 = RegExp(
            r'(\d+(\.\d+)?)\s+(.+)'); // Matches a number followed by text
        RegExp pattern3 = RegExp(
            r'(.+)\s+(\d+(\.\d+)?)'); // Matches text followed by a number (alternative pattern)

        // Try matching each pattern
        RegExpMatch? match = pattern1.firstMatch(recipeLines[i]);
        String? text;
        String? number;

        if (match != null) {
          // Pattern 1 matched
          text = match.group(1);
          number = match.group(2);
        } else {
          match = pattern2.firstMatch(recipeLines[i]);
          if (match != null) {
            // Pattern 2 matched
            number = match.group(1);
            text = match.group(3);
          } else {
            match = pattern3.firstMatch(recipeLines[i]);
            if (match != null) {
              // Pattern 3 matched
              text = match.group(1);
              number = match.group(2);
            }
          }
        }
        if (text != null && number != null) {
          ingList.add(IngredientList(text.trim(), number.trim()));
        } else {
          // Optionally handle the case where no match is found
          print('No match found in line: $recipeLines');
        }

      }
      print(ingList);
      //End busy state
      setState(() {
        controller.text = recipeLines.join("\n");
        _isBusy = false;
      });

    } catch (e) {
      if (e is TimeoutException) {
        // Handle timeout error
        ErrorDialog.modal(context, onPressed: () {
          Navigator.pop(context);
        },
            content: 'timeout_msg', title: 'error', buttonText: 'ok');
        if (kDebugMode) {
          print('Text recognition process took longer than 5 seconds.');
        }
        // Set a timer or perform any other action here
      } else {
        if (kDebugMode) {
          print('Error: $e');
        }
      }
    }

    //controller.text = recognizedText.text;
    //controller.text = scannedText;

    // Extract the number and text from the first line
    /*String firstLine = recipeLines.isNotEmpty ? recipeLines[1] : "";
    RegExpMatch? match = RegExp(r'(\d+)\s+(.+)').firstMatch(firstLine);

    // Print the number and text
    number = match?.group(1);
    String? text = match?.group(2);
    ingList.add(IngredientList(text!, number!));

    print('Number: $number');
    print('Text: $text');*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner'),
      ),
        body: _isBusy
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
          },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                  child: Column(
                      children: [
                        const Text('edit recipe if'),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.7,
                          child: TextFormField(
                            maxLines: MediaQuery.of(context).size.height.toInt(),
                            controller: controller,
                            decoration:
                                const InputDecoration(hintText: "Text goes here..."),
                          ),
                        ),
                        SaveButton(
                            onPressed: () {
                              /*Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                              MainPage(currentIndex: 1, recipeList: ingList)));*/
                            }, text: 'add to calculator'),
                      ],
                    ),
                ),
              ),
            )
    );
  }
}
