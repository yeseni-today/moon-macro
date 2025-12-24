//
//  File.swift
//
//
//  Created by Yudong Hou on 2024/4/23.
//

import Foundation

public enum MoonMacroUtil {

  public static func prettyText(dict any: [String: Any?]) -> String {
    if let pretty = any as? PrettyStringConverible {
      return pretty.prettyDescription
    }

    let dict = any as [String: Any?]
    return dict.prettyString
  }

}

extension Dictionary where Key == String {

  fileprivate var prettyString: String {
    if isEmpty { return "{}" }
    let content = map {
      "\($0.key) = \(str($0.value))"
        .replacingOccurrences(of: "\n", with: "\\n")
    }
    .sorted(by: <)
    .joined(separator: ", \n    ")
    return "{\n    \(content)\n}"
  }

}

extension Optional: PrettyStringConverible {

  public var prettyDescription: String {
    switch self {
    case .none: return "nil"
    case let .some(wrapped):
      if let pretty = wrapped as? PrettyStringConverible {
        return pretty.prettyDescription
      }
      return "\(wrapped)"
    }
  }

}

private func str(_ any: Any?) -> String {
  if any == nil {
    return "nil"
  }

  if let pretty = any as? PrettyStringConverible {
    return pretty.prettyDescription
  }

  return "\(String(describing: any))"
}
