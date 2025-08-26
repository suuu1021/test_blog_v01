import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/size.dart';
import 'package:flutter_blog/providers/global/post/post_list_notifier.dart';
import 'package:flutter_blog/providers/global/post/post_write_notifier.dart';
import 'package:flutter_blog/ui/widgets/custom_elavated_button.dart';
import 'package:flutter_blog/ui/widgets/custom_text_area.dart';
import 'package:flutter_blog/ui/widgets/custom_text_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostWriteForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _content = TextEditingController();

  PostWriteForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 게시글 작성 상태 데이터
    // 상태가 변경될 때 마다 build 메서드 다시 호출되어 UI를 업데이트 처리한다.
    final PostWriteModel model = ref.watch(postWriteProvider);

    // 복습 정리
    // 상태 관련 메서드
    // ref.read(provider), ref.watch(provider)

    /// ref.listen(provider, listener) 활용 해보자
    // 1. build 메서드 내부에서 또는 initState 내부에서 사용 가능
    // 2. 상태 변화에 따른 사이드 이팩트 처리
    // 참고 : 주로 네비게이션, 다이얼로그, 스낵바 등 일회성 액션이 필요할 때 사용
    ref.listen(
      postWriteProvider,
      (previous, next) {
        if (next.status == PostWriteStatus.success) {
          // 사이드 이펙트 1 : 성공 메시지 표시
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("게시글 작성 완료"),
              backgroundColor: Colors.green,
            ),
          );
          // 사이드 이펙트 2 : 게시글 목록 새로 고침 (가능한 notifier 간의 통신 자제)
          ref.read(postListProvider.notifier).refreshAfterWriter();
          // 사이드 이펙트 3 : 화면 이동
          Navigator.pop(context);
        } else if (next.status == PostWriteStatus.failure) {
          // 사이드 이펙트 1 : 성공 메시지 표시
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("게시글 작성 실패"),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
    );
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: [
          CustomTextFormField(
            controller: _title,
            hint: "Title",
            validator: (value) =>
                value?.trim().isEmpty == true ? "제목을 입력하세요" : null,
          ),
          const SizedBox(height: smallGap),
          CustomTextArea(
            controller: _content,
            hint: "Content",
            validator: (value) =>
                value?.trim().isEmpty == true ? "내용을 입력하세요" : null,
          ),
          const SizedBox(height: largeGap),
          CustomElevatedButton(
            text: model.status == PostWriteStatus.loading ? "작성중" : "글쓰기",
            click: model.status == PostWriteStatus.loading
                ? null
                : () => _handleSubmit(ref),
          ),
        ],
      ),
    );
  } // end of build

  void _handleSubmit(WidgetRef ref) {
    // 유효성 검사
    // 사용자가 작성한 값 들고 오기
    // 상태 관리 비즈니스 로직 호출 (게시글 작성)
    if (_formKey.currentState!.validate()) {
      final title = _title.text.trim();
      final content = _content.text.trim();
      ref.read(postWriteProvider.notifier).writePost(title, content);
    }
  }
}
