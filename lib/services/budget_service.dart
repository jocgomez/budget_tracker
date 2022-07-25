import 'package:budget_tracker/model/transaction_item.dart';
import 'package:flutter/material.dart';

class BudgetService extends ChangeNotifier {
  double _budget = 0;

  double get budget => _budget;
  set budget(double value) {
    _budget = value;
    notifyListeners();
  }

  double balance = 0.0;
  final List<TransactionItem> _items = [];

  List<TransactionItem> get items => _items;

  void addItem(TransactionItem item) {
    _items.add(item);
    updateBalance(item);
    notifyListeners();
  }

  void updateBalance(TransactionItem item) {
    if (item.isExpense) {
      balance += item.amount;
    } else {
      balance -= item.amount;
    }
  }
}
