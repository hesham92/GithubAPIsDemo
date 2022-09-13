import Foundation
extension String {
    func base64Decode() -> String {
        guard let encodedData = Data(base64Encoded: self) else {
            assertionFailure("string to decode not found")
            return ""
        }
        
        guard let decodedString = String(data: encodedData, encoding: .utf8) else {
            assertionFailure("decoding is failed")
            return ""
        }
        return  decodedString
    }
}
