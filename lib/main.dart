import 'package:crea_radio_button/crea_radio_button.dart';
import 'package:flutter/material.dart';

class AmountOption {
  String currencySign;
  String currencyName;
  double amount;

  AmountOption(this.currencySign, this.currencyName, this.amount);
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          children: const [FrequencyContainer(), AmountContainer()],
        ),
      ),
    ),
  ));
}

class FrequencyContainer extends StatefulWidget {
  const FrequencyContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<FrequencyContainer> createState() => _FrequencyContainerState();
}

class _FrequencyContainerState extends State<FrequencyContainer> {
  String label = "";

  List<RadioOption> options = [
    RadioOption("MONTHLY", "Monthly"),
    RadioOption("YEARLY", "Yearly")
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 400,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade200),
          color: Colors.grey.shade50),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Text(
              "How do you want to pay?",
              style: TextStyle(fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            RadioButtonGroup(
                options: options,
                textStyle: const TextStyle(fontSize: 15, color: Colors.white),
                mainAxisAlignment: MainAxisAlignment.center,
                selectedColor: Colors.grey.shade400,
                mainColor: Colors.grey.shade400,
                selectedBorderSide:
                    BorderSide(width: 2, color: Colors.pink.shade300),
                buttonWidth: 120,
                buttonHeight: 35,
                callback: (RadioOption val) {
                  setState(() {
                    label = val.label;
                  });
                  print(val);
                }),
          ],
        ),
      ),
    );
  }
}

class AmountContainer extends StatefulWidget {
  const AmountContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<AmountContainer> createState() => _AmountContainerState();
}

class _AmountContainerState extends State<AmountContainer> {
  final int defaultOptionIndex = 0;
  late AmountOption selectedOption;
  List<RadioOption> options = [
    RadioOption(AmountOption("\$", "EURO", 10.00), "10"),
    RadioOption(AmountOption("\$", "EURO", 25.00), "25"),
    RadioOption(AmountOption("\$", "EURO", 50.00), "50"),
    RadioOption(AmountOption("\$", "EURO", 100.00), "100"),
  ];

  @override
  void initState() {
    super.initState();
    selectedOption = options[defaultOptionIndex].value;
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
                '\$ ${selectedOption.amount}',
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
                preSelectedIdx: defaultOptionIndex,
                options: options,
                callback: (RadioOption val) {
                  setState(() {
                    selectedOption = val.value;
                  });
                })
          ],
        ),
      ),
    );
  }
}
