import 'dart:collection';

import 'package:wondrous_opentelemetry/common_libs.dart';
import 'package:wondrous_opentelemetry/logic/artifact_api_service.dart';
import 'package:wondrous_opentelemetry/logic/common/http_client.dart';
import 'package:wondrous_opentelemetry/logic/data/artifact_data.dart';

class ArtifactAPILogic {
  final HashMap<String, ArtifactData?> _artifactCache = HashMap();

  ArtifactAPIService get service => GetIt.I.get<ArtifactAPIService>();

  /// Returns artifact data by ID. Returns null if artifact cannot be found. */
  Future<ArtifactData?> getArtifactByID(String id, {bool selfHosted = false}) async {
    if (_artifactCache.containsKey(id)) return _artifactCache[id];
    ServiceResult<ArtifactData?> result =
        (await (selfHosted ? service.getSelfHostedObjectByID(id) : service.getMetObjectByID(id)));
    if (!result.success) throw $strings.artifactDetailsErrorNotFound(id);
    ArtifactData? artifact = result.content;
    return _artifactCache[id] = artifact;
  }
}
