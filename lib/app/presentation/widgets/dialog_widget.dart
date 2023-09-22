import 'package:flutter/material.dart';

import '../../utils/localization.dart';

showDialogWidget({
  required BuildContext context,
  required String content,
  required VoidCallback onOk,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(LocalText.of(context.l10n?.error)),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onOk,
          child: Text(LocalText.of(context.l10n?.ok)),
        ),
      ],
    ),
  );
}
