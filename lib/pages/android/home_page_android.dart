import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../platform_channels/platform_channels.dart';
import '../../theme/theme.dart';
import './android.dart';

class HomePageAndroid extends StatefulWidget {
  const HomePageAndroid({
    super.key,
  });

  @override
  State<HomePageAndroid> createState() => _HomePageAndroidState();
}

class _HomePageAndroidState extends State<HomePageAndroid> {
  final platformChannel = CustomPlatformChannel();
  bool _showEvent = false;
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const Text('Platform Channel Android'),
        centerTitle: true,
        backgroundColor: AppColors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: _showEvent,
              replacement: BatteryLevelWidget(
                result: _result,
                onPressed: () async {
                  _result = await platformChannel.callBatteryMethodChannel();
                  setState(() {});
                },
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: StreamBuilder<DateTime>(
                  stream: platformChannel.callTimerEventChannel(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return CountdownDateTime(
                      dateTime: snapshot.data!,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 120),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonCard(
                    title: 'Method Channel',
                    icon: Icons.send,
                    onPressed: () {
                      setState(() {
                        _showEvent = false;
                      });
                    },
                  ),
                  ButtonCard(
                    title: 'Event Channel',
                    icon: Icons.stream,
                    onPressed: () {
                      setState(() {
                        _showEvent = true;
                        _result = '';
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
