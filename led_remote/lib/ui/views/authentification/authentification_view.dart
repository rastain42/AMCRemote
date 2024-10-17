import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'authentification_viewmodel.dart';

class AuthentificationView extends StackedView<AuthentificationViewModel> {
  AuthentificationView({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthentificationViewModel>.reactive(
      viewModelBuilder: () => AuthentificationViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => model.signIn(
                    _emailController.text, _passwordController.text),
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget builder(
    BuildContext context,
    AuthentificationViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  AuthentificationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AuthentificationViewModel();
}
