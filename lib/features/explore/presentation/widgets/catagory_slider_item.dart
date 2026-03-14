import 'package:flutter/material.dart';
import 'package:movies_app/features/explore/presentation/widgets/catagory_item.dart';

class CatagorySliderItem extends StatefulWidget {
  const CatagorySliderItem({super.key, required this.onCategorySelected});
   final Function(String) onCategorySelected; // callback
  @override
  State<CatagorySliderItem> createState() => _CatagorySliderItemState();
}

class _CatagorySliderItemState extends State<CatagorySliderItem> {
  int selectedIndex = 0;
  final List<Map<String, dynamic>> categories = [
    {'id': 0, 'name': 'Action'},
    {'id': 1, 'name': 'Crime'},
    {'id': 4, 'name': 'Animation'},
    {'id': 2, 'name': 'Comedy'},
    {'id': 3, 'name': 'Drama'},
    {'id': 5, 'name': 'Horror'},
    {'id': 6, 'name': 'Romance'},
    {'id': 7, 'name': 'Documentary'},
    {'id': 8, 'name': 'Fantasy'},
    {'id': 9, 'name': 'Mystery'},
    {'id': 10, 'name': 'Sport'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CatagoryItem(
              text: categories[index]['name'],
              isSelected: index == selectedIndex,
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onCategorySelected(categories[index]['name']);
              },
            ),
          );
        },
      ),
    );
  }
}
