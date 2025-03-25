import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/theme/app_pallete.dart';
import 'package:pva/core/theme/shadow.dart';
import 'package:pva/core/widgets/animated_progressbar.dart';
import 'package:pva/core/widgets/divider.dart';
import 'package:pva/feature/home/presentation/bloc/home_bloc.dart';

class ProgressCard extends StatelessWidget {
  final double progress;

  const ProgressCard({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(20),
      decoration: ShapeDecoration(
          color: Colors.white,
          shadows: cardShadow,
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24)
      )),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Care Plan Progress',textAlign: TextAlign.center, style: context.textTheme.titleSmall,),
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: AnimatedProgressIndicator(
                      progress: progress,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: 1,
              color: AppPallete.dividerColor,
            ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Text(
                  textAlign: TextAlign.center,
                'Tip of the Day', style: context.textTheme.titleSmall,),
                  SizedBox(height: 10,),
                  BlocSelector<HomeBloc, HomeState, String>(
                    selector: (state) {
                      if(state is HomeDataState){
                        return state.tipOfDay;
                      }
                      else{
                        return "";
                      }
                    },
                    builder: (context, state) {
                      return Text(
                        state,
                        maxLines: 5,
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium?.copyWith(
                            color: context.theme.secondaryHeaderColor));
                    },
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}