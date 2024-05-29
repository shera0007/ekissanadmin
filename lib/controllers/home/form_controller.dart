import 'package:ekissanadmin/models/form.dart';
import 'package:ekissanadmin/services/form_service.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  final FormService _formService = FormService();
  RxList<FormModel> forms = <FormModel>[].obs;

  Future<void> fetchForms() async {
    try {
      forms.value = await _formService.getForms();
    } catch (e) {
      print('Error fetching forms: $e');
    }
  }

  Future<void> acceptForm(FormModel form) async {
    // Log the userEmail to ensure it's being passed correctly
    print('Accepting form for userEmail: ${form.userEmail}');
    await _formService.updateFormStatus(form, 1, 'Your form has been accepted');
    await fetchForms();
  }

  Future<void> declineForm(FormModel form) async {
    // Log the userEmail to ensure it's being passed correctly
    print('Declining form for userEmail: ${form.userEmail}');
    await _formService.updateFormStatus(form, -1, 'Your form has been declined');
    await fetchForms();
  }
}
