//
//  AddRestourantView.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import SwiftUI
import SwiftData

struct AddRestourantView<VM: AddRestaurantVMProtocol>: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel : VM
    var body: some View {
        ZStack {
            Form {
                Text("Restourant Name").font(.title3)
                TextField("Enter Name",text: self.$viewModel.restaurantName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Picker("Restaurant Type", selection: self.$viewModel.selectedRestaurantTypeIndex) {
                    Text("Select Restaurant Type").font(.title3).tag(nil as Restaurant?)
                    ForEach(0 ..< self.viewModel.restaurantTypes.count) { index in
                        Text(self.viewModel.restaurantTypes[index].value)
                            .tag(nil as Restaurant?)
                            .foregroundColor(.black)
                    }
                }
                .pickerStyle(.menu)
            }
            .toolbar(content: {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("done") {
                        self.viewModel.saveData()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(self.viewModel.title)
        }
    }
}
