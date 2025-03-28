import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pva/core/widgets/vitual_ssistant.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Allows the center button to overflow
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 0, "Home"),
              _buildNavItem(Icons.calendar_month, 1, "Appointment"),
               SizedBox(width: 50), // Space for the Lottie button
              _buildNavItem(Icons.chat, 3, "Messages "),
              _buildNavItem(Icons.local_library_sharp, 4, "Library"),
            ],
          ),
        ),
        Positioned(
          top: -30, // Moves the Lottie button up
          left: MediaQuery.of(context).size.width / 2 - 25,
          child: GestureDetector(
            // onTap: () => onItemTapped(2),
            onTap: () => context.push("/assistant"),
            child: Hero(
              tag: "heroTag",
              child: SizedBox(
                  height: 60,
                  width: 60,
                  child: VirtualAssistant()),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, int index, String name) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Icon(icon,
              color: selectedIndex == index ? Colors.blue : Colors.grey,
              size: 30),
          onTap: () => onItemTapped(index),
        ),
        Text(
          name,
          style:
          TextStyle(
              color: selectedIndex == index ? Colors.blue : Colors.grey, fontSize: 12, fontWeight: FontWeight.w500,fontFamily: "PlusJakartaSans"),
        )
      ],
    );
  }
}
