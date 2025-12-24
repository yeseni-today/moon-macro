// The Swift Programming Language
// https://docs.swift.org/swift-book

/// A macro that produces dict with variable name
/// source code that generated the value. For example,
///
///     #dict(a, b, c)
///
/// produces a tuple `["a": a, "b": b, "c": c]`.
@freestanding(expression)
public macro dict(_ value: Any...) -> [String: Any] = #externalMacro(module: "MoonMacroMacros", type: "DictWithVarNameMacro")

/// A macro that produces pretty info with variable name.
/// Generate string with PrettyStringConverible.
/// source code that generated the value. For example,
///
///     #pretty(a, code, result, user, user.id)
///     produce: {
///        a = 17,
///        code = Optional(200),
///        result = nil,
///        user = User(id: 9848D997-3CA2-4C8E-BE0F-3F475BB92410, age: 18),
///        user.id = 9848D997-3CA2-4C8E-BE0F-3F475BB92410
///      }
///
@freestanding(expression)
public macro pretty(_ value: Any?...) -> String = #externalMacro(module: "MoonMacroMacros", type: "PrettyInfoMacro")
