//**************************************************************
// Trigger Words View UI
// Author: Mo Drammeh
//**************************************************************

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memory_enhancer_app/app/themes/light_theme.dart';
import 'package:memory_enhancer_app/ui/alert/alert_popup.dart';
import 'package:memory_enhancer_app/ui/app_bar/app_bar.dart';
import 'package:memory_enhancer_app/ui/enums/enums.dart';
import 'package:memory_enhancer_app/ui/list_item/list_item_dynamic.dart';
import 'package:memory_enhancer_app/ui/navigation/navigation_controller.dart';
import 'package:memory_enhancer_app/file_operations.dart';
import 'package:memory_enhancer_app/ui/trigger_words/trigger_words_view_model.dart';
import 'package:stacked/stacked.dart';

class TriggerWordsView extends StatefulWidget {
  TriggerWordsView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TriggerWordsViewState();
}

class _TriggerWordsViewState extends State<TriggerWordsView> with TickerProviderStateMixin {
  FileOperations fileOperations = FileOperations();
  String startTriggerWords = "";
  String stopTriggerWords = "";
  String recallTriggerWords = "";
  final txtEditCtrl = TextEditingController();
  late TabController tabCtrl;

  void updateTriggerWords() {
    print("updating words");
    fileOperations.readTriggers(0).then((String value) {
      setState(() {
        startTriggerWords = value;
      });
    });
    fileOperations.readTriggers(1).then((String value) {
      setState(() {
        stopTriggerWords = value;
      });
    });
    fileOperations.readTriggers(2).then((String value) {
      setState(() {
        recallTriggerWords = value;
      });
    });
  }

  List<String> getStartTriggerWords() {
    List<String> array = startTriggerWords.trimLeft().split('\n');
    if (array[0] == "" && array.length == 1) {
      return List.empty();
    }
    array.sort();
    return array;
  }

  List<String> getStopTriggerWords() {
    List<String> array = stopTriggerWords.trimLeft().split('\n');
    if (array[0] == "" && array.length == 1) {
      return List.empty();
    }
    array.sort();
    return array;
  }

  List<String> getRecallTriggerWords() {
    List<String> array = recallTriggerWords.trimLeft().split('\n');
    if (array[0] == "" && array.length == 1) {
      return List.empty();
    }
    array.sort();
    return array;
  }

  @override
  void initState() {
    super.initState();
    tabCtrl = TabController(length: 3, vsync: this);
    updateTriggerWords();
  }

  @override
  void dispose() {
    txtEditCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TriggerWordsViewModel>.reactive(
    viewModelBuilder: () => TriggerWordsViewModel(),
    onModelReady: (model) {
    //model.initialize();
    },

    builder: (context, model, child) {
    return Scaffold(
      appBar: CustomAppBarTabbed(
          title: PageEnums.triggerWords.name,
          bottom:  CustomTabBar(
              controller: tabCtrl,
              tabs: <Widget>[Tab(text: 'START'), Tab(text: 'STOP'), Tab(text: 'RECALL')])),
      body:
      TabBarView(
      controller: tabCtrl,
      children: <Widget>[TriggerTabs(getTriggers: getStartTriggerWords, textEditControl: txtEditCtrl,
          fileOperations: fileOperations, updateTriggers: updateTriggerWords, tabController: tabCtrl),
        TriggerTabs(getTriggers: getStopTriggerWords, textEditControl: txtEditCtrl,
            fileOperations: fileOperations, updateTriggers: updateTriggerWords, tabController: tabCtrl),
        TriggerTabs(getTriggers: getRecallTriggerWords, textEditControl: txtEditCtrl,
            fileOperations: fileOperations, updateTriggers: updateTriggerWords, tabController: tabCtrl)]),
      bottomNavigationBar:
      BottomNavigationBarController(pageIndex: PageEnums.settings.index),
      persistentFooterButtons: <Widget>[
        Center(
            child: ElevatedButton(
                style:
                ElevatedButton.styleFrom(primary: lightTheme.accentColor),
                child: Text("Add Words/Phrases",
                    style: GoogleFonts.anton(
                        fontSize: 25, textStyle: TextStyle(letterSpacing: .6))),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomAlertTwoButton(
                          title: 'ADD WORD OR PHRASE',
                          content: TextFormField(controller: txtEditCtrl),
                          actionOneText: 'ADD',
                          actionOnePressed: (){
                            fileOperations.addTrigger(txtEditCtrl.text, tabCtrl.index);
                            updateTriggerWords();
                            Navigator.pop(context);
                            txtEditCtrl.clear();
                          },
                          actionTwoText: 'CANCEL',
                          actionTwoPressed: (){
                            Navigator.pop(context);
                            txtEditCtrl.clear();
                          }
                        );
                      });
                }))
      ],
    );
    });
  }
}

TabBar CustomTabBar({required List<Widget> tabs, required TabController controller}){
  return TabBar(
      controller: controller,
      tabs: tabs,
      indicatorColor: Colors.white,
      indicatorWeight: 5);
}

Widget TriggerTabs({required Function() getTriggers, required TextEditingController textEditControl,
  required FileOperations fileOperations, required Function updateTriggers, required TabController tabController}){
  return getTriggers().length > 0
      ? ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: getTriggers().length,
    itemBuilder: (BuildContext context, int index) {
      return CustomDynamicListItem(
          onEdit: () {
            textEditControl.text = '${getTriggers()[index]}';
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomAlertTwoButton(
                    title: 'EDIT TRIGGER',
                      content: TextFormField(controller: textEditControl),
                      actionOneText: 'CANCEL',
                      actionOnePressed: (){
                        fileOperations.editTrigger('${getTriggers()[index]}', textEditControl.text, tabController.index);
                        Navigator.pop(context);
                        textEditControl.clear();
                      },
                      actionTwoText: 'EDIT',
                      actionTwoPressed: (){
                        fileOperations.editTrigger('${getTriggers()[index]}', textEditControl.text, tabController.index);
                        updateTriggers();
                        Navigator.pop(context);
                        textEditControl.clear();
                      });
                });
          },
          onDelete: () {
            showDialog (
                context: context,
                builder: (BuildContext context) {
                  return CustomAlertTwoButton(
                    title: 'CONFIRM DELETION',
                      content: Text('${getTriggers()[index]}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                      actionOneText: 'CANCEL',
                      actionOnePressed: (){
                        Navigator.pop(context);
                      },
                      actionTwoText: 'DELETE',
                      actionTwoPressed: (){
                        fileOperations.deleteTrigger('${getTriggers()[index]}', tabController.index);
                        updateTriggers();
                        Navigator.pop(context);
                      });
                });
          },
          title: '${getTriggers()[index]}');
    },
  )
      : const Center(
      child: Text('Add words or phrases with the button below',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)));
}
