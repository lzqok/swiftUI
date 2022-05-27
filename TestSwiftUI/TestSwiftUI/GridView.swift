//
//  GridView.swift
//  TestSwiftUI
//
//  Created by 柳宗青 on 2022/5/24.
//

import SwiftUI

struct GridView:View {
    let columnLayout = Array(repeating: GridItem(), count: 3)
    @State private var selectedColor = Color.gray
    let allColors: [Color] = [
           .pink,
           .red,
           .orange,
           .yellow,
           .green,
           .purple,
           .gray
       ]
    var body: some View {
        VStack  {
            Text("Selected Color")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(selectedColor)
                .padding(10)
            ScrollView{
                LazyVGrid(columns: columnLayout) {
                    ForEach(allColors, id: \.description) { (color) in
                        Button {
                            selectedColor = color
                        } label: {
                            RoundedRectangle(cornerRadius: 4)
                                .aspectRatio(1.0, contentMode: .fit)
                                .foregroundColor(color)
                        }
                    }
                }
            }
        }
    }
}
