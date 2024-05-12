//
//  AddReviewView.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import SwiftUI

struct AddReviewView: View {
    @State var rating: Int = 0
    @State var date: Date = Date()
    @State var notes: String = ""
    @State private var isDatePickerShown = false
    @Environment(\.presentationMode) var presentationMode
    var didTapDoneButton: (Int, Date, String)->()
    var body: some View {
        ZStack {
            Form {
                Text("Enter Your Rview")
                TextField("Enter your review", text: $notes)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                StarRatingView(rating: $rating)
                Button(action: {
                    isDatePickerShown = true
                }) {
                    Text("Select Date")
                }
                .padding()
                Text("Selected Date: \(date.formatDate)")
                    .padding()
            }
            .toolbar(content: {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("done") {
                        self.didTapDoneButton(rating, date, notes)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            })
            .navigationTitle("Add Review")
        }
        .sheet(isPresented: $isDatePickerShown) {
            DatePickerView(selectedDate: $date, isDatePickerShown: $isDatePickerShown)
        }
    }
}

#Preview {
    AddReviewView(didTapDoneButton: {_,_,_ in})
}
