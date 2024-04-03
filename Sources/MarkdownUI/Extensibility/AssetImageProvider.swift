import SwiftUI

/// An image provider that loads images from resources located in an app or a module.
///
/// The following example shows how to configure the asset image provider to load images
/// from the main bundle.
///
/// ```swift
/// Markdown {
///   "![A dog](dog)"
///   "― Photo by André Spieker"
/// }
/// .markdownImageProvider(.asset)
/// ```
@available(iOS 15.0, tvOS 15.0, *)
public struct AssetImageProvider: ImageProvider {
  private let name: (URL) -> String
  private let bundle: Bundle?

  /// Creates an asset image provider.
  /// - Parameters:
  ///   - name: A closure that extracts the image resource name from the URL in the Markdown content.
  ///   - bundle: The bundle where the image resources are located. Specify `nil` to search the app’s main bundle.
  public init(
    name: @escaping (URL) -> String = \.lastPathComponent,
    bundle: Bundle? = nil
  ) {
    self.name = name
    self.bundle = bundle
  }

  public func makeImage(url: URL?) -> some View {
    if let url = url, let image = self.image(url: url) {
      ResizeToFit(idealSize: image.size) {
        Image(platformImage: image)
          .resizable()
      }
    }
  }

  private func image(url: URL) -> PlatformImage? {
    #if canImport(UIKit)
      return UIImage(named: self.name(url), in: self.bundle, with: nil)
    #elseif canImport(AppKit)
      if let bundle, bundle != .main {
        return bundle.image(forResource: self.name(url))
      } else {
        return NSImage(named: self.name(url))
      }
    #endif
  }
}

@available(iOS 15.0, tvOS 15.0, *)
extension ImageProvider where Self == AssetImageProvider {
  /// An image provider that loads images from resources located in an app or a module.
  ///
  /// Use the `markdownImageProvider(_:)` modifier to configure this image provider for a view hierarchy.
  public static var asset: Self {
    .init()
  }
}

#if canImport(UIKit)
  private typealias PlatformImage = UIImage
#elseif canImport(AppKit)
  private typealias PlatformImage = NSImage
#endif

@available(iOS 15.0, tvOS 15.0, *)
extension Image {
  fileprivate init(platformImage: PlatformImage) {
    #if canImport(UIKit)
      self.init(uiImage: platformImage)
    #elseif canImport(AppKit)
      self.init(nsImage: platformImage)
    #endif
  }
}
