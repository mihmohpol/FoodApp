import SwiftUI

extension Image {
    /// Проверяет, существует ли изображение с указанным именем в Assets.xcassets
    static func exists(named: String) -> Bool {
        UIImage(named: named) != nil
    }
}
