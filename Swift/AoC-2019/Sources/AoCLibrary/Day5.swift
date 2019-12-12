import IntCode

public enum Day5 {
    public static func runDiagnostic(intCode: IntCode, input: Int) -> Int {
        var intCode = intCode
        intCode.run(input)
        return intCode.diagnostics.last ?? 0
    }
}
