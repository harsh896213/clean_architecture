import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pva/feature/home/presentation/bloc/home_bloc.dart';

class TimeChip extends StatelessWidget {
  final String time;
  final bool isSelected;
  const TimeChip({required this.time, required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<HomeBloc>().add(FilterTimeActivities(time: time));
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: ShapeDecoration(
          color: isSelected ? Colors.blueAccent : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(time, style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.w500, fontSize: 16),),
      ),
    );
  }
}
