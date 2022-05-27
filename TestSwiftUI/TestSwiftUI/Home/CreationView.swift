//
//  CreationView.swift
//  TestSwiftUI
//
//  Created by 柳宗青 on 2022/5/27.
//

import SwiftUI

struct CreationView: View {
    
    var columns: [GridItem] =
        Array(repeating: .init(.flexible()), count: 3)
    
    let datas = ["Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKitCore/UIView.h> may also be helpful.","Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraint","Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraintUIViewAlertForUnsatisfi","Make a symbolic ","Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in","Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraintUIViewAlertForUnsatisf"]
    
    var body: some View {
        NavigationView{
            ScrollView() {
                
                LazyVGrid(columns: columns,alignment:.leading) {
//                    ForEach(datas, id:\.self) {
//                        Text($0).background(Color.gray)
//                    }
                    ForEach(0 ..< 11){ idx in
                        
                            
                        
                              GeometryReader { r in
                                  RoundedRectangle(cornerRadius: 5)
                                      .foregroundColor(Color(hue: 0.1 * Double(idx) , saturation: 1, brightness: 1))
                                    .frame(width: idx == 6 ? 2 * r.size.width  + 10 : r.size.width)
                              }.frame(height: idx == 3 ? 50 : 100)
                              if idx == 6 {
                                  Color.clear
                              }
                          }
                }.font(.largeTitle)
            
            }.navigationTitle(Text("Hello")).navigationBarTitleDisplayMode(.inline).foregroundColor(Color.red).navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct CreationView_Previews: PreviewProvider {
    static var previews: some View {
        CreationView()
    }
}
