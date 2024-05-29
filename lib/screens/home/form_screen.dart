import 'package:ekissanadmin/controllers/home/form_controller.dart';
import 'package:ekissanadmin/models/form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormScreen extends StatelessWidget {
  final FormController formController = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: Text('Forms'),
      ),
      body: Center(
        child: Obx(() {
          return ListView.builder(
            itemCount: formController.forms.length,
            itemBuilder: (context, index) {
              final FormModel form = formController.forms[index];
              return Card(
                color: Colors.white,
                child: ListTile(
                  title: Text('${form.firstName} ${form.lastName}'),
                  subtitle: Text('Scheme: ${form.scheme}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MaterialButton(
                        color: Colors.green,
                        onPressed: () async {
                          await formController.acceptForm(form);  // Pass the form model
                        },
                        child: Text('Accept'),
                      ),
                      SizedBox(width: 10),
                      MaterialButton(
                        onPressed: () async {
                          await formController.declineForm(form);  // Pass the form model
                        },
                        child: Text('Decline'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: formController.fetchForms,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
