import 'package:flutter/material.dart';

import 'package:shopping_list/models/category.dart';

const categories = {
  Categories.vegetables: MyCategory(
    'Vegetables',
    Color.fromARGB(255, 0, 255, 128),
  ),
  Categories.fruit: MyCategory(
    'Fruit',
    Color.fromARGB(255, 145, 255, 0),
  ),
  Categories.meat: MyCategory(
    'Meat',
    Color.fromARGB(255, 255, 102, 0),
  ),
  Categories.dairy: MyCategory(
    'Dairy',
    Color.fromARGB(255, 0, 208, 255),
  ),
  Categories.carbs: MyCategory(
    'Carbs',
    Color.fromARGB(255, 0, 60, 255),
  ),
  Categories.sweets: MyCategory(
    'Sweets',
    Color.fromARGB(255, 255, 149, 0),
  ),
  Categories.spices: MyCategory(
    'Spices',
    Color.fromARGB(255, 255, 187, 0),
  ),
  Categories.convenience: MyCategory(
    'Convenience',
    Color.fromARGB(255, 191, 0, 255),
  ),
  Categories.hygiene: MyCategory(
    'Hygiene',
    Color.fromARGB(255, 149, 0, 255),
  ),
  Categories.other: MyCategory(
    'Other',
    Color.fromARGB(255, 0, 225, 255),
  ),
};
