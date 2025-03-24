import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/theme/text_styles.dart';
import 'package:pva/core/utils/debouncer.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: CustomSearchBar(
                  backgroundColor: Colors.white,
                  onChanged: _onSearchValueChange,
                  controller: searchController,
                  hintText: "Search resources ...",
                ),
              ),
              GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.6,
                  ),
                  builder: (context1) => BlocProvider.value(
                    value: context.read<LibraryBloc>(),
                    child: FilterBottomSheet(),
                  ),
                ),
                child: Badge(
                  label: Text("2"),
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: const Offset(-5, 5),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.filter_alt_outlined,
                        size: 30,
                      )),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  child: Text(
                    "Recommended Resource",
                    style: context.textTheme.titleLarge?.copyWith(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 360,
                  child: Resources(),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Documents",
                    style: context.textTheme.titleLarge?.copyWith(fontSize: 20),
                  ),
                ),
                Document(),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Frequently Asked Question",
                    style: context.textTheme.titleLarge?.copyWith(fontSize: 20),
                  ),
                ),
                FrequentlyAskedQuestion()
              ],
            ),
          ),
        ),
      ],
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
