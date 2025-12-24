import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

// MARK: - MacroPlugin
@main
struct MoonMacroPlugin: CompilerPlugin {

  let providingMacros: [Macro.Type] = [
    DictWithVarNameMacro.self,
    PrettyInfoMacro.self,
  ]

}
