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
