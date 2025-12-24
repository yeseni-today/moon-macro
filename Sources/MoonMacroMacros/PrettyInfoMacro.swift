import SwiftCompilerPlugin
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import Foundation

// MARK: - PrettyWithVarNameMacro
/// Implementation of the `stringify` macro, which takes an expression
/// of any type and produces a tuple containing the value of that expression
/// and the source code that produced the value. For example
///
///     #stringify(x + y)
///
///  will expand to
///
///     (x + y, "x + y")
public struct PrettyInfoMacro: ExpressionMacro {

  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> ExprSyntax {
    guard !node.arguments.isEmpty else {
      let diagnose: Diagnostic = .init(
        node: node._syntaxNode,
        message: DictWithVarNameMacroError.emptyInput
      )
      context.diagnose(diagnose)
      throw DiagnosticsError(diagnostics: [diagnose])
    }

    print("[PrettyInfoMacro] Log Node: \(node)")

    var usedExpressions: Set<String> = []
    var elements = [DictionaryElementSyntax]()
    let enumerated = node.arguments.enumerated()

    // a, b, c
    for (index, element) in enumerated {
      let identifierText: String = self.identifierText(for: element)

      guard !usedExpressions.contains(identifierText) else {
        let diagnose = Diagnostic(
          node: element._syntaxNode,
          message: DictWithVarNameMacroError.duplicateIdentifiers
        )
        context.diagnose(diagnose)
        throw DiagnosticsError(diagnostics: [diagnose])
      }

      let trailingComma: TokenSyntax? = index == node.arguments.count - 1 ? nil : .commaToken()
      elements.append(
        DictionaryElementSyntax(
          key: StringLiteralExprSyntax(content: identifierText),
          value: element.expression,
          trailingComma: trailingComma
        )
      )

      usedExpressions.insert(identifierText)
    }

    let dictionaryLiteral = DictionaryExprSyntax(
      content: .elements(DictionaryElementListSyntax(elements))
    )

    return ExprSyntax("MoonMacroUtil.prettyText(dict: \(dictionaryLiteral))")
  }

  /// We accept only `IdentifierExprSyntax` in order to take the identifier as "key name" of the dictionary
  /// Example:
  /// let a = "Foo"
  ///     ^ this is an identifier
  ///
  ///     #dictionaryLiteralShorthand("Foo")
  static func identifierText(for element: LabeledExprListSyntax.Element) -> String {
    guard element.expression.is(DeclReferenceExprSyntax.self) else {
      let characters = CharacterSet(charactersIn: ",").union(.whitespacesAndNewlines)
      return element.description.trimmingCharacters(in: characters)
    }
    let idSyntanx = element.expression.cast(DeclReferenceExprSyntax.self)
    return idSyntanx.baseName.text
  }

}
