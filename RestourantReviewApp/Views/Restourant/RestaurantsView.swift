//
//  RestourantsView.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import SwiftUI
import SwiftData

struct RestourantView: View {
    @ObservedObject var viewModel: RestaurantViewVM
    init(viewModel: RestaurantViewVM) {
        self.viewModel = viewModel
    }
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Sort By:")
                    .padding(.vertical, 5)
                    .padding(.horizontal, 16)
                HStack(spacing: 5) {
                    ForEach(SortOption.allCases, id: \.rawValue) { item in
                        SortOptionPill(sortOption: item, selectedSortOption: self.$viewModel.selectedSortOption) {
                            self.viewModel.selectedSortOption = item
                            self.viewModel.fetchData()
                        }
                    }
                }
                .padding(.horizontal, 16)
                Spacer()
                restaurantView
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Foodie")
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        AddRestaurantBuilder().buildForAdd(modelContext: self.viewModel.modelContext, delegate: self.viewModel)
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }
    private var restaurantView: some View {
        VStack(alignment: .center) {
            if self.viewModel.restaurants.count > 0 {
                restaurantListView
            } else {
                EmptyListView(title: "No Data!")
            }
        }
    }
    private var restaurantListView: some View {
        List {
            ForEach( self.viewModel.restaurants) { item in
                ProcessRestourantView(restaurant: item, modelContext: self.viewModel.modelContext, delegate: self.viewModel, reviewUpdateDelegate: self.viewModel) { restaurant in
                    self.deleteItem(item: restaurant)
                }
            }
        }
    }
    
    private func deleteItem(item: Restaurant) {
        withAnimation {
            self.viewModel.deleteItem(item: item)
        }
    }
}

struct ProcessRestourantView: View {
    enum Action {
        case view
        case edit
    }
    @State private var isActive = false
    @State private var action: Action?
    let restaurant: Restaurant
    var modelContext: ModelContext
    var delegate: AddRestaurantVMDelegate
    var reviewUpdateDelegate: ReviewVMDelegate
    var didTapDeleteButton : (Restaurant) -> ()
    
    var body: some View {
        NavigationLink(destination: destination, isActive: $isActive) {
            RestourantListItemView(restaurant: self.restaurant)
        }
        .swipeActions() {
            Button("Delete") {
                didTapDeleteButton(self.restaurant)
            }.tint(.red)
            Button("Edit") {
                action = .edit
                isActive = true
            }.tint(.blue)
        }
        .onChange(of: isActive) {
            if !$0 {
                action = nil
            }
        }
    }
    
    @ViewBuilder
    private var destination: some View {
        if case .edit = action {
            AddRestaurantBuilder().buildForEdit(restaurant: self.restaurant, modelContext: self.modelContext, delegate: self.delegate)
        } else {
            ReviewViewBuilder().build(restaurant: self.restaurant, delegate: self.reviewUpdateDelegate)
        }
    }
}
