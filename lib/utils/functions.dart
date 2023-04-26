import 'package:flutter/cupertino.dart';
import 'package:tipme_front/widgets/text_field_dialog_widget.dart';

/// Alert Message 호출 함수
void showAlertMessage(BuildContext context, String message) {
  showCupertinoDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return CupertinoActionSheet(
        message: Text(
          message,
          style: const TextStyle(
            fontSize: 15,
            color: CupertinoColors.destructiveRed,
          ),
        ),
      );
    },
  );
}

/// TextField Dialog 호출 함수
Future<String?> showTextFieldDialog({
  required BuildContext context,
  required String message,
  String placeholder = "",
}) async {
  final String? input = await showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return TextFieldDialogWidget(
        message: message,
        placeholder: placeholder,
      );
    },
  );
  return input;
}

/// 이름 유효성 체크 함수
bool isValidName(String name) {
  // 3~8 자 이내
  if (name.length < 3 || name.length > 8) return false;

  RegExp reg = RegExp(r"[^ㄱ-ㅎ가-힣0-9a-zA-Z,.()-]+"); //공백 불가능
  if (reg.hasMatch(name)) return false;

  return true;
}

/// 가게 이름 유효성 체크 함수
bool isValidStoreName(String name) {
  // 1~12자 이내
  if (name.isEmpty || name.length > 12) return false;

  RegExp reg = RegExp(r"[^ㄱ-ㅎ가-힣0-9a-zA-Z,.()-]/s+"); //공백 가능 \s
  if (reg.hasMatch(name)) return false;

  return true;
}
