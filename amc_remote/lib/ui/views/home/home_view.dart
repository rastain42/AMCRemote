import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:amc_remote/ui/common/app_colors.dart';
import 'package:amc_remote/ui/common/ui_helpers.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Accueil'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: model.signOut,
            ),
          ],
        ),
        body: const Center(
          child: Text('Bienvenue, vous êtes connecté !'),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
