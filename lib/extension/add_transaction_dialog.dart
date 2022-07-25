import 'package:budget_tracker/model/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTransactionDialog extends StatefulWidget {
  final Function(TransactionItem) itemToAdd;
  const AddTransactionDialog({required this.itemToAdd, Key? key})
      : super(key: key);

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final TextEditingController itemTitleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  bool _isExpenseController = true;

  @override
  void dispose() {
    itemTitleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        width: screenSize.width / 1.3,
        height: 300,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Text(
              "Add an expense",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: itemTitleController,
              decoration: const InputDecoration(hintText: "Name of expense"),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: const InputDecoration(hintText: "Amount in \$"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Is expense?"),
                Switch.adaptive(
                  value: _isExpenseController,
                  onChanged: (b) {
                    setState(() {
                      _isExpenseController = b;
                    });
                  },
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                if (amountController.text.isNotEmpty &&
                    itemTitleController.text.isNotEmpty) {
                  widget.itemToAdd(
                    TransactionItem(
                      itemTitle: itemTitleController.text,
                      amount: double.parse(amountController.text),
                      isExpense: _isExpenseController,
                    ),
                  );
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
