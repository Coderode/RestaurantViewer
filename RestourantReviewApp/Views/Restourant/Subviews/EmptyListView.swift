//
//  EmptyListView.swift
//  RestourantReviewApp
//
//  Created by Sandeep kushwaha on 12/05/24.
//

import SwiftUI

struct EmptyListView: View {
    var title: String
    var body: some View {
        Text(title)
    }
}

#Preview {
    EmptyListView(title: "no data")
}
