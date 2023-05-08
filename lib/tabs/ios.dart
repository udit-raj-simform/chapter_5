import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IOSScreen extends StatefulWidget {
  const IOSScreen({Key? key}) : super(key: key);

  @override
  State<IOSScreen> createState() => _IOSScreenState();
}

class _IOSScreenState extends State<IOSScreen> {
  List<String> labels = ["Alert Dialog", "Simple Dialog", "Bottom Sheet"];
  final List<Widget> _dialogs = [];
  List<String> listTileLabels = [
    "Save Video",
    "Share with Friends",
    "Report",
    "Close"
  ];
  List<IconData> listTileIcons = [
    Icons.save_alt_outlined,
    Icons.share_rounded,
    Icons.report_rounded,
    Icons.close_rounded,
  ];

  @override
  void initState() {
    _dialogs.add(_buildCupertinoAlertDialog());
    _dialogs.add(_buildCupertinoDialog());
    _dialogs.add(_buildCupertinoBottomSheetDialog());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...List.generate(
              3,
              (index) => CupertinoButton(
                onPressed: () => (index != _dialogs.length - 1)
                    ? showCupertinoDialog(
                        context: context, builder: (context) => _dialogs[index])
                    : showCupertinoModalPopup(
                        context: context,
                        builder: (context) => _dialogs[index]),
                child: Text(
                  labels[index],
                  style: const TextStyle(color: Colors.orange),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCupertinoAlertDialog() => CupertinoAlertDialog(
        title: const Text("Alert!!"),
        content: const Text("Warning! You Have Been Hacked."),
        actions: [
          CupertinoButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "No",
              style: TextStyle(color: Colors.red),
            ),
          ),
          CupertinoButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "okay",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      );

  Widget _buildCupertinoDialog() => CupertinoAlertDialog(
        title: const Text("Introduction"),
        content: const Padding(
          padding: EdgeInsets.all(15.0),
          child: CupertinoTextField(
            placeholder: "What should I call you?",
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text("Submit"),
          ),
        ],
      );

  Widget _buildCupertinoBottomSheetDialog() => CupertinoActionSheet(
        title: const Text("Options on Save"),
        message: const Text("Choose an option"),
        actions: [
          ...List.generate(
            4,
            (index) => CupertinoListTile(
              leading: const Icon(
                Icons.arrow_forward_ios_sharp,
                color: Colors.white,
              ),
              title: Text(
                listTileLabels[index],
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                listTileIcons[index],
                color: Colors.blue,
              ),
              onTap: () => Navigator.pop(context),
            ),
          ),
        ],
      );
}
