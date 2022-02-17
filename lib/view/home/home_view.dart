import 'package:earthquake/core/base/view/base_view.dart';
import 'package:earthquake/core/constant/assets.dart';
import 'package:earthquake/core/constant/sizes.dart';
import 'package:earthquake/core/constant/styles.dart';
import 'package:earthquake/core/widgets/list_tile.dart';
import 'package:earthquake/core/widgets/pointer.dart';
import 'package:earthquake/core/widgets/selection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel viewModel;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      viewModel = context.read<HomeViewModel>();
      viewModel.getEarthquakes();
      _scrollController.addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent) {
          viewModel.setItemCounter(20);
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (context, value) => SingleChildScrollView(
        controller: _scrollController,
        child: Stack(
          children: const [
            _Photo(),
            _Text(),
            _Body(),
          ],
        ),
      ),
    );
  }
}

class _ListView extends StatelessWidget {
  const _ListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, HomeViewModel viewModel, child) => ListView.builder(
        itemCount: viewModel.itemCounter,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20, top: 10),
        itemBuilder: (context, index) {
          return Consumer(
            builder: (context, HomeViewModel viewModel, child) {
              try {
                return viewModel.earthquakesForSelections == null
                    ? Container()
                    : InkWell(
                        onTap: () => viewModel.showMaterialDialog(
                            context,
                            viewModel.earthquakesForSelections![index].city!,
                            viewModel
                                .earthquakesForSelections![index].district!),
                        child: CustomListTile(
                          fun: () => true,
                          title: viewModel.titleChooser(index),
                          subtitle: 'Derinlik: ' +
                              viewModel
                                  .earthquakesForSelections![index].depth! +
                              ' km',
                          time:
                              viewModel.earthquakesForSelections![index].time!,
                          value: viewModel.earthquakesForSelections![index].m!,
                        ),
                      );
              } catch (e) {
                return Container();
              }
            },
          );
        },
      ),
    );
  }
}

class _Text extends StatelessWidget {
  const _Text({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, HomeViewModel viewModel, child) => LayoutBuilder(
        builder: (context, constraints) {
          if (viewModel.earthquakes == null) {
            return SizedBox(
              height: Sizes.height_30percent(context),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {}
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            height: Sizes.height_25percent(context),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Consumer(
                          builder: (context, HomeViewModel viewModel, child) {
                            try {
                              return Text(
                                  'En büyük deprem: ' +
                                      viewModel.findTheLargest()!.district! +
                                      ' (' +
                                      viewModel.findTheLargest()!.city! +
                                      ') - Şiddet: ' +
                                      viewModel.findTheLargest()!.m!,
                                  style: textMainStyle);
                            } catch (e) {
                              return const Text('-----');
                            }
                          },
                        )),
                  ),
                ),
                Expanded(
                  child: FittedBox(
                    child: Container(
                      margin: const EdgeInsets.only(left: 50),
                      child: Row(
                        children: [
                          Consumer(
                            builder: (context, HomeViewModel viewModel, child) {
                              try {
                                return Text(viewModel.earthquakes![0].m!,
                                    style: textMainStyle);
                              } catch (e) {
                                return const Text('-----');
                              }
                            },
                          ),
                          const Icon(
                            Icons.arrow_right,
                            size: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Consumer(
                    builder: (context, HomeViewModel viewModel, child) {
                      try {
                        return Text(viewModel.earthquakes![0].district! +
                            ' (' +
                            viewModel.earthquakes![0].city! +
                            ')');
                      } catch (e) {
                        return const Text('-----');
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(child: Consumer(
                  builder: (context, HomeViewModel viewModel, child) {
                    try {
                      return Text(viewModel.earthquakes![0].time!);
                    } catch (e) {
                      return const Text('-----');
                    }
                  },
                )),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, HomeViewModel viewModel, child) => AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        margin: viewModel.changeMargin(context),
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
          child: Column(
            children: [
              const _Pointers(),
              const SizedBox(height: 10),
              const Divider(),
              const _Selections(),
              const _SearchBar(),
              const _ListView(),
              Visibility(
                visible: viewModel.isVisible,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Sizes.width_70percent(context),
        child: Consumer(
          builder: (context, HomeViewModel viewModel, child) => Form(
            key: viewModel.formKey,
            child: Focus(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  viewModel.setFocused(true);
                }
                else{
                  viewModel.setFocused(false);
                }
              },
              child: TextFormField(
                controller: viewModel.textEditingController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.search),
                  fillColor: Colors.white,
                  hintText: 'Şehir giriniz...',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  viewModel.bringResults(value.trim());
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Selections extends StatelessWidget {
  const _Selections({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, HomeViewModel viewModel, child) => Row(
        children: [
          Expanded(
            child: Selection(
                text: 'TÜMÜ', fun: () => viewModel.fun(context, 0, true)),
          ),
          Expanded(
            child: Selection(
                text: '1 >', fun: () => viewModel.fun(context, 1, null)),
          ),
          Expanded(
            child: Selection(
                text: '2 >', fun: () => viewModel.fun(context, 2, null)),
          ),
          Expanded(
            child: Selection(
                text: '3 >', fun: () => viewModel.fun(context, 3, null)),
          ),
          Expanded(
            child: Selection(
                text: '4 >', fun: () => viewModel.fun(context, 4, null)),
          ),
          Expanded(
            child: Selection(
                text: '5 >', fun: () => viewModel.fun(context, 5, null)),
          ),
          Expanded(
            child: Selection(
                text: '6 >', fun: () => viewModel.fun(context, 6, null)),
          ),
          Expanded(
            child: Selection(
                text: '7 >', fun: () => viewModel.fun(context, 7, null)),
          ),
        ],
      ),
    );
  }
}

class _Pointers extends StatelessWidget {
  const _Pointers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, HomeViewModel viewModel, child) => Row(
        children: [
          Expanded(
            child: Pointer(
                assetImage: Assets.bang,
                value: viewModel.earthquakes == null
                    ? '-'
                    : '${viewModel.earthquakes![0].m}',
                text: 'Büyüklük'),
          ),
          Expanded(
            child: Pointer(
                assetImage: Assets.depth,
                value: viewModel.earthquakes == null
                    ? '-'
                    : '${viewModel.earthquakes![0].depth} km',
                text: 'Derinlik'),
          ),
          Expanded(
            child: Pointer(
                assetImage: Assets.city,
                value: viewModel.earthquakes == null
                    ? '-'
                    : '${viewModel.earthquakes![0].city}',
                text: 'Şehir'),
          ),
        ],
      ),
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.height_30percent(context),
      width: Sizes.width_100percent(context),
      child: Opacity(
          opacity: 0.3,
          child: Image.asset(
            Assets.world,
            fit: BoxFit.cover,
          )),
    );
  }
}
