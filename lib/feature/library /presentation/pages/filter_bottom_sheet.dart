import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pva/core/common/widgets/button/button_factory.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/theme/app_pallete.dart';
import 'package:pva/core/theme/text_styles.dart';
import 'package:pva/feature/library%20/presentation/bloc/library_bloc.dart';
import 'package:pva/feature/library%20/presentation/widget/filter_list_element.dart';


class FilterBottomSheet extends StatelessWidget {
  String selectedContentType = 'All Types';
  String selectedCategory = 'All';
  var category = ["All", "PDF", "DOCX"];
  var contentType = [
    'All Types',
    'Article',
    'Video',
  ];

  @override
  Widget build(BuildContext context) {
    context.read<LibraryBloc>();
    return Container(
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
                  selectedContentType = 'All Types';
                  selectedCategory = 'All';
                },
                child: const Text('Clear all'),
              ),
              ButtonFactory().createIconButton(
                  icon: Icons.cancel,
                  onPressed: () {
                    context.pop();
                  },
                  color: Colors.black12,
                  iconSize: 35)
            ],
          ),
          Divider(),
          const SizedBox(height: 20),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Content Type', style: context.textTheme.titleSmall),
                  const SizedBox(height: 12),
                  BlocSelector<LibraryBloc, LibraryState, String>(
                    selector: (state) {
                      if (state is LibraryDataState) {
                        return state.selectedContentType;
                      }
                      return "All Types";
                    },
                    builder: (context, state) {
                      return FilterListElement(
                        type: FilterType.contentTypes,
                        selectedElement: state ?? "All Types",
                        element: contentType,);
                    },
                  ),
                  const SizedBox(height: 20),
                  Text('Category', style: context.textTheme.titleSmall),
                  const SizedBox(height: 12),
                  BlocSelector<LibraryBloc, LibraryState, String>(
                    selector: (state) {
                      if (state is LibraryDataState) {
                        return state.selectedCategory;
                      }
                      return "All";
                    },
                    builder: (context, state) {
                      return FilterListElement(
                        type: FilterType.category,
                        selectedElement: state,
                        element: category,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<LibraryBloc>().add(FilterLibrary());
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPallete.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Apply Filters',
                  style: context.textTheme.titleSmall
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}