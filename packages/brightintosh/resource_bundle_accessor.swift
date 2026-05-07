import Foundation

private final class BundleFinder {}

extension Foundation.Bundle {
    static let module: Bundle = {
        let bundleName = "KeyboardShortcuts_KeyboardShortcuts"
        let candidates: [URL?] = [
            Bundle.main.resourceURL,
            Bundle(for: BundleFinder.self).resourceURL,
            Bundle.main.bundleURL,
        ]
        for candidate in candidates {
            if let url = candidate?.appendingPathComponent("\(bundleName).bundle"),
               let bundle = Bundle(url: url) {
                return bundle
            }
        }
        Swift.fatalError("could not load \(bundleName).bundle")
    }()
}
