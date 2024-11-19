//
//  PersonCardView.swift
//  Persons
//
//  Created by Emir Bolat on 18.11.2024.
//

import SwiftUI

/// Card view for Person. Contains Person name and email address.
struct PersonCardView: View {
    let person: PersonModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.gray.opacity(0.1))
                // UIScreen.main.bounds.width kaldırıldı
                .frame(height: 80)
                .shadow(radius: 10, x: 0, y: 10)
            
            HStack(alignment: .center, spacing: 0) {
                VStack {
                    VStack(alignment: .leading) {
                        Text(person.name)
                            .font(.headline)
                        Text("\(person.email.lowercased())")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding()
        }
        // Bu satırı kaldırdık
        // .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
    }
}
#Preview {
    PersonCardView(
        person: PersonModel(
            id: 1, name: "Emir", username: "speedev", email: "emirbolat.com",
            address: Address(
                street: "cadde", suite: "suite", city: "sehir",
                zipcode: "34400", geo: Geo(lat: "34400", lng: "5000")),
            phone: "05527218874", website: "emirbolat.com",
            company: Company(
                name: "Veripark", catchPhrase: "catchblabla", bs: "bsbsbsbs")))
}
