//
//  CustomListRowView.swift
//  Persons
//
//  Created by Emir Bolat on 18.11.2024.
//

import SwiftUI

/// Component used for information sections. On the left side of the row is label and on the right side is value.
struct CustomListRowView: View {
    
    /// in left
    let rowLabel: String
    
    /// in right
    let rowValue: String
    let isRowValueClickable: Bool
    let onRowValueTapped: (() -> Void)?
    
    init(rowLabel: String,
         rowValue: String,
         isRowValueClickable: Bool = false,
         onRowValueTapped: (() -> Void)? = nil) {
        self.rowLabel = rowLabel
        self.rowValue = rowValue
        self.isRowValueClickable = isRowValueClickable
        self.onRowValueTapped = onRowValueTapped
    }

    var body: some View {
        HStack {
            Text(LocalizedStringKey(rowLabel)).bold()
            Spacer()
            if isRowValueClickable {
                Text(rowValue)
                    .foregroundColor(.blue)
                    .underline()
                    .onTapGesture {
                        onRowValueTapped?()
                    }
            } else {
                Text(rowValue)
            }
        }
    }
}
