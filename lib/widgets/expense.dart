import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// provided by intl for formatting dates.  DateFormat.() has methods for various date options
final formatter = DateFormat.yMd();

// unique id
const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid
            .v4(); // generates a unique id and assigns ID as initial property when initialized
  final String id;
  final String title;
  // double is a number with decimal places E.g. 1.99
  final double amount;
  final DateTime date;
  final Category category; // uses enum above

  String get formattedDate {
    return formatter.format(date);
  }
}

///// this is for the chart ////////

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  // adding / defining your own alternative constructor function. Idea here being able to add logic to expect a list of all expenses from all categories,
  //then filter out the ones belonging to each category - using .where() dart method, that's available on all lists to filter them
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  // "getter" that sums up all the expenses. This will be used for the chart
  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum = sum + expense.amount; // sum = sum + expense.amount
    }

    return sum;
  }
}
