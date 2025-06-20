import 'package:wondrous_opentelemetry/common_libs.dart';
import 'package:wondrous_opentelemetry/logic/common/animate_utils.dart';
import 'package:wondrous_opentelemetry/logic/data/artifact_data.dart';
import 'package:wondrous_opentelemetry/ui/common/compass_divider.dart';
import 'package:wondrous_opentelemetry/ui/common/controls/app_header.dart';
import 'package:wondrous_opentelemetry/ui/common/controls/app_loading_indicator.dart';
import 'package:wondrous_opentelemetry/ui/common/gradient_container.dart';
import 'package:wondrous_opentelemetry/ui/common/modals/fullscreen_url_img_viewer.dart';
import 'package:wondrous_opentelemetry/ui/common/utils/duration_utils.dart';

part 'widgets/_artifact_image_btn.dart';
part 'widgets/_info_column.dart';

class ArtifactDetailsScreen extends StatefulWidget {
  const ArtifactDetailsScreen({super.key, required this.artifactId});
  final String artifactId;

  @override
  State<ArtifactDetailsScreen> createState() => _ArtifactDetailsScreenState();
}

class _ArtifactDetailsScreenState extends State<ArtifactDetailsScreen> {
  late final _future = artifactLogic.getArtifactByID(widget.artifactId, selfHosted: true);

  @override
  Widget build(BuildContext context) {
    bool hzMode = context.isLandscape;
    return ColoredBox(
      color: $styles.colors.greyStrong,
      child: FutureBuilder<ArtifactData?>(
        future: _future,
        builder: (_, snapshot) {
          final data = snapshot.data;
          late Widget content;
          if (snapshot.hasError || (snapshot.hasData && data == null)) {
            content = _buildError();
          } else if (!snapshot.hasData) {
            content = Center(child: AppLoadingIndicator());
          } else {
            content = hzMode
                ? Row(children: [
                    Expanded(child: _ArtifactImageBtn(data: data!)),
                    Expanded(child: Center(child: SizedBox(width: 600, child: _InfoColumn(data: data)))),
                  ])
                : CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        elevation: 0,
                        leading: SizedBox.shrink(),
                        expandedHeight: context.heightPx * .5,
                        collapsedHeight: context.heightPx * .35,
                        flexibleSpace: _ArtifactImageBtn(data: data!),
                      ),
                      SliverToBoxAdapter(child: _InfoColumn(data: data)),
                    ],
                  );
          }

          return Stack(children: [
            content,
            AppHeader(isTransparent: true),
          ]);
        },
      ),
    );
  }

  Animate _buildError() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Icon(
          Icons.warning_amber_outlined,
          color: $styles.colors.accent1,
          size: $styles.insets.lg,
        )),
        Gap($styles.insets.xs),
        SizedBox(
          width: $styles.insets.xxl * 3,
          child: Text(
            $strings.artifactDetailsErrorNotFound(widget.artifactId),
            style: $styles.text.body.copyWith(color: $styles.colors.offWhite),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ).maybeAnimate().fadeIn();
  }
}
