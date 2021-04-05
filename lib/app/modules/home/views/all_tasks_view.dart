import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taskly/app/global_widgets/bottom_sheet.dart';
import 'package:taskly/app/global_widgets/expandable_container.dart';
import 'package:taskly/app/modules/home/controllers/home_controller.dart';
import 'package:taskly/app/theme/text_theme.dart';

class AllTasksView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Theme.of(context).scaffoldBackgroundColor,
        //padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50, left: 25, right: 25),
              child: Text(
                'All Tasks',
                style: kSubHeadTextStyle.copyWith(
                    color: Theme.of(context).primaryColorDark),
              ),
            ),
            SizedBox(height: Get.height * 0.012),
            GetBuilder<HomeController>(
              id: 1,
              builder: (controller) {
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final task = controller.allTasks[index];
                      return Slidable(
                        actionPane: SlidableBehindActionPane(),
                        actionExtentRatio: 0.15,
                        controller: controller.slideC,
                        child: ExpandedContainer(
                          icon: task.taskImage,
                          title: task.taskTitle,
                          time: task.startTime,
                          desc: task.taskDesc,
                          ifDate: true,
                          date: DateFormat.yMMMd().format(task.taskDate),
                        ),
                        actions: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 20, left: 20),
                            child: IconButton(
                                icon: Icon(Icons.edit, size: 30),
                                onPressed: () {
                                  controller.slideC.activeState?.close();
                                  Slidable.of(context)?.close();
                                  controller.preUpdateTask(task);
                                  showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return BottomSheetContent(
                                        buttonText: 'Update Task',
                                        onSubmit: () {
                                          controller.updateTask(task);
                                        },
                                      );
                                    },
                                  );
                                }),
                          ),
                        ],
                        secondaryActions: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 20, right: 30),
                            child: IconButton(
                                icon: Icon(Icons.delete, size: 30),
                                onPressed: () {
                                  controller.slideC.activeState?.close();
                                  Slidable.of(context)?.close();
                                  controller.deleteTask(task);
                                }),
                          ),
                        ],
                      );
                    },
                    itemCount: controller.allTasks.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
