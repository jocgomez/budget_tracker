import 'package:budget_tracker/model/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TransactionItem> items = [
    TransactionItem(
      amount: 5.99,
      itemTitle: 'Apple Watch',
      isExpense: false,
    ),
    TransactionItem(
      amount: 5.99,
      itemTitle: 'Apple Watch',
    ),
    TransactionItem(
      amount: 5.99,
      itemTitle: 'Apple Watch',
      isExpense: false,
    ),
    TransactionItem(
      amount: 5.99,
      itemTitle: 'Apple Watch',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            items.add(TransactionItem(amount: 5.99, itemTitle: "Food"));
          });
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: CircularPercentIndicator(
                radius: screenSize.width / 2,
                lineWidth: 10,
                percent: 0.5,
                progressColor: Theme.of(context).colorScheme.primary,
                center: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '\$0',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text('Balance'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            const Text(
              "Items",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            ...List.generate(
              items.length,
              (index) => TransactionCard(
                transactionItem: items[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final TransactionItem transactionItem;
  const TransactionCard({
    required this.transactionItem,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              offset: const Offset(0, 25),
              blurRadius: 50,
            )
          ],
        ),
        padding: const EdgeInsets.all(15.0),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              transactionItem.itemTitle,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              (!transactionItem.isExpense ? "+ " : "- ") +
                  transactionItem.amount.toString(),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
