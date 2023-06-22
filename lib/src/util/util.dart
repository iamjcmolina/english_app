class Util {
  static bool isVowel(String value) =>
      ['a', 'e', 'i', 'o', 'u'].contains(value.toLowerCase());

  static bool isConsonant(String value) => !isVowel(value);
}