//
//  Logo.swift
//  Twitter-NC1
//
//  Created by Edgar Ernesto Vergara Montiel on 16/11/23.
//

import SwiftUI

struct HeaderLogo: View {
    var body: some View {
        Text("X")
            .font(.largeTitle.bold())
            .accessibilityAddTraits(.isHeader)
            .accessibilityLabel("X Logo")
    }
}

#Preview {
    HeaderLogo()
}
