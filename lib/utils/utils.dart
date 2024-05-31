bool isValidEmail(String value) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(value);
}

bool isValidPhoneNumber(String phoneNumber) {
  // Remove todos os caracteres que não sejam dígitos
  final numericPhone = phoneNumber.replaceAll(RegExp(r'\D'), '');

  // Verifica se o número de telefone tem exatamente 11 dígitos (incluindo o DDD)
  return numericPhone.length == 11;
}

String toCapitalizeWords(String input) {
  if (input.isEmpty) return '';

  List<String> words = input.split(' ');
  List<String> capitalizedWords = words.map((word) {
    if (word.isNotEmpty) {
      return '${word[0].toUpperCase()}${word.substring(1)}';
    } else {
      return '';
    }
  }).toList();

  return capitalizedWords.join(' ');
}

bool isValidMacAddress(String mac) {
  final RegExp macRegExp = RegExp(
    r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$|^([0-9A-Fa-f]{4}\.[0-9A-Fa-f]{4}\.[0-9A-Fa-f]{4})$|^([0-9A-Fa-f]{12})$',
  );
  return macRegExp.hasMatch(mac);
}
