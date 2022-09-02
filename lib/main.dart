import 'package:crea_radio_button/crea_radio_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: AmountContainer(options: [
          RadioOption("10.0", "10"),
          RadioOption("25.0", "25"),
          RadioOption("50.0", "50"),
          RadioOption("100.0", "100")
        ]),
      ),
    ),
  ));
}

class AmountContainer extends StatefulWidget {
  final List<RadioOption> options;

  const AmountContainer({Key? key, required this.options}) : super(key: key);

  @override
  State<AmountContainer> createState() => _AmountContainerState();
}

class _AmountContainerState extends State<AmountContainer> {
  final int defaultOptionIndex = 3;
  late RadioOption selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.options[defaultOptionIndex]; // set default option
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 400,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade200),
          color: Colors.grey.shade200),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Text("Select your amount"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                selectedOption.label,
                style:
                TextStyle(fontSize: 20, color: Colors.pinkAccent.shade200),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            RadioButtonGroup(
                buttonHeight: 35,
                buttonWidth: 60,
                circular: true,
                mainColor: Colors.grey,
                selectedColor: Colors.pink.shade400,
                defaultIdx: defaultOptionIndex,
                options: [
                  RadioOption("10.0", "10"),
                  RadioOption("25.0", "25"),
                  RadioOption("50.0", "50"),
                  RadioOption("100.0", "100")
                ],
                callback: (RadioOption val) {
                  setState(() {
                    selectedOption = val;
                  });
                })
          ],
        ),
      ),
    );
  }
}
