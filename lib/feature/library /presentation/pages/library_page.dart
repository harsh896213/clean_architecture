import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/image_path/image_path.dart';
import 'package:pva/core/theme/app_pallete.dart';
import 'package:pva/core/theme/shadow.dart';
import 'package:pva/core/theme/text_styles.dart';
import 'package:pva/core/utils/debouncer.dart';
import 'package:pva/core/widgets/custom_app_bar.dart';
import 'package:pva/core/widgets/custom_bottomsheet.dart';
import 'package:pva/core/widgets/custom_search_bar.dart';
import 'package:pva/feature/home/presentation/bloc/home_bloc.dart';
import 'package:pva/feature/library%20/presentation/bloc/library_bloc.dart';
import 'package:pva/feature/library%20/presentation/pages/filter_bottom_sheet.dart';
import 'package:pva/feature/library%20/presentation/widget/document.dart';
import 'package:pva/feature/library%20/presentation/widget/expension_tile.dart';
import 'package:pva/feature/library%20/presentation/widget/resource.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  late final TextEditingController searchController;
  final Debouncer _debouncer = Debouncer();

  @override
  void initState() {
    searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => context.read<LibraryBloc>().add(GetLibraryData()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.iconBg,
      appBar: CustomAppBar(
        centerTitle: false,
        toolbarHeight: 100,
        title: Text(
          "Library",
          style: context.textTheme.titleLarge?.copyWith(fontSize: 28),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomSearchBar(
                    backgroundColor: Colors.white,
                    onChanged: _onSearchValueChange,
                    controller: searchController,
                    hintText: "Search resources ...",
                  ),
                ),
                const SizedBox(width: 12,),
                GestureDetector(
                  onTap: ()=> showDynamicBottomSheet(context: context, child:
                  BlocProvider.value(
                        value: context.read<LibraryBloc>(),
                        child: FilterBottomSheet(),
                      ),
                  ),
                  child: BlocSelector<LibraryBloc, LibraryState, int>(
                    selector: (state) {
                      if (state is LibraryDataState) {
                        return state.filterCount;
                      } else {
                        return 0;
                      }
                    },
                    builder: (context, state) {
                      return state > 0 ? Badge(
                        label: Text(
                          state > 0 ? state.toString() : "",
                          style: context.textTheme.titleSmall
                              ?.copyWith(fontSize: 12, color: Colors.white),
                        ),
                        child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: ShapeDecoration(
                              color: state > 0 ? AppPallete.primaryColor : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shadows: cardShadow,
                            ),
                            child: SvgPicture.asset(
                              width: 20,
                              height: 20,
                              ImagePath.filter,
                              color: Colors.white,
                            )),
                      ) : Container(
                          padding: EdgeInsets.all(12),
                          decoration: ShapeDecoration(
                            color: state > 0 ? AppPallete.primaryColor : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadows: cardShadow,
                          ),
                          child: SvgPicture.asset(
                            width: 20,
                            height: 20,
                            ImagePath.filter,
                          ));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    Text(
                      "Recommended Resource",
                      style: context.textTheme.titleLarge?.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 16,),
                    const SizedBox(
                      height: 360,
                      child: Resources(),
                    ),
                    const SizedBox(height: 20,),
                    Text(
                      "Documents",
                      style: context.textTheme.titleLarge?.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 16,),
                    const Document(),
                    const SizedBox(height: 40,),
                    Text(
                      "Frequently Asked Question",
                      style: context.textTheme.titleLarge?.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 16,),
                    const FrequentlyAskedQuestion()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _onSearchValueChange(String string) {
    _debouncer(() {
      context.read<LibraryBloc>().add(SearchResources(searchText: string));
    });
  }
}
