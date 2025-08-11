import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  final Function(String) onCategorySelected;

  const CategoryList({super.key, required this.onCategorySelected});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String selectedCategory = 'Sandwiches';

  final List<Map<String, dynamic>> categories = [
    {
      'label': 'Sandwiches',
      'image': 'https://cdn-icons-png.flaticon.com/512/1046/1046784.png',
    },
    {
      'label': 'Limited Time Offers',
      'image': 'https://cdn-icons-png.flaticon.com/512/1046/1046786.png',
    },
    {
      'label': 'Star Box',
      'image': 'https://cdn-icons-png.flaticon.com/512/1828/1828884.png',
    },
    {
      'label': 'Drinks',
      'image': 'https://cdn-icons-png.flaticon.com/512/924/924514.png',
    },
    {
      'label': 'Desserts',
      'image': 'https://cdn-icons-png.flaticon.com/512/2515/2515274.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category['label'];

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category['label'];
              });
              widget.onCategorySelected(selectedCategory);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFBBF24) : Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: isSelected
                    ? null
                    : Border.all(color: const Color(0xFFFBBF24), width: 1.2),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      category['image'],
                      width: 28,
                      height: 28,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.image),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    category['label'],
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
