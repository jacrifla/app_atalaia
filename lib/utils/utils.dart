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
