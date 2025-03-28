import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/theme/app_pallete.dart';
import 'package:pva/feature/library%20/presentation/bloc/library_bloc.dart';

class FilterListElement extends StatelessWidget {
   final FilterType type;
   final String selectedElement;
   final List<String> element;

   const FilterListElement(
      {super.key,
      required this.type,
      required this.selectedElement,
      required this.element,
      });

   @override
   Widget build(BuildContext context) {
     return ListView.builder(
       shrinkWrap: true,
       physics: const NeverScrollableScrollPhysics(),
       itemBuilder: (BuildContext context, int index) => Material(
         type: MaterialType.transparency,
         child: GestureDetector(
          onTap: () {
            type.toString() == FilterType.category.toString()
                ? context
                    .read<LibraryBloc>()
                    .add(SelectFilterTile(selectedCategory: element[index]))
                : context
                    .read<LibraryBloc>()
                    .add(SelectFilterTile(selectedContentType: element[index]));
          },
          child: Container(
             padding: EdgeInsets.all(12),
             margin: EdgeInsets.only(bottom: 12),
             decoration: BoxDecoration(
               color: selectedElement == element[index]
                   ? context.theme.primaryColor // Highlight when selected
                   : AppPallete.iconBg, // Default color
               borderRadius: BorderRadius.circular(8), // Rounded corners
             ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(
                   element[index],
                   style: context.textTheme.labelMedium?.copyWith(
                     color: selectedElement == element[index]
                         ? Colors.white // Text color when selected
                         : context.theme.secondaryHeaderColor,
                   ),
                 ),
                 Visibility(
                   visible: selectedElement == element[index],
                   child: Icon(Icons.check, size: 20, color: Colors.white,),
                 )
               ],
             ),
           ),
         ),
       ),
       itemCount: element.length,
     );
   }
}

enum FilterType{
  contentTypes,
  category
}

