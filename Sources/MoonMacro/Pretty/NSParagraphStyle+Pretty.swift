//
//  File.swift
//
//
//  Created by Yudong Hou on 2024/4/23.
//

import Foundation

#if canImport(AppKit)
import AppKit
#endif

#if canImport(UIKit)
import UIKit
#endif

// MARK: - NSParagraphStyle + PrettyStringConverible
extension NSParagraphStyle: PrettyStringConverible {

  public var prettyDescription: String {
    return description.replacingOccurrences(of: "\n", with: "\\n")
  }

}
