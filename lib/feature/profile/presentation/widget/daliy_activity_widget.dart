import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pva/feature/profile/domain/entities/time_of_day.dart';

import '../../domain/entities/acitivity_item.dart';
import '../bloc/daily_activity_bloc.dart';

class DailyActivityWidget extends StatelessWidget {
  final DateTime initialDate;

  const DailyActivityWidget({
    super.key,
    required this.initialDate,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DailyActivityBloc()..add(LoadDailyActivitiesEvent(initialDate)),
      child: const DailyActivityView(),
    );
  }
}

class DailyActivityView extends StatelessWidget {
  const DailyActivityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyActivityBloc, DailyActivityState>(
      builder: (context, state) {
        if (state is DailyActivityInitial || state is DailyActivityLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DailyActivityLoaded) {
          return _buildContent(context, state);
        } else if (state is DailyActivityError) {
          return Center(child: Text((state as DailyActivityError).message));
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }

  Widget _buildContent(BuildContext context, DailyActivityLoaded state) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daily Activity',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => _showDatePicker(context, state.selectedDate),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          DateFormat('dd MMM yy').format(state.selectedDate),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  const Expanded(
                    flex: 3,
                    child: Text(
                      'Name',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        'Morning',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        'Afternoon',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        'Evening',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        'Night',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.categories.length,
              itemBuilder: (context, categoryIndex) {
                final category = state.categories[categoryIndex];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text(
                        category.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: category.activities.length,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemBuilder: (context, activityIndex) {
                        final activity = category.activities[activityIndex];
                        return _buildActivityRow(context, activity);
                      },
                    ),

                    if (categoryIndex < state.categories.length - 1)
                      const Divider(height: 1),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityRow(BuildContext context, ActivityItem activity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Activity name
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                activity.name,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ),

          // Morning checkbox
          Expanded(
            flex: 2,
            child: Center(
              child: _buildTimeCheckbox(
                context,
                activity,
                PartOfDay.morning,
                activity.schedule.morning,
                activity.schedule.morningTime,
              ),
            ),
          ),

          // Afternoon checkbox
          Expanded(
            flex: 2,
            child: Center(
              child: _buildTimeCheckbox(
                context,
                activity,
                PartOfDay.afternoon,
                activity.schedule.afternoon,
                activity.schedule.afternoonTime,
              ),
            ),
          ),

          // Evening checkbox
          Expanded(
            flex: 2,
            child: Center(
              child: _buildTimeCheckbox(
                context,
                activity,
                PartOfDay.evening,
                activity.schedule.evening,
                activity.schedule.eveningTime,
              ),
            ),
          ),

          // Night checkbox
          Expanded(
            flex: 2,
            child: Center(
              child: _buildTimeCheckbox(
                context,
                activity,
                PartOfDay.night,
                activity.schedule.night,
                activity.schedule.nightTime,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCheckbox(
      BuildContext context,
      ActivityItem activity,
      PartOfDay timeOfDay,
      bool isChecked,
      String? timeText,
      ) {
    return GestureDetector(
      onTap: () {
        context.read<DailyActivityBloc>().add(
          ToggleActivityStatusEvent(
            activityId: activity.id,
            timeOfDay: timeOfDay,
            isChecked: !isChecked,
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: isChecked ? Colors.blue : Colors.grey.shade300,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: isChecked
                ? Icon(Icons.check, color: Colors.blue, size: 22)
                : null,
          ),
          if (isChecked && timeText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                timeText,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showDatePicker(BuildContext context, DateTime currentDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null && pickedDate != currentDate) {
      // Dispatch event to change date
      context.read<DailyActivityBloc>().add(ChangeDateEvent(pickedDate));
    }
  }
}


