import 'package:flutter/material.dart';
import 'package:clock_in_demo/route_generator.dart' as route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clock_in_demo/modules/punch/punch_viewmodel.dart';
import 'package:clock_in_demo/widgets/punchButton.dart';
import 'package:clock_in_demo/widgets/alert_dialog.dart';

final class PunchView extends ConsumerStatefulWidget {
  const PunchView({super.key});

  @override
  ConsumerState<PunchView> createState() => _PunchViewState();
}

final class _PunchViewState extends ConsumerState<PunchView> {

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(punchProvider);
    final notifier = ref.read(punchProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.message.isNotEmpty) {
        showAlertDialog(
          context: context,
          title: '通知',
          content: state.message,
        );
        notifier.resetMsg();
      }

      if (state.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('打卡成功'),
            duration: Duration(seconds: 2),
          ),
        );
        notifier.resetSuccess();
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '打卡',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height:20),
                Text(
                  state.currentDate,
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  state.currentTime,
                  style: const TextStyle(fontSize: 55),
                ),
                const SizedBox(height:50),
                PunchButton(
                    title: '上班',
                    time: state.clockedIn,
                    isClockedIn: (state.clockedIn != '') ? true : false,
                    onPressed: (state.clockedIn != '') ? null
                        : (!state.isButtonEnabled) ? null : () => notifier.punch(isWork: true)
                ),
                const SizedBox(height:30),
                PunchButton(
                    title: '下班',
                    time: state.clockedOut,
                    isClockedIn: (state.clockedOut != '') ? true : false,
                    onPressed: (state.clockedOut != '' || state.clockedIn == '') ? null
                        : (!state.isButtonEnabled) ? null : () => notifier.punch(isWork: false)
                ),
                const SizedBox(height:30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, route.RoutePaths.approvalProcess);
                        },
                        child: const Text(
                          '簽核 >',
                          style: TextStyle(fontSize: 20),
                        )
                    )
                  ],
                )
              ],
            ),
          ),
          if (state.isLoading)
            Container(
                color: Colors.black54.withOpacity(0.3),
                child: const Center(
                    child: CircularProgressIndicator()
                )
            ),
        ],
      ),
    );
  }
}