import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(MoonMacroMacros)
import MoonMacroMacros

let testMacros: [String: Macro.Type] = [
  "dict": DictWithVarNameMacro.self,
  "pretty": PrettyInfoMacro.self,
]
#endif

final class MacroTests: XCTestCase {

  func testDictMacro() throws {
    #if canImport(MoonMacroMacros)
    assertMacroExpansion(
      """
      #dict(a, b, user.id)
      """,
      expandedSource: """
      ["a": a as Any, "b": b as Any, "user.id": user.id as Any]
      """,
      macros: testMacros
    )
    #else
    throw XCTSkip("macros are only supported when running tests for the host platform")
    #endif
  }

  func testPrettyMacro() throws {
    #if canImport(MoonMacroMacros)
    assertMacroExpansion(
      """
      #pretty(a, user.id)
      """,
      expandedSource: """
      MoonMacroUtil.prettyText(dict: ["a": a, "user.id": user.id])
      """,
      macros: testMacros
    )
    #else
    throw XCTSkip("macros are only supported when running tests for the host platform")
    #endif
  }

}
