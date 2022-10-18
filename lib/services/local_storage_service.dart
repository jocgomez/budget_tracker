import 'package:budget_tracker/model/transaction_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const String budgetBoxKey = 'budgetBoxKey';
  static const String transactionsBoxKey = 'transactionsBox';
  static const String balanceBoxKey = 'balanceBox';

  static const String balanceKey = 'balance';
  static const String budgetKey = 'balance';

  /// Patron de diseño [Singleton]
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  /// Se inicia y abren los boxes del servicio Hive
  Future<void> initializeHive() async {
    await Hive.initFlutter();

    /// Se registra el adapter 1 unica vez para evitar errores
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TransactionItemAdapter());
    }

    await Hive.openBox<double>(budgetBoxKey);
    await Hive.openBox<TransactionItem>(transactionsBoxKey);
    await Hive.openBox<double>(balanceBoxKey);
  }

  /// --- Save and Get --- --- Transaction items ---
  void saveTransactionItems(TransactionItem transaction) {
    Hive.box<TransactionItem>(transactionsBoxKey).add(transaction);
    saveBalance(transaction);
  }

  List<TransactionItem> getAllTransactions() {
    return Hive.box<TransactionItem>(transactionsBoxKey).values.toList();
  }

  /// --- Save and Get --- --- Balance ---
  Future<void> saveBalance(TransactionItem transaction) async {
    final balanceBox = Hive.box<double>(balanceBoxKey);
    final currentBalance = balanceBox.get(balanceKey) ?? 0.0;

    if (transaction.isExpense) {
      balanceBox.put(balanceKey, currentBalance + transaction.amount);
    } else {
      balanceBox.put(balanceKey, currentBalance - transaction.amount);
    }
  }

  double getBalance() {
    return Hive.box<double>(balanceBoxKey).get(balanceKey) ?? 0.0;
  }

  /// --- Save and Get --- --- Budget ---
  Future<void> saveBudget(double budget) async {
    Hive.box<double>(budgetBoxKey).put(budgetKey, budget);
  }

  double getBudget() {
    return Hive.box<double>(budgetBoxKey).get(budgetKey) ?? 2000.0;
  }
}
