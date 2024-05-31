import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/switch_controller.dart';
import '../model/switch_model.dart';
import '../utils/auth_provider.dart';

class SwitchSelectionScreen extends StatefulWidget {
  final String? groupName;

  const SwitchSelectionScreen({super.key, this.groupName});

  @override
  _SwitchSelectionScreenState createState() => _SwitchSelectionScreenState();
}

class _SwitchSelectionScreenState extends State<SwitchSelectionScreen> {
  late Future<List<SwitchModel>> _switchesFuture;
  List<SwitchModel> selectedSwitches = [];

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.userId;
    if (userId != null) {
      _switchesFuture = SwitchController().getSwitches(userId);
    } else {
      _switchesFuture = Future.error('User ID is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName != null
            ? '${widget.groupName}'
            : 'Select Switches'),
      ),
      body: FutureBuilder<List<SwitchModel>>(
        future: _switchesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No switches available'));
          }

          List<SwitchModel> availableSwitches = snapshot.data!;

          return ListView.builder(
            itemCount: availableSwitches.length,
            itemBuilder: (context, index) {
              SwitchModel switchItem = availableSwitches[index];
              return ListTile(
                title: Text(switchItem.name),
                trailing: IconButton(
                  icon: selectedSwitches.contains(switchItem)
                      ? const Icon(Icons.check_box)
                      : const Icon(Icons.check_box_outline_blank),
                  onPressed: () {
                    setState(() {
                      if (selectedSwitches.contains(switchItem)) {
                        selectedSwitches.remove(switchItem);
                      } else {
                        selectedSwitches.add(switchItem);
                      }
                    });
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, selectedSwitches);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
