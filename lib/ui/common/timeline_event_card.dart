import 'package:wondrous_opentelemetry/common_libs.dart';
import 'package:wondrous_opentelemetry/logic/common/string_utils.dart';
import 'package:wondrous_opentelemetry/ui/common/themed_text.dart';

class TimelineEventCard extends StatelessWidget {
  const TimelineEventCard({super.key, required this.year, required this.text, this.darkMode = false});
  final int year;
  final String text;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Padding(
        padding: EdgeInsets.only(bottom: $styles.insets.sm),
        child: DefaultTextColor(
          color: darkMode ? Colors.white : Colors.black,
          child: Container(
            color: darkMode ? $styles.colors.greyStrong : $styles.colors.offWhite,
            padding: EdgeInsets.all($styles.insets.sm),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  /// Date
                  SizedBox(
                    width: 75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${year.abs()}', style: $styles.text.h3.copyWith(fontWeight: FontWeight.w400, height: 1)),
                        Text(StringUtils.getYrSuffix(year), style: $styles.text.bodySmall),
                      ],
                    ),
                  ),

                  /// Divider
                  Container(width: 1, color: darkMode ? Colors.white : $styles.colors.black),

                  Gap($styles.insets.sm),

                  /// Text content
                  Expanded(
                    child: Focus(child: Text(text, style: $styles.text.body)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
