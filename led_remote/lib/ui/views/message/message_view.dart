import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'message_viewmodel.dart';

class MessageView extends StackedView<MessageViewModel> {
  MessageView({Key? key}) : super(key: key);

  final _messageController = TextEditingController();

  @override
  Widget builder(
    BuildContext context,
    MessageViewModel viewModel,
    Widget? child,
  ) {
    return ViewModelBuilder<MessageViewModel>.reactive(
      viewModelBuilder: () => MessageViewModel(),
      builder: (context, model, child) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Envoyer un message personnalisé à la matrice LED'),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(labelText: 'Message personnalisé'),
            ),
            ElevatedButton(
              onPressed: () => model.sendMessage(_messageController.text),
              child: Text('Envoyer le message'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  MessageViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MessageViewModel();
}
