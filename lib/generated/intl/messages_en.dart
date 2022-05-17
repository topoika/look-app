// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "continue_to_get_confirmation_code":
            MessageLookupByLibrary.simpleMessage(
                "Continue to get Confirmation code to your number"),
        "enter_your_phone_number":
            MessageLookupByLibrary.simpleMessage("Enter Your Phone Number"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "otp_cant_be_less_than_six_characters":
            MessageLookupByLibrary.simpleMessage(
                "OTP can\'t be less than 6 characters"),
        "phone_number": MessageLookupByLibrary.simpleMessage("Phone Number"),
        "please_enter_a_correct_phone_number":
            MessageLookupByLibrary.simpleMessage(
                "Please enter correct 10 digits of mobile number")
      };
}
