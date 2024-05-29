import 'package:ekissanadmin/controllers/home/support_controller.dart';
import 'package:ekissanadmin/utils/widgets/buttons.dart';
import 'package:ekissanadmin/utils/widgets/textfields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SupportFormScreen extends StatelessWidget {
  final SupportController controller = Get.put(SupportController());
  final String? supportId;

  SupportFormScreen({this.supportId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(supportId == null ? 'Add Support Topic' : 'Edit Support Topic'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              CustomTextField(
                hintText: "Enter Topic",
                keyboardType: TextInputType.text,
                controller: controller.topicEngController,
                headingText: "Topic (English)",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter topic in English';
                  }
                  return null;
                },
              ),
                   SizedBox(height: 20),
              CustomTextField(
                hintText: "Enter Topic",
                keyboardType: TextInputType.text,
                controller: controller.topicEngController,
                headingText: "Topic (Urdu)",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter topic in Urdu';
                  }
                  return null;
                },
              ),
                   SizedBox(height: 20),
              CustomTextField(
                hintText: "Enter Description",
                keyboardType: TextInputType.text,
                controller: controller.topicEngController,
                headingText: "Description (English)",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Description in English';
                  }
                  return null;
                },
              ),
                   SizedBox(height: 20),
              CustomTextField(
                hintText: "Enter Description",
                keyboardType: TextInputType.text,
                controller: controller.topicEngController,
                headingText: "Description (Urdu)",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Description in Urdu';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Obx(() {
                return controller.isLoading.value
                    ? CircularProgressIndicator()
                    : GreenButton(
                      buttonText:(supportId == null ? 'Add Support Topic' : 'Update Support Topic') ,
                        onPressedFunction: () {
                          if (supportId == null) {
                            controller.addSupportTopic();
                          } else {
                            controller.updateSupportTopic(supportId!);
                          }
                        },
                        context: context,
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
