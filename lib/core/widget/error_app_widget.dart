import 'package:flutter_presensi/core/helper/global_helper.dart';
import 'package:flutter/material.dart';

class ErrorAppWidget extends StatelessWidget {
  final String description;
  final void Function() onPressDefaultButton;
  final FilledButton? alternatifButton;
  const ErrorAppWidget(
      {super.key,
      required this.description,
      required this.onPressDefaultButton,
      this.alternatifButton});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            description,
            style: GlobalHelper.getTextStyle(context,
                appTextStyle: AppTextStyle.HEADLINE_SMALL),
          ),
          const SizedBox(
            height: 30,
          ),
          alternatifButton ??
              FilledButton.icon(
                  onPressed: onPressDefaultButton,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Refresh"))
        ],
      ),
    );
  }
}
