import 'package:el_grocer/domain/blocs/products_bloc/products_bloc.dart';
import 'package:el_grocer/domain/blocs/products_bloc/products_bloc_event.dart';
import 'package:el_grocer/domain/blocs/products_bloc/products_bloc_state.dart';
import 'package:el_grocer/domain/blocs/sort_bloc/sort_bloc.dart';
import 'package:el_grocer/domain/blocs/sort_bloc/sort_bloc_event.dart';
import 'package:el_grocer/domain/blocs/sort_bloc/sort_bloc_state.dart';
import 'package:el_grocer/domain/blocs/themes/themes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../routes/routes.dart';
import '../ui/appbar.dart';
import '../ui/product_page_widget.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final ScrollController _scrollController = ScrollController();
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        context
            .read<ProductsBloc>()
            .add(GetNextProductPageEvent(sortMethod: 'asc', sortName: 'id'));
      }
    });
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    _lastWords = '';
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsBlocState>(builder: (BuildContext context, state) {
      final searchProducts = state.productsBlocModel;
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight * 2),
            child: AppBarWidget(
              readOnly: false,
              onTap: () {},
              autofocus: true,
              appbarLeading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_outlined),
              ),
              appbarTitle: const Text(
                "Search",
              ),
              onChange: (text) {
                context
                    .read<ProductsBloc>()
                    .add(GetSearchProductEvent(sortMethod: 'asc', sortName: 'id'));
              },
              implyLeading: true,
              voiceCallback: () {
                context
                    .read<ProductsBloc>()
                    .add(SpeechToTextControllerEvent(text: '', sortName: 'id', sortMethod: 'asc'));
                showModalBottomSheet(
                    isDismissible: false,
                    elevation: 0.3,
                    context: context,
                    builder: (_) {
                      _speechToText.isNotListening ? _startListening() : _stopListening();
                      return SizedBox(
                        height: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Icon(
                                Icons.keyboard_voice_outlined,
                                color: ThemeColor.greenColor,
                                size: 72,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      context.read<ProductsBloc>().add(SpeechToTextControllerEvent(
                                            text: _lastWords,
                                            sortName: 'id',
                                            sortMethod: 'asc',
                                          ));
                                      Navigator.of(context).pop();
                                      _stopListening();
                                    },
                                    icon: Icon(
                                      Icons.check,
                                      color: ThemeColor.greenColor,
                                      size: 50,
                                    ))
                              ],
                            )
                          ],
                        ),
                      );
                    });
                setState(() {});
              },
            )),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                              // isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                              context: context,
                              // backgroundColor: Colors.transparent,
                              builder: (context) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(Icons.arrow_back)),
                                    const _RadioListThemes(),
                                  ],
                                );
                              });
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.sort),
                            SizedBox(
                              width: 15,
                            ),
                            Text("Sort By"),
                          ],
                        )),
                  ),
                ),
                Card(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextButton(
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.list),
                            SizedBox(
                              width: 15,
                            ),
                            Text("ListView"),
                          ],
                        )),
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView(
                controller: _scrollController,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemExtent: 160,
                      itemCount: searchProducts.filteredProducts.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = searchProducts.filteredProducts[index];
                        return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  MainNavigationRouteNames.productCard,
                                  arguments: product,
                                );
                              },
                              child: ProductPageWidget(
                                product: product,
                              ),
                            ));
                      }),
                  if (searchProducts.filteredProducts.length < (searchProducts.totalCount ?? 0))
                    Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: ThemeColor.greenColor,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _RadioListThemes extends StatelessWidget {
  const _RadioListThemes();

  // ThemesState? _character = ThemesState.light;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortBloc, SortBlocState>(builder: (BuildContext context, state) {
      return ListView(
        shrinkWrap: true,
        children: <Widget>[
          RadioListTile<SortState>(
            // activeColor: Colors.green,
            title: const Text(
              'Default',
            ),
            value: SortState.defaultSort,
            groupValue: state.sortAndListCubitModel.sortState,
            onChanged: (value) {
              context.read<SortBloc>().add(DefaultSortBlocEvent(defaultSort: value));
              Navigator.of(context).pop();
            },
          ),
          RadioListTile<SortState>(
            // activeColor: Colors.green,
            title: const Text(
              'Newest Firs',
              // style: TextStyle(color: Colors.white),
            ),
            value: SortState.newestFirs,
            groupValue: state.sortAndListCubitModel.sortState,
            onChanged: (value) {
              context.read<SortBloc>().add(NewestSortBlocEvent(newest: value));
              Navigator.of(context).pop();
            },
          ),
          RadioListTile<SortState>(
            // activeColor: Colors.green,
            title: const Text(
              'Oldest First',
              // style: TextStyle(color: Colors.white),
            ),
            value: SortState.oldestFirst,
            groupValue: state.sortAndListCubitModel.sortState,
            onChanged: (SortState? value) {
              context.read<SortBloc>().add(OldestSortBlocEvent(oldest: value));
              Navigator.of(context).pop();
            },
          ),
          RadioListTile<SortState>(
            // activeColor: Colors.green,
            title: const Text(
              'Price - High to Low',
              // style: TextStyle(color: Colors.white),
            ),
            value: SortState.highToLow,
            groupValue: state.sortAndListCubitModel.sortState,
            onChanged: (SortState? value) {
              context.read<SortBloc>().add(HighToLowSortBlocEvent(highToLow: value));
              Navigator.of(context).pop();
            },
          ),
          RadioListTile<SortState>(
            // activeColor: Colors.green,
            title: const Text(
              'Price - Low to High',
              // style: TextStyle(color: Colors.white),
            ),
            value: SortState.lowToHigh,
            groupValue: state.sortAndListCubitModel.sortState,
            onChanged: (SortState? value) {
              context.read<SortBloc>().add(LowToHighSortBlocEvent(lowToHigh: value));
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }
}
