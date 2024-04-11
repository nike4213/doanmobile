import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String? selectedValue;
class DropDownBtn extends StatelessWidget {
  final List<String> items;
  final String selectedItemText;
  final Function(String?) onSelected;
  const DropDownBtn ({super.key, required this.items, required this.selectedItemText, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            'Danh mục',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          items: ['1', '2', '3']
              .map(
                (String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              )
              .toList(),
          value: '1',
          onChanged: (String? value) {},
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            width: 140,
          ),
          menuItemStyleData: const MenuItemStyleData(height: 40),
        ),
      ),
    );
  }
}
