import Cocoa

let text = """
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
"""

func getNumber(s: String) -> Int{
    let digits = s.filter{ $0.isNumber }
    if let firstDigit = digits.first {
        if let lastDigit = digits.last {
            return Int("\(firstDigit)\(lastDigit)") ?? 0
        }
    }
    return 0
}
let fileURL = Bundle.main.url(forResource: "input_1", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: .utf8)

var number = 0
for line in content.split(separator: "\n") {
    number += getNumber(s: String(line))
}

print(number)
