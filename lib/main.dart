import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';
import 'package:workspace/styled_button.dart'; // External package for expression evaluationer

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Calculator - Hudson Byers'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class customElevatedButton extends ElevatedButton {
  customElevatedButton({required super.onPressed, required super.child});

}

class _MyHomePageState extends State<MyHomePage> {
  String displayEquation = "";
  bool isResultDisplayed = false;

  void onButtonPressed(String char) {
    if (isResultDisplayed) return; // Block input after result

    bool isOperator(String c) => "+-*/".contains(c);

    // Prevent multiple operators in a row
    if (isOperator(char)) {
      if (displayEquation.isEmpty || isOperator(displayEquation.characters.last)) return;
    }

    if (char == "=") {
      // Use expressions package to evaluate
      String formattedResult;
      try {
        // Remove any trailing operator before evaluating
        String expr = displayEquation;
        if (expr.isNotEmpty && isOperator(expr.characters.last)) {
          expr = expr.substring(0, expr.length - 1);
        }
        Expression exp = Expression.parse(expr);
        final evaluator = const ExpressionEvaluator();
        var context = <String, dynamic>{};
        var result = evaluator.eval(exp, context);
        if (result is double) {
          if (result.isInfinite || result.isNaN) {
            formattedResult = "Error";
          } else {
            formattedResult = double.parse(result.toStringAsFixed(6)).toString();
          }
        } else {
          formattedResult = result.toString();
        }
      } catch (e) {
        formattedResult = "Error";
      }
      setState(() {
        displayEquation = "$displayEquation = $formattedResult";
        isResultDisplayed = true;
      });
      return;
    }

    setState(() {
      displayEquation += char;
    });
  }

  // Helper to recursively solve and return result as string list
  // No longer needed with expressions package

  void clear() {
    setState(() {
      displayEquation = "";
      isResultDisplayed = false;
    });
  }
  
  // Removed old enter and parse methods (no longer needed)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 350,
          decoration: BoxDecoration(
            color: Colors.purple[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.purple.shade100),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(
                    minHeight: 60,
                    maxHeight: 120,
                    minWidth: 200,
                    maxWidth: 260,
                  ),
                  child: Card(
                    color: Colors.deepPurple[50],
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: EdgeInsets.all(16),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          displayEquation,
                          style: TextStyle(fontSize: 20, color: Colors.deepPurple),
                          softWrap: false,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StyledButton(child: const Text("7"), onPressed: () => onButtonPressed("7")),
                    StyledButton(child: const Text("8"), onPressed: () => onButtonPressed("8")),
                    StyledButton(child: const Text("9"), onPressed: () => onButtonPressed("9")),
                    StyledButton(child: const Text("/"), onPressed: () => onButtonPressed("/")),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StyledButton(child: const Text("4"), onPressed: () => onButtonPressed("4")),
                    StyledButton(child: const Text("5"), onPressed: () => onButtonPressed("5")),
                    StyledButton(child: const Text("6"), onPressed: () => onButtonPressed("6")),
                    StyledButton(child: const Text("*"), onPressed: () => onButtonPressed("*")),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StyledButton(child: const Text("1"), onPressed: () => onButtonPressed("1")),
                    StyledButton(child: const Text("2"), onPressed: () => onButtonPressed("2")),
                    StyledButton(child: const Text("3"), onPressed: () => onButtonPressed("3")),
                    StyledButton(child: const Text("-"), onPressed: () => onButtonPressed("-")),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StyledButton(child: const Text("0"), onPressed: () => onButtonPressed("0")),
                    StyledButton(child: const Text("="), onPressed: () => onButtonPressed("=")),
                    StyledButton(child: const Text("C"), onPressed: clear),
                    StyledButton(child: const Text("+"), onPressed: () => onButtonPressed("+")),
                  ]
                ),
              ],
            ),
          )
        )
      ),
    );
  }
}
