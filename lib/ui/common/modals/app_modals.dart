import 'package:wondrous_opentelemetry/common_libs.dart';
import 'package:wondrous_opentelemetry/ui/common/themed_text.dart';

Future<bool?> showModal(BuildContext context, {required Widget child}) async {
  return await showModalBottomSheet(
        context: context,
        backgroundColor: $styles.colors.greyStrong,
        builder: (_) => child,
      ) ??
      false;
}

class LoadingModal extends StatelessWidget {
  const LoadingModal({super.key, this.title, this.msg, this.child});
  final String? title;
  final String? msg;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return _BaseContentModal(
      title: title,
      msg: msg,
      buttons: const [],
      child: child,
    );
  }
}

class OkModal extends StatelessWidget {
  const OkModal({super.key, this.title, this.msg, this.child});
  final String? title;
  final String? msg;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return _BaseContentModal(
      title: title,
      msg: msg,
      buttons: [
        AppBtn.from(
            text: $strings.appModalsButtonOk,
            expand: true,
            isSecondary: true,
            onPressed: () => Navigator.of(context).pop(true)),
      ],
      child: child,
    );
  }
}

class OkCancelModal extends StatelessWidget {
  const OkCancelModal({super.key, this.title, this.msg, this.child});
  final String? title;
  final String? msg;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return _BaseContentModal(
      title: title,
      msg: msg,
      buttons: [
        AppBtn.from(
            text: $strings.appModalsButtonOk,
            expand: true,
            isSecondary: true,
            onPressed: () => Navigator.of(context).pop(true)),
        Gap($styles.insets.xs),
        AppBtn.from(
            text: $strings.appModalsButtonCancel, expand: true, onPressed: () => Navigator.of(context).pop(false)),
      ],
      child: child,
    );
  }
}

/// Allows for a title, msg and body widget
class _BaseContentModal extends StatelessWidget {
  final String? title;
  final String? msg;
  final Widget? child;
  final List<Widget> buttons;

  const _BaseContentModal({this.title, this.msg, required this.buttons, this.child});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Center(
        child: SizedBox(
          width: $styles.sizes.maxContentWidth3,
          child: Padding(
            padding: EdgeInsets.all($styles.insets.lg),
            child: LightText(
              child: SeparatedColumn(
                mainAxisSize: MainAxisSize.min,
                separatorBuilder: () => Gap($styles.insets.md),
                children: [
                  if (title != null) Text(title!, style: $styles.text.h2),
                  if (child != null) child!,
                  if (msg != null) Text(msg!, style: $styles.text.body),
                  Gap($styles.insets.md),
                  Column(children: buttons.map((e) => e).toList())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
