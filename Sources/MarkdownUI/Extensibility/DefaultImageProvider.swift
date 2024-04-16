import SwiftUI

/// The default image provider, which loads images from the network.
@available(iOS 15.0, tvOS 15.0, *)
public struct DefaultImageProvider: ImageProvider {
  public func makeImage(url: URL?) -> some View {
      EmptyView() // removed bcuz uneeded
  }
}

@available(iOS 15.0, tvOS 15.0, *)
extension ImageProvider where Self == DefaultImageProvider {
  /// The default image provider, which loads images from the network.
  ///
  /// Use the `markdownImageProvider(_:)` modifier to configure this image provider for a view hierarchy.
  public static var `default`: Self {
    .init()
  }
}
