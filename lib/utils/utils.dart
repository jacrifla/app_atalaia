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

String? validatePassword(String value) {
  // Verifica se a senha tem pelo menos 8 caracteres
  if (value.length < 8) {
    return 'A senha deve ter pelo menos 8 caracteres';
  }

  // Verifica se a senha contém pelo menos um número
  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return 'A senha deve conter pelo menos um número';
  }

  // Verifica se a senha contém pelo menos um caractere especial
  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    return 'A senha deve conter pelo menos um caractere especial';
  }

  // Verifica se a senha contém pelo menos uma letra
  if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
    return 'A senha deve conter pelo menos uma letra';
  }

  // Se todos os critérios forem atendidos, retorna null
  return null;
}
