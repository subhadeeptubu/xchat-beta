import 'dart:math';

String generateRoomId() {
  const characters =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  Random random = Random();

  String randomString(int length) => String.fromCharCodes(
        Iterable.generate(length,
            (_) => characters.codeUnitAt(random.nextInt(characters.length))),
      );

  String roomId =
      '${randomString(4)}-${randomString(4)}-${randomString(4)}-${randomString(4)}';
  return roomId;
}
