//
//  DatePickerView.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import Foundation
import SwiftUI
struct DatePickerView: View {
    @Binding var selectedDate: Date
    @Binding var isDatePickerShown: Bool

    var body: some View {
        VStack {
            DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

            Button("Done") {
                isDatePickerShown = false
            }
            .padding()
        }
        .padding()
    }
}
