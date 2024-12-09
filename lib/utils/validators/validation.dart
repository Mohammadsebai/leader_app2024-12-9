
class TValidator {

  /// Empty Text Validation
static String? validateEmptyText(String? fieldName, String? value) {
if (value == null || value.isEmpty) {
return '$fieldName is required.';
}
return null;

}




static String? validateEmail(String? value) {
if (value == null || value.isEmpty) {
return 'Email is required.';
}

// Regular expression for email validation

final emailRegExp = RegExp(r'^[\w-\.]+@[\w-]+\.[\w-]+\.[\w-]{2,}$');


if (!emailRegExp.hasMatch(value)) {
return 'Invalid email address.';
}

return null;
}


static String? validateUniversity({String? value, required List<String> universitiesList}) {
if (value == null || value.isEmpty) {
 return 'University is required.';
}
 if (!universitiesList.contains(value) ) {
  return 'Choose the university using the search method.';
 }
return null;
}

static String? validateDepatment({String? value, required List<String> depatmentNameList}) {
if (value == null || value.isEmpty) {
 return 'Depatment is required.';
}
 if (!depatmentNameList.contains(value) ) {
  return 'Choose the Depatment using the search method.';
 }
return null;
}


static String? validatePassword(String? value) {
if (value == null || value.isEmpty) {
 return 'Password is required.';
}
if (value.length < 6) {
  return 'Password must be at least 6 characters long.';
  }

  // Check for uppercase letters

if (!value.contains (RegExp(r'[A-Z]'))) {
return 'Password must contain at least one uppercase letter.';
}

// Check for numbers
if (!value.contains (RegExp(r'[0-9]'))) {
return 'Password must contain at least one number.';
}

// Check for special characters
if (!value.contains (RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
return 'Password must contain at least one special character.';
}
return null;
}

static String? validatePhoneNumber(String? value) {
if (value == null || value.isEmpty) {
return 'Phone number is required.';
}

// Regular expression for phone number validation (assuming a 10-digit US phone number format)
 final phoneRegExp = RegExp(r'^\d{10}$');
if (!phoneRegExp.hasMatch(value)) {
return 'Invalid phone number format (10 digits required).';
}

return null;
}





///Form Add products


}

