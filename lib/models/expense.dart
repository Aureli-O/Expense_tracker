import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, shopping, leisure, work, others }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.shopping: Icons.shopping_bag,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.others: Icons.more_rounded,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expeses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expeses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expeses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expeses) {
      sum += expense.amount;
    }
    return sum;
  }
}
