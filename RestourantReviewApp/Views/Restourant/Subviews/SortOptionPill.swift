//
//  SortOptionPill.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import SwiftUI

enum SortOption: String, CaseIterable {
    case name = "Name"
    case avgRating = "Avg Rating"
    case mostRecentReview = "Most Recent Review"
}

struct SortOptionPill: View {
    var sortOption: SortOption
    @Binding var selectedSortOption: SortOption
    var didSelect: () -> ()
    var body: some View {
        Button {
            didSelect()
            selectedSortOption = sortOption
        } label: {
            let isSelected = sortOption == selectedSortOption
            Text(sortOption.rawValue)
                .font(.caption)
                .padding(10)
                .background(
                    Capsule()
                        .fill(isSelected ? Color.gray : Color.gray.opacity(0.5))
                )
                .foregroundColor(isSelected ? .white : .black)
        }
    }
}
