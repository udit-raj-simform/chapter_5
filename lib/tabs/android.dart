import 'package:chapter_5/utils/constants.dart';
import 'package:flutter/material.dart';

class AndroidScreen extends StatefulWidget {
  const AndroidScreen({Key? key}) : super(key: key);

  @override
  State<AndroidScreen> createState() => _AndroidScreenState();
}

class _AndroidScreenState extends State<AndroidScreen> {
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
    _dialogs.add(_buildAlertDialog());
    _dialogs.add(_buildSimpleDialog());
    _dialogs.add(_buildBottomSheetDialog());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...List.generate(
            3,
            (index) => ElevatedButton(
              onPressed: () => (index != _dialogs.length - 1)
                  ? showDialog(
                      context: context, builder: (context) => _dialogs[index])
                  : showModalBottomSheet(
                      context: context, builder: (context) => _dialogs[index]),
              child: Text(
                labels[index],
                style: const TextStyle(color: Colors.orange),
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildAlertDialog() => AlertDialog(
        icon: const Icon(Icons.label_important_outlined),
        title: const Text("Alert!!"),
        content: const Text("Warning! You Have Been Hacked."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "No",
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "okay",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      );

  Widget _buildSimpleDialog() => SimpleDialog(
        title: const Text("Introduction"),
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "What should I call you?",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Submit"),
          ),
        ],
      );

  Widget _buildBottomSheetDialog() => BottomSheet(
        onClosing: () {},
        builder: (context) => Container(
          height: Constants.deviceHeight * .35,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Divider(
                color: Colors.grey,
                thickness: 3.0,
                indent: Constants.deviceWidth / 3,
                endIndent: Constants.deviceWidth / 3,
              ),
              ...List.generate(
                4,
                (index) => ListTile(
                  leading: const Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.black54,
                  ),
                  title: Text(
                    listTileLabels[index],
                    style: const TextStyle(color: Colors.black54),
                  ),
                  trailing: Icon(
                    listTileIcons[index],
                    color: Colors.blue,
                  ),
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      );
}
