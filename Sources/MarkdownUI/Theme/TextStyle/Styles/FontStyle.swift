import Foundation

/// A text style that sets whether the font should be styled with a normal or italic face from its font family.
@available(iOS 15.0, tvOS 15.0, *)
public struct FontStyle: TextStyle {
  private let style: FontProperties.Style

  /// Creates a font style text style.
  /// - Parameter style: The font style.
  public init(_ style: FontProperties.Style) {
    self.style = style
  }

  public func _collectAttributes(in attributes: inout AttributeContainer) {
    attributes.fontProperties?.style = self.style
  }
}
