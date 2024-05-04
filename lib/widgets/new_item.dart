import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final keyItem = GlobalKey<FormState>();
  var enteredName = '';
  var enteredQuentity = 1;
  var selectedCategory = categories[Categories.vegetables]!;
  var _isSending = false;

  void saveItem() async {
    if (keyItem.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });
      keyItem.currentState!.save();
      final url = Uri.https('flutter-prep-d01d6-default-rtdb.firebaseio.com',
          'shopping-list.json');
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'category': selectedCategory.title,
            'name': enteredName,
            'quantity': enteredQuentity
          }));

      final Map<String, dynamic> resData = json.decode(response.body);
      if (!context.mounted) {
        return;
      }
      //sor ya da tekrar bak.
      Navigator.of(context).pop(GroceryItem(
          id: resData['name'],
          category: selectedCategory,
          name: enteredName,
          quantity: enteredQuentity));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: keyItem,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("Name"),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length > 50 ||
                      value.trim().length <= 1) {
                    return 'Must be between 1 and 50 characters.!';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  enteredName = newValue!;
                },
              ),
              const SizedBox(width: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration:
                          const InputDecoration(label: Text("Quantity")),
                      initialValue: enteredQuentity.toString(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Must be a valid, positive number!';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        enteredQuentity = int.parse(newValue!);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField(
                        value: selectedCategory,
                        items: [
                          for (final category in categories.entries)
                            DropdownMenuItem(
                                value: category.value,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      color: category.value.color,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(category.value.title)
                                  ],
                                )),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value!;
                          });
                        }),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: _isSending ? null 
                    :() {
                        keyItem.currentState!.reset();
                      },
                      child: const Text("Reset")),
                  ElevatedButton(
                      onPressed: _isSending? null : saveItem, child: _isSending ? const SizedBox(height: 16,width: 16,child: CircularProgressIndicator()): const Text("Add Item"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
