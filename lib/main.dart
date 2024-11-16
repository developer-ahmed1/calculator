import 'package:flutter/material.dart';

void main() {
  runApp(calculator());
}

class calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(primarySwatch: Colors.blue),
      home: ArithmeticScreen(),
    );
  }
}

class ArithmeticScreen extends StatefulWidget {
  @override
  ArithmeticScreenState createState() => ArithmeticScreenState();
}

class ArithmeticScreenState extends State<ArithmeticScreen> {
  // Controllers for TextFields
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();

  // Variable to store the result
  String output = '';

  // Method to perform arithmetic operations
  void performOperation(String operation) {
    try {

      double num1 = double.parse(num1Controller.text);
      double num2 = double.parse(num2Controller.text);
      double calculation;


      switch (operation) {
        case '+':
          calculation = num1 + num2;
          break;
        case '-':
          calculation = num1 - num2;
          break;
        case '*':
          calculation = num1 * num2;
          break;
        case '/':
          if (num2 == 0) {
            throw Exception('Division by zero is not allowed');
          }
          calculation = num1 / num2;
          break;
        default:
          throw Exception('Unknown operation');
      }

      // Update the result
      setState(() {
        output = 'Result: $calculation';
      });
    } catch (e) {
      // Handle errors
      showAlertDialog('Error', e.toString());
    }
  }

  // Method to clear inputs and result
  void clearFields() {
    setState(() {
      num1Controller.clear();
      num2Controller.clear();
      output = '';
    });
  }

  // Method to show an alert dialog
  void showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Ahmed calculator'),
        centerTitle: true,//set the title in center
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextField for first number
            TextField(
              controller: num1Controller,
              decoration: InputDecoration(
                labelText: 'Enter first number',

              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),

            // TextField for second number
            TextField(
              controller: num2Controller,
              decoration: InputDecoration(
                labelText: 'Enter second number',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),

            // Row of buttons for arithmetic operations
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => performOperation('+'),
                  label: Text('+'),
                ),
                ElevatedButton.icon(
                  onPressed: () => performOperation('-'),

                  label: Text('-'),
                ),
                ElevatedButton.icon(
                  onPressed: () => performOperation('*'),

                  label: Text('*'),
                ),
                ElevatedButton.icon(
                  onPressed: () => performOperation('/'),

                  label: Text('/'),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // Button to clear inputs
            ElevatedButton(
              onPressed: clearFields,
              child: Text('Clear'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
            SizedBox(height: 16.0),

            // Text widget to display the result
            Text(
              output,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

