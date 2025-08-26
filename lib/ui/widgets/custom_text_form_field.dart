import 'package:flutter/material.dart';

// 재사용 가능한 위젯으로 설계하기 위함.
// 맞춤 기능을 추가 하기 위해 재설계 한다.
class CustomTextFormField extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final TextEditingController controller;
  final String? initValue; // 초기 값 (CustomTextFormField - 글 쓰기, 글 수정)
  // CustomTextFormField --> 추가 (String) {... 구현부 정의}
  final String? Function(String?)? validator;

  const CustomTextFormField({
    Key? key,
    required this.hint,
    this.obscureText = false,
    required this.controller,
    this.initValue = "",
    this.validator, // 선택적 매개 변수 (옵션 값) - 유효성 검사
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (initValue != null && initValue!.isNotEmpty) {
      controller.text = initValue!;
    }
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: "Enter $hint",
        enabledBorder: OutlineInputBorder(
          // 3. 기본 TextFormField 디자인
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          // 4. 손가락 터치시 TextFormField 디자인
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          // 5. 에러발생시 TextFormField 디자인
          borderRadius: BorderRadius.circular(20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          // 5. 에러가 발생 후 손가락을 터치했을 때 TextFormField 디자인
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
