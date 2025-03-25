import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pva/core/extension/context_ext.dart';
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
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: ShapeDecoration(
          color: isSelected ? Colors.blueAccent : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          time,
          style: isSelected
              ? context.textTheme.labelMedium?.copyWith(color: Colors.white)
              : context.textTheme.labelMedium
                  ?.copyWith(color: context.theme.secondaryHeaderColor),
        ),
      ),
    );
  }
}
