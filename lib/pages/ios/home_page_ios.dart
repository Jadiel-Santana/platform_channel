import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../platform_channels/platform_channels.dart';
import '../../theme/theme.dart';
import './ios.dart';

class HomePageIOS extends StatefulWidget {
  const HomePageIOS({
    super.key,
  });

  @override
  State<HomePageIOS> createState() => _HomePageIOSState();
}

class _HomePageIOSState extends State<HomePageIOS> {
  final platformChannel = CustomPlatformChannel();
  bool _showEvent = false;
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const Text('Platform Channel IOS'),
        centerTitle: true,
        backgroundColor: AppColors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: _showEvent,
              replacement: PalindromeWidget(
                result: _result,
                onChanged: (String word) async {
                  _result = (word.isNotEmpty)
                      ? await platformChannel.callPalindromeMethodChannel(
                          word: word)
                      : '';

                  setState(() {});
                },
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: StreamBuilder<String>(
                  stream: platformChannel.callRandomNameEventChannel(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return RandomNameWidget(
                      result: snapshot.data!,
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
