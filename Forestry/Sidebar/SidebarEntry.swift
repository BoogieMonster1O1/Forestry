//
//  SidebarEntry.swift
//  Forestry
//
//  Created by Shrish Deshpande on 01/12/23.
//

import Foundation
import SwiftUI

struct SidebarEntry<Content: View>: View {
    var image: Image
    var label: String
    var small: String
    var content: Content
    
    init(image: Image, label: String, small: String, @ViewBuilder content: () -> Content) {
        self.image = image
        self.label = label
        self.small = small
        self.content = content()
    }

    var body: some View {
        NavigationLink {
            content
        } label: {
            HStack(alignment: .center) {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                VStack {
                    HStack {
                        Text(label)
                        Spacer()
                    }
                    HStack {
                        Text(small)
                            .font(.caption2)
                        Spacer()
                    }
                }
            }
        }
    }
}
