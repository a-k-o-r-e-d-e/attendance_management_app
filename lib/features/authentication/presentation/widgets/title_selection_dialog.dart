import 'package:attendance_management_app/features/authentication/presentation/providers/title_provider.dart';
import 'package:attendance_management_app/shared/utilities/string_utils.dart';
import 'package:attendance_management_app/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/utilities/size_utils.dart';
import '../providers/states/user_type_state.dart';

class SelectTitleDialog extends ConsumerWidget {
  static show(BuildContext context, WidgetRef ref) {
    showDialog(
        context: context,
        barrierColor: Colors.white70,
        barrierDismissible: true,
        builder: (context) {
          return SelectTitleDialog._(
            ref: ref,
          );
        });
  }

  const SelectTitleDialog._({Key? key, required this.ref}) : super(key: key);

  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TitleEnum title = ref.watch(titleTypeProvider);
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.white70,
      insetPadding: EdgeInsets.symmetric(
          horizontal: widthSizer(24, context), vertical: 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Color(0x26AEAEAE),
                  blurRadius: 20,
                  offset: Offset(0, -8)),
              BoxShadow(
                  color: Color(0x26AEAEAE),
                  blurRadius: 20,
                  offset: Offset(0, 8))
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              title: "Title",
              size: 20,
              weight: FontWeight.w500,
            ),
            ListView.separated(
                shrinkWrap: true,
                controller: ScrollController(),
                itemCount: TitleEnum.values.length - 1,
                separatorBuilder: (_, __) => const SizedBox(height: 0),
                itemBuilder: (context, index) => RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      activeColor: const Color(0xFF25314C),
                      title: CustomText(
                        title: StringUtils.capitalize(
                            TitleEnum.values[index + 1].name),
                        size: 16,
                        weight: FontWeight.w500,
                      ),
                      value: TitleEnum.values[index + 1],
                      groupValue: title,
                      onChanged: (value) {
                        ref.read(titleTypeProvider.notifier).setTitle(value!);
                      },
                    )),
          ],
        ),
      ),
    );
  }
}
