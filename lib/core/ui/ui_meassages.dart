import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'theme/colors.dart';
import 'widgets/main_button.dart';

class UiMessages {
  UiMessages._();

  void showToast(String text) {
    BotToast.showText(text: text);
  }

  void showLoading(String text) {
    BotToast.showLoading();
  }

  void closeLoading(String text) {
    BotToast.closeAllLoading();
  }

  void showNotification({
    Widget Function(void Function())? title,
    Widget Function(void Function())? subtitle,
  }) {
    BotToast.showNotification(title: title, subtitle: subtitle);
  }

  void showSuccessDialog({
    required BuildContext context,
    required String text,
    required Color? color,
    double size = 50,
  }) {
    final contextSize = MediaQuery.of(context).size;
    const image = AssetImage('assets/gif/success.gif');

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(contextSize.width * .05),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: image,
                      key: UniqueKey(),
                      width: size,
                      height: size,
                    ),
                    Text(text),
                  ],
                ),
                MainButton(
                  text: 'done',
                  color: color ?? AppColors.purple,
                  textColor: color ?? Colors.white,
                  height: 20,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() => image.evict());
  }

  Future<bool> showPopDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (_) {
            final Size size = MediaQuery.of(context).size;
            return Dialog(
              backgroundColor: Colors.transparent,
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(size.width * .05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('warning'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 15),
                        Text('ignore Changes'),
                        SizedBox(height: 15),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MainButton(
                          text: 'cancel',
                          color: AppColors.grey,
                          textColor: Colors.grey.shade700,
                          onPressed: () => Navigator.of(_).pop(false),
                        ),
                        MainButton(
                          text: 'agree',
                          color: AppColors.purple,
                          textColor: Colors.white,
                          onPressed: () => Navigator.of(_).pop(true),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ) ??
        false;
  }
}
