import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

// https://pub.dev/packages/permission_handler/example
/// Permission widget containing information about the passed [Permission]
class PermissionWidget extends StatefulWidget {
  /// Constructs a [PermissionWidget] for the supplied [Permission]
  const PermissionWidget(this._permission, {super.key});

  final Permission _permission;

  @override
  _PermissionState createState() => _PermissionState(_permission);
}

class _PermissionState extends State<PermissionWidget>
    with WidgetsBindingObserver {
  _PermissionState(this._permission);

  final Permission _permission;
  PermissionStatus _permissionStatus = PermissionStatus.granted;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _listenForPermissionStatus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  //https://stackoverflow.com/questions/53128438/android-onresume-method-equivalent-in-flutter
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //do your stuff
      print("resumed");
      _listenForPermissionStatus();
    }
  }

  void _listenForPermissionStatus() async {
    final status = await _permission.status;
    //print(_permission);
    //print(status);
    setState(() => _permissionStatus = status);
  }

  Color getPermissionColor() {
    switch (_permissionStatus) {
      case PermissionStatus.denied:
        return Colors.red;
      case PermissionStatus.granted:
        return Colors.green;
      case PermissionStatus.limited:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _permissionStatus != PermissionStatus.granted
        ? ColoredBox(
            color: Color.fromARGB(251, 181, 68, 98),
            child: ListTile(
              title: Text(
                "notifications denied :(",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              subtitle: Text(
                "tap here to allow. we will only ping you once a day, we promise!",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              leading: Icon(Icons.notifications_off,
                  color: Theme.of(context).canvasColor),
              onTap: () {
                requestPermission(_permission);
              },
            ))
        : const SizedBox.shrink();
  }

  void checkServiceStatus(
      BuildContext context, PermissionWithService permission) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text((await permission.serviceStatus).toString()),
    ));
  }

  Future<void> requestPermission(Permission permission) async {
    final status = await _permission.status;
    setState(() => _permissionStatus = status);
    if (_permissionStatus != PermissionStatus.granted) {
      openAppSettings();
    }
  }
}
