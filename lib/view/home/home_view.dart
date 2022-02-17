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
  late HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      viewModel = context.read<HomeViewModel>();
      viewModel.getEarthquakes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (context, value) => SingleChildScrollView(
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
        itemCount: viewModel.earthquakes == null ? 0 : viewModel.earthquakes!.data!.length > 50 ? 50 : viewModel.earthquakes!.data!.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20, top: 10),
        itemBuilder: (context, index) {
          return Consumer(
            builder: (context, HomeViewModel viewModel, child) {
              try {
                return viewModel.earthquakes == null
                    ? Container()
                    : CustomListTile(
                        fun: () => true,
                        title: viewModel.titleChooser(index),
                        subtitle: 'Derinlik: ' +
                            viewModel.earthquakes!.data![index].depth! +
                            ' km',
                        time: viewModel.earthquakes!.data![index].time!,
                        value: viewModel.earthquakes!.data![index].m!,
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
                          return Text(viewModel.earthquakes!.data![0].m!,
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
                  return Text(viewModel.earthquakes!.data![0].district! +
                      ' (' +
                      viewModel.earthquakes!.data![0].city! +
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
                return Text(viewModel.earthquakes!.data![0].time!);
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
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          )),
      margin: EdgeInsets.only(top: Sizes.height_25percent(context)),
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
        child: Column(
          children: const [
            _Pointers(),
            SizedBox(height: 10),
            Divider(),
            _Selections(),
            _SearchBar(),
            _ListView(),
          ],
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
        child: TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.search),
            fillColor: Colors.white,
            hintText: 'Şehir giriniz...',
            border: InputBorder.none,
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
    return Row(
      children: [
        Expanded(
          child: Selection(text: 'TÜMÜ', fun: () => true),
        ),
        Expanded(
          child: Selection(text: '1 >', fun: () => true),
        ),
        Expanded(
          child: Selection(text: '2 >', fun: () => true),
        ),
        Expanded(
          child: Selection(text: '3 >', fun: () => true),
        ),
        Expanded(
          child: Selection(text: '4 >', fun: () => true),
        ),
        Expanded(
          child: Selection(text: '5 >', fun: () => true),
        ),
        Expanded(
          child: Selection(text: '6 >', fun: () => true),
        ),
        Expanded(
          child: Selection(text: '7 >', fun: () => true),
        ),
      ],
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
                    : '${viewModel.earthquakes!.data![0].m}',
                text: 'Büyüklük'),
          ),
          Expanded(
            child: Pointer(
                assetImage: Assets.depth,
                value: viewModel.earthquakes == null
                    ? '-'
                    : '${viewModel.earthquakes!.data![0].depth} km',
                text: 'Derinlik'),
          ),
          Expanded(
            child: Pointer(
                assetImage: Assets.city,
                value: viewModel.earthquakes == null
                    ? '-'
                    : '${viewModel.earthquakes!.data![0].city}',
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
      child: Opacity(
          opacity: 0.2,
          child: Image.asset(
            Assets.world,
            fit: BoxFit.cover,
          )),
    );
  }
}
