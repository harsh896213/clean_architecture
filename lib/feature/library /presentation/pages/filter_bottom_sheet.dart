import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pva/core/common/widgets/button/button_factory.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/theme/text_styles.dart';
import 'package:pva/feature/library%20/presentation/bloc/library_bloc.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String selectedContentType = 'All Types';
  String selectedCategory = 'All';
  var category = ["All", "PDF", "DOCX"];
  var contentType = [
    'All Types',
    'Articles',
    'Videos',
  ];

  @override
  Widget build(BuildContext context) {
    context.read<LibraryBloc>();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Filters',
                  style: context.textTheme.titleLarge?.copyWith(fontSize: 20)),
              Spacer(),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedContentType = 'All Types';
                    selectedCategory = 'All';
                  });
                },
                child: const Text('Clear all'),
              ),
              ButtonFactory().createIconButton(
                  icon: Icons.cancel,
                  onPressed: () {
                    context.pop();
                  },
                  iconSize: 23)
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Content Type', style: context.textTheme.titleSmall),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(contentType[index], style: context.textTheme.labelMedium),
                    trailing: Radio<String>(
                      value: contentType[index],
                      groupValue: selectedContentType,
                      onChanged: (value) {
                        setState(() {
                          selectedContentType = value!;
                        });
                      },
                    ),
                  ),
                    itemCount: contentType.length,
                  ),
                  const SizedBox(height: 20),
                  Text('Category', style: context.textTheme.titleSmall),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(category[index], style: context.textTheme.labelMedium),
                        trailing: Radio<String>(
                          value: category[index],
                          groupValue: selectedCategory,
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value!;
                            });
                          },
                        ),
                      ),
                    itemCount: category.length,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, {
                          'contentType': selectedContentType,
                          'category': selectedCategory,
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:  Text(
                        'Apply Filters',
                        style: context.textTheme.titleSmall
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}