import 'package:flutter_contacts/flutter_contacts.dart';

class ContactPickerHelper {
  static Future<String?> pickPhoneNumber() async {
    try {
      // Pick a contact using the external contact picker
      final contact = await FlutterContacts.openExternalPick();

      if (contact == null) {
        print('No contact selected.');
        return null;
      }

      // Retrieve the full contact with phone details
      final fullContact = await FlutterContacts.getContact(contact.id);

      if (fullContact == null || fullContact.phones.isEmpty) {
        print('No phone numbers found for selected contact.');
        return null;
      }

      // Return the first phone number
      return fullContact.phones.first.number;
    } catch (e) {
      print('Error picking contact: $e');
      return null;
    }
  }
}
