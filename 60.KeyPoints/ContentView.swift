//
//  ContentView.swift
//  60.KeyPoints
//
//  Created by Валентин on 28.07.2025.
//

import SwiftUI

struct User: Codable {
    enum ZZZCodingKeys: CodingKey {
        case firstName
    }
    
    var firstName: String
    var lastName: String
}

struct ContentView: View {
    var body: some View {
        VStack {
            decoding()
        }
        .padding()
    }
    private func decoding() -> some View {
        let str = """
            {
                "first": "Andrew",
                "last": "Glouberman"
            }
            """
        let data = Data(str.utf8)

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let user = try decoder.decode(User.self, from: data)
            return Text("Hi, I'm \(user.firstName) \(user.lastName)")
        } catch {
            return Text("Whoops: \(error.localizedDescription)")
        }
        
    }
}

#Preview {
    ContentView()
}
