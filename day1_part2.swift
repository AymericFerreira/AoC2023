import Cocoa

let text = """
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
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

func convertToNumber(s: String) -> Int {
    let stringToNumber = ["one": 1,
                          "two": 2,
                          "three": 3,
                          "four": 4,
                          "five": 5,
                          "six": 6,
                          "seven": 7,
                          "eight": 8,
                          "nine": 9]
    if let digit = Int(s) {
        return digit
    } else {
        if let digit = stringToNumber[s] {
            return digit
        } else {
            print("Invalid value \(s)")
            return 0
        }
    }
}

func findDigitsAndWords(in text: String) -> [Int] {
    let pattern = "\\d+|one|two|three|four|five|six|seven|eight|nine"
    
    do {
        let regex = try NSRegularExpression(pattern: pattern)
        let matches = regex.matches(in: text, options: [], range: NSRange(text.startIndex..., in: text))
        
        
        return matches.compactMap { result in
                    if let range = Range(result.range, in: text) {
                        let substring = String(text[range])
                        return convertToNumber(s: substring)
                    }
                    return nil
                }
    } catch {
        print("Invalid regex: \(error.localizedDescription)")
        return []
    }
}

let fileURL = Bundle.main.url(forResource: "input_1", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: .utf8)

var number = 0

for line in content.split(separator: "\n") {
    let digits = findDigitsAndWords(in: String(line))
    let concatenatedString = digits.map { String($0) }.joined()
    number += getNumber(s: concatenatedString)
}

print(number)
