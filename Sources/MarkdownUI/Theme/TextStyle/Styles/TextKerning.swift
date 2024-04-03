import Foundation

/// A text style that sets the spacing, or kerning, between the characters of the text.
@available(iOS 15.0, tvOS 15.0, *)
public struct TextKerning: TextStyle {
  private let kern: CGFloat?

  /// Creates a text kerning text style.
  /// - Parameter kern: The spacing to use between individual characters in the text.
  public init(_ kern: CGFloat?) {
    self.kern = kern
  }

  public func _collectAttributes(in attributes: inout AttributeContainer) {
    attributes.kern = self.kern
  }
}
