import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SetBudgetDialog extends StatefulWidget {
  final Function(double) budgetToAdd;
  const SetBudgetDialog({
    required this.budgetToAdd,
    Key? key,
  }) : super(key: key);

  @override
  State<SetBudgetDialog> createState() => _SetBudgetDialogState();
}

class _SetBudgetDialogState extends State<SetBudgetDialog> {
  final TextEditingController budgetController = TextEditingController();

  @override
  void dispose() {
    budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        width: screenSize.width / 1.3,
        height: 200,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Text(
              "What is your budget?",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: budgetController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: const InputDecoration(hintText: "Budget in \$"),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                if (budgetController.text.isNotEmpty) {
                  widget.budgetToAdd(double.parse(budgetController.text));
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Add"),
            )
          ],
        ),
      ),
    );
  }
}
