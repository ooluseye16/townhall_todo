import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:townhall_todo/screens/home/widgets/categories/category_card.dart';
import 'package:townhall_todo/utils/constants.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({
    super.key,
  });

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  List<List<Color>> colorsList = [
    [
      const Color(0xFF88D2F5),
      const Color(0xFF0FA9F4),
    ],
    [
      const Color(0xFF7ED9D2),
      const Color(0xFF10CFB1),
    ],
    [
      const Color(0xFFFEBCA7),
      const Color(0xFFFD7E7E),
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 16.w),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Row(
            children: List.generate(
                categories.length,
                (index) => Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: CategoryCard(
                        colors: colorsList[index],
                        title: categories[index],
                      ),
                    )),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: ShapeDecoration(
              color: const Color(0xFFEDEDED),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Row(
              children: [
                const Icon(Icons.add),
                const SizedBox(width: 8),
                Text(
                  'Add\nCategories',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
