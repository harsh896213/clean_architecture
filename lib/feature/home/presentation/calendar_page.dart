import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                'All',
                'Morning',
                'Afternoon',
                'Evening',
                'Night',
              ]
                  .map((time) => ChoiceChip(
                showCheckmark: false,
                label: Text(time),
                selected: "Morning" == time,
                onSelected: (bool selected) {
                  // setState(() {
                  //   _value = selected ? index : null;
                  // });
                },
              ))
                  .toList(),
            ),
          ),
        ),
        // Rest of your content
      ],
    );
  }
}
