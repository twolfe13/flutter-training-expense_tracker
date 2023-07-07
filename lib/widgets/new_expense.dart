import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

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
      padding: const EdgeInsets.all(16),
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
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            // keyboardType: not needed but is there by default in TextField()
            decoration: const InputDecoration(
              prefixText: '\$ ',
              label: Text('Amount'),
            ), // label text
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  print(_titleController.text);
                  print(_amountController.text);
                },
                child: const Text('Save Expense'),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () {},
                child: const Text('Cancel'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
