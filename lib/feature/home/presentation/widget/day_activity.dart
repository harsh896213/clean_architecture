import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pva/core/animation/elastic_animation_controller.dart';
import 'package:pva/feature/home/domain/entity/activity_entity.dart';
import 'package:pva/feature/home/presentation/bloc/home_bloc.dart';
import 'package:pva/feature/home/presentation/widget/activity_card.dart';

class DayActivity extends StatefulWidget {
  const DayActivity({super.key});

  @override
  State<DayActivity> createState() => _DayActivityState();
}

class _DayActivityState extends State<DayActivity> with TickerProviderStateMixin {
  final _elasticAnimationController = ElasticAnimationController();

  @override
  void dispose() {
    _elasticAnimationController.disposeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, List<Activity>>(
      selector: (state) {
        if (state is HomeDataState) {
          return state.filterActivity;
        } else {
          return [];
        }
      },
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20),
          // Removes extra padding
          itemBuilder: (context, index) {
            return RepaintBoundary(
              child: _elasticAnimationController.wrapWithElastic(
                itemId: index.toString(),
                vsync: this,
                child: ActivityCard(
                    activity: state[index],
                    onComplete: () {
                      _elasticAnimationController.startAnimation(index.toString());
                    context.read<HomeBloc>().add(ActivityActionEvent(
                        activityState: ActivityState.completed,
                        id: state[index].id));
                  },
                    onNotComplete: () {
                      _elasticAnimationController.startAnimation(index.toString());
                      context.read<HomeBloc>().add(ActivityActionEvent(
                          activityState: ActivityState.notCompleted,
                          id: state[index].id));
                    },
                    ),
              ),
            );
          },
          itemCount: state.length,
        );
      },
    );
  }
}
