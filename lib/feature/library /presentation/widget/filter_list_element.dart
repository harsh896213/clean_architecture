import 'package:flutter/material.dart';
import 'package:pva/core/extension/context_ext.dart';

class FilterListElement extends StatefulWidget {
   String selectedElement;
   List<String> element;

   FilterListElement(
      {super.key,
      required this.selectedElement,
      required this.element,
      });

  @override
  State<FilterListElement> createState() => _FilterListElementState();
}

class _FilterListElementState extends State<FilterListElement> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) => Material(
        type: MaterialType.transparency,
        child: GestureDetector(
          onTap: () {
            widget.selectedElement = widget.element[index];
          },
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: widget.selectedElement == widget.element[index]
                  ? context.theme.primaryColor // Highlight when selected
                  : Colors.white, // Default color
              borderRadius: BorderRadius.circular(12), // Rounded corners
              border: Border.all(color: Colors.grey.shade300), // Optional border
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.element[index],
                  style: context.textTheme.labelMedium?.copyWith(
                    color: widget.selectedElement == widget.element[index]
                        ? Colors.white // Text color when selected
                        : context.theme.secondaryHeaderColor,
                  ),
                ),
                Visibility(
                  visible: widget.selectedElement == widget.element[index],
                  child: Icon(Icons.check, size: 20, color: Colors.white,),
                )
              ],
            ),
          ),
        ),
      ),
      itemCount: widget.element.length,
    );
  }
}
