//
//  File.swift
//
//
//  Created by Yudong Hou on 2024/4/23.
//

import SwiftDiagnostics

// MARK: - DictWithVarNameMacroError
enum DictWithVarNameMacroError: Int {

  case acceptsOnlyIdentifierExpressionSyntax

  case emptyInput

  case duplicateIdentifiers

}

// MARK: DiagnosticMessage
extension DictWithVarNameMacroError: DiagnosticMessage {

  var message: String {
    switch self {
    case .acceptsOnlyIdentifierExpressionSyntax:
      return "#dict accepts only 'variable names', do not input literals such as String literal, Integer literal."

    case .emptyInput:
      return "The input of #dict is empty."

    case .duplicateIdentifiers:
      return "There are duplicate identifiers in the input, this makes no difference to the expanded code."
    }
  }

  var diagnosticID: SwiftDiagnostics.MessageID {
    MessageID(domain: "tw.dcard.dcardMacro", id: "\(rawValue)")
  }

  var severity: SwiftDiagnostics.DiagnosticSeverity { .error }

}
