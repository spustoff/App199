//
//  TabBar.swift
//  App199
//
//  Created by Вячеслав on 9/28/23.
//

import SwiftUI

struct TabBar: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        
        HStack {
            
            ForEach(Tab.allCases, id: \.self) { index in
                
                Button(action: {
                    
                    selectedTab = index
                    
                }, label: {
                    
                    if index != .Add {
                        
                        VStack(alignment: .center, spacing: 6, content: {
                            
                            Image(index.rawValue)
                                .renderingMode(.template)
                                .foregroundColor(selectedTab == index ? Color("primary") : Color.gray)
                                .frame(height: 22)
                            
                            Text(index.rawValue)
                                .foregroundColor(selectedTab == index ? Color("primary") : Color.gray)
                                .font(.system(size: 12, weight: .regular))
                            
                        })
                        .frame(maxWidth: .infinity)
                        
                    } else {
                        
                        VStack(alignment: .center, spacing: 9, content: {
                            
                            Image(index.rawValue)
                                .frame(height: 22)
                            
                        })
                        .frame(maxWidth: .infinity)
                    }
                })
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.top, 9)
        .padding(.bottom, 28)
        .background(Color.gray.opacity(0.1))
    }
}

enum Tab: String, CaseIterable {
    
    case Main = "Main"
    
    case Lists = "Lists"
    
    case Add = "Add"
    
    case Calendar = "Calendar"
    
    case More = "More"
    
}

#Preview {
    ContentView()
}
