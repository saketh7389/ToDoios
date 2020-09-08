// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let todoModel = try? newJSONDecoder().decode([TodoModel].self, from: jsonData)

import Foundation

// MARK: - TodoModelElement
struct TodoModel: Codable {
    let userID, id: Int?
    let title: String?
    let completed: Bool?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}
extension String {
    public var trimmed: String {
        return String(self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
    }
}
