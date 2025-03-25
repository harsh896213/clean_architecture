import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/extension/date_time_ext.dart';
import 'package:pva/core/image_path/image_path.dart';
import 'package:pva/core/theme/app_pallete.dart';
import 'package:pva/core/theme/shadow.dart';
import 'package:pva/core/theme/text_styles.dart';
import 'package:pva/core/widgets/custom_app_bar.dart';
import 'package:pva/core/widgets/svg_button_container.dart';
import 'package:pva/feature/home/domain/entity/activity.dart';
import 'package:pva/feature/home/presentation/bloc/home_bloc.dart';
import 'package:pva/feature/home/presentation/widget/activity_card.dart';
import 'package:pva/feature/home/presentation/widget/progress_card.dart';
import 'package:pva/feature/home/presentation/widget/time_chip.dart';
import '../../../../core/common/widgets/button/button_factory.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var dayList = ["Morning", "Afternoon", "Evening", "Night"];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeBloc>().add(LoadActivities(DateTime.now()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.iconBg,
      appBar: CustomAppBar(
        toolbarHeight: 100,
        centerTitle: false,
        title: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello Harsh',
                style: context.textTheme.titleLarge?.copyWith(fontSize: 26),
              ),
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: context.theme.secondaryHeaderColor),
              ),
            ],
          ),
        ),
        actions: [
          SvgButtonContainer(
              padding: 14,
              color: AppPallete.iconBg,
              svgPath: ImagePath.bellIcon,
              size: 24),
          const SizedBox(
            width: 12,
          ),
          GestureDetector(
              onTap: () => context.push("/profile"),
              child: SvgButtonContainer(
                  padding: 14,
                  color: AppPallete.iconBg,
                  svgPath: ImagePath.profile,
                  size: 24)),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProgressCard(
              progress: .5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Activities',
                      style:
                          context.textTheme.titleLarge?.copyWith(fontSize: 20)),
                  Container(
                    decoration: ShapeDecoration(
                        shadows: cardShadow,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Row(children: [
                      ButtonFactory().createIconButton(
                          icon: Icons.arrow_back_ios_rounded,
                          iconSize: 20,
                          color: context.theme.primaryColor,
                          onPressed: () {
                            context.read<HomeBloc>().add(PrevSelectedTime());
                          }),
                      SizedBox(
                        width: 4,
                      ),
                      BlocSelector<HomeBloc, HomeState, DateTime>(
                        selector: (state) {
                          if (state is HomeDataState) {
                            return state.selectedTime;
                          } else {
                            return DateTime.now();
                          }
                        },
                        builder: (context, state) {
                          return Text(
                            _getDate(state),
                            style: context.textTheme.labelMedium,
                          );
                        },
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      ButtonFactory().createIconButton(
                          icon: Icons.arrow_forward_ios_rounded,
                          iconSize: 20,
                          color: context.theme.primaryColor,
                          onPressed: () {
                            context.read<HomeBloc>().add(NextSelectedTime());
                          }),
                    ]),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 40,
                child: BlocSelector<HomeBloc, HomeState, String>(
                  selector: (state) {
                    if (state is HomeDataState) {
                      return state.selectedChip;
                    } else {
                      return "Morning";
                    }
                  },
                  builder: (context, state) {
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => TimeChip(
                        time: dayList[index],
                        isSelected: dayList[index] == state,
                      ),
                      itemCount: dayList.length,
                    );
                  },
                )),
            SizedBox(
              height: 10,
            ),
            BlocSelector<HomeBloc, HomeState, List<Activity>>(
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
                  padding: EdgeInsets.symmetric(horizontal: 20), // Removes extra padding
                  itemBuilder: (context, index) {
                    return ActivityCard(
                        activity: state[index],
                        onComplete:
                            () {}); // Replace with ActivityCard widget
                  },
                  itemCount: state.length,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

String _getDate(DateTime state) {
  if (state.isToday)
    return "Today";
  else if (state.isTomorrow)
    return "Tomorrow";
  else if (state.isYestierday)
    return "Yesterday";
  else
    return state.getMonthDate;
}
