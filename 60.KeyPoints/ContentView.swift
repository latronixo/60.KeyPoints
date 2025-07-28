//
//  ContentView.swift
//  60.KeyPoints
//
//  Created by Валентин on 28.07.2025.
//

import SwiftUI

struct User: Codable {
    enum CodingKeys: String, CodingKey {
        case firstName = "first"
        case lastName = "last"
        case age
    }
    
    var firstName: String
    var lastName: String
    var age: Int
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        
        //Декодируем возраст как строку, затем конвертируем в Int
        let ageString = try container.decode(String.self, forKey: .age)
        guard let ageInt = Int(ageString) else {
            throw DecodingError.dataCorruptedError(forKey: .age, in: container, debugDescription: "Age string cannot be converted to Int")
        }
        self.age = ageInt
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.firstName, forKey: .firstName)
        try container.encode(self.lastName, forKey: .lastName)
        try container.encode(String(self.age), forKey: .age)
    }
}

struct ContentView: View {
    var body: some View {
            decoding()
    }
    private func decoding() -> some View {
        let str = """
            {
                "first": "Andrew",
                "last": "Glouberman",
                "age": "13"
            }
            """
        let data = Data(str.utf8)

        do {
            let decoder = JSONDecoder()
            
            let user = try decoder.decode(User.self, from: data)
            return Text("Hi, I'm \(user.firstName) \(user.lastName), \(user.age) years old")
        } catch {
            return Text("Whoops: \(error.localizedDescription)")
        }
        
    }
}

#Preview {
    ContentView()
}
