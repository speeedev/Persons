//
//  PersonDetailView.swift
//  Persons
//
//  Created by Emir Bolat on 18.11.2024.
//

import MapKit
import SwiftUI

struct PersonDetailView: View {
    // MARK: - Properties
    let person: PersonModel
    @State private var personLocation: CLLocationCoordinate2D
    @State private var showError = false
    @State private var currentError: ValidationError?

    // MARK: - Initialization
    init(person: PersonModel) {
        self.person = person

        do {
            let coordinates = try PersonDetailView.validateCoordinates(
                lat: person.address.geo.lat,
                lng: person.address.geo.lng
            )
            _personLocation = State(initialValue: coordinates)
        } catch {
            _personLocation = State(initialValue: .init())
            showError.toggle()
            currentError = .invalidCoordinates
        }
    }

    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                personalInformationSection
                companyInformationSection
                addressInformationSection
                mapSection
            }
            .listStyle(.grouped)
            .navigationTitle("personDetailsTitle")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .alert("errorTitle", isPresented: $showError, presenting: currentError) {
                _ in
                Button("alertButton", role: .cancel) {}
            } message: { error in
                Text(LocalizedStringKey(error.localizedDescription))
            }
        }
    }

    // MARK: - Sections
    private var personalInformationSection: some View {
        Section(header: SectionHeaderView(title: "personalInformationSectionHeader")) {
            CustomListRowView(
                rowLabel: "personName",
                rowValue: "\(person.name) (\(person.username))"
            )

            CustomListRowView(
                rowLabel: "emailAddress",
                rowValue: person.email,
                isRowValueClickable: true,
                onRowValueTapped: handleEmailTap
            )

            CustomListRowView(
                rowLabel: "phoneNumber",
                rowValue: person.phone,
                isRowValueClickable: true,
                onRowValueTapped: handlePhoneTap
            )
        }
    }

    private var companyInformationSection: some View {
        Section(header: SectionHeaderView(title: "companyInformationSectionHeader")) {
            CustomListRowView(
                rowLabel: "companyName",
                rowValue: person.company.name
            )

            CustomListRowView(
                rowLabel: "catchPhrase",
                rowValue: person.company.catchPhrase
            )
        }
    }

    private var addressInformationSection: some View {
        Section(header: SectionHeaderView(title: "addressInformationSectionHeader")) {
            CustomListRowView(
                rowLabel: "street",
                rowValue: person.address.street
            )

            CustomListRowView(
                rowLabel: "city",
                rowValue: person.address.city
            )

            CustomListRowView(
                rowLabel: "zipcode",
                rowValue: person.address.zipcode
            )
        }
    }

    private var mapSection: some View {
        Section(header: SectionHeaderView(title: "mapSectionHeader")) {
            Map(bounds: .init(minimumDistance: 100000)) {
                Marker("", coordinate: personLocation)
            }
            .frame(height: 300)
        }
    }

    // MARK: - Actions
    private func handleEmailTap() {
        do {
            try ValidationHelper.openEmail(person.email)
        } catch {
            showError(error as? ValidationError ?? .invalidEmailURL)
        }
    }

    private func handlePhoneTap() {
        do {
            try ValidationHelper.openPhone(person.phone)
        } catch {
            showError(error as? ValidationError ?? .invalidPhoneURL)
        }
    }

    private func showError(_ error: ValidationError) {
        currentError = error
        showError = true
    }

    // MARK: - Helper Methods
    static func validateCoordinates(lat: String, lng: String) throws
        -> CLLocationCoordinate2D
    {
        guard let latitude = Double(lat),
            let longitude = Double(lng),
            (-90...90).contains(latitude),
            (-180...180).contains(longitude)
        else {
            throw ValidationError.invalidCoordinates
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

// MARK: - Supporting Views
struct SectionHeaderView: View {
    let title: String

    var body: some View {
        Text(LocalizedStringKey(title))
            .font(.headline)
    }
}
