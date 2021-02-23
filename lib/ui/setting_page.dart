import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dicoding_news_app/provider/schedul_provider.dart';
import 'package:dicoding_news_app/widgets/popup_dialog.dart';

class SettingPage extends StatelessWidget {
  static const routeName = '/setting';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Notification'),
            trailing: Consumer<SchedulProvider>(
              builder: (context, scheduled, _) {
                return Switch.adaptive(
                  value: scheduled.isScheduled,
                  onChanged: (value) async {
                    if (Platform.isIOS) {
                      popupDialog(context);
                    } else {
                      scheduled.scheduledResto(value);
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
