import 'package:equatable/equatable.dart';

/// The trailer to show for one particular movie. Is generally linked to MovieDetails.
/// In the future, it might play directly on the thumbnail on the web.
///
/// Parameters:
/// - `name`: The name of the trailer.
/// - `youtubeKey`: The key to be able to show the YouTube video. Normally formatted as http://youtube.com/watch?v=<youtubeKey>
class Trailer extends Equatable {
  final String name;
  final String youtubeKey;

  /// Constructor for `Trailer`.
  const Trailer({
    required this.name,
    required this.youtubeKey,
  });

  @override
  List<Object?> get props => [name, youtubeKey];

  @override
  String toString() => 'Trailer(name: $name, youtubeKey: $youtubeKey)';

  /// Returns a copy of this `Trailer` but with the given fields replaced with new values.
  Trailer copyWith({
    String? name,
    String? youtubeKey,
  }) {
    return Trailer(
      name: name ?? this.name,
      youtubeKey: youtubeKey ?? this.youtubeKey,
    );
  }
}
