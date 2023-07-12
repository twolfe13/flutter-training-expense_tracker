import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // method #2
  // takes inputValue as a String, whenever someone changes input value
  // var _enteredTitle = '';

  // void _saveTitleInput(String inputValue) {
  //_enteredTitle = inputValue;

  // methoid using TextEditingController()
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate; // ? because initially it won't store anything / null
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now(); // used for initial date
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    // flutter knows to wait because of async AND await before storing data in pickedDate. Note firstDate doesn't need, that we are already initially setting for the user
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // validation of form
  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController
        .text); // tryParse('hello') => null, tryParse('1.12' => 1.12)
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    // validate: title text is empty (below), amount is empty or equal to or less than 0 (above), if amount is a number (above), if date is empty (below)
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate ==
            null) // .trim() simply removes access white space of strings.  .isEmpty can be used on lists
    {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Plese make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );

      return; // because if we have invalid date we don't want to return anything
    }

    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );

    Navigator.pop(context); // closes pop out keyboard
  }

  @override
  void dispose() {
    // dispose() always needed when using TextEditingControll()
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16,
          16), // added padding so view on full screen isn't too high on device
      // set column first before rows, as layout has multiple rows
      child: Column(
        children: [
          TextField(
            // method #2
            // onChanged: _saveTitleInput,
            controller: _titleController,
            maxLength: 50,
            // keyboardType: not needed but is there by default in TextField()
            decoration: const InputDecoration(
              label: Text('Title'),
            ), // label text
          ),
          // outside row
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  // keyboardType: not needed but is there by default in TextField()
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ), // label text
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                // inside row (row inside of a row)
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.end, // horizontal alignment
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // vertical alignment
                  children: [
                    Text(_selectedDate == null
                        ? 'No Date selected'
                        : formatter.format(
                            _selectedDate!)), // ! forces dart to understand it won't ever be null, in this case we know b/c we checked it in prevoius code
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value:
                              category, // enum value chosen.  Stored internally for every drop-down item (not visible to the user.. child is what's visible)
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value == null) {
                        return; // on a return no more code can be executed after.. which happens if it's null
                      }
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(
                      context); // Navigator.pop() wants current context as argument
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  _submitExpenseData();
                  print(_titleController.text);
                  print(_amountController.text);
                },
                child: const Text('Save Expense'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
