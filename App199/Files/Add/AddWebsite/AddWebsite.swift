//
//  AddWebsite.swift
//  App199
//
//  Created by Вячеслав on 9/28/23.
//

import SwiftUI

struct AddWebsite: View {
    
    @AppStorage("websites") var websites: [String] = []
    @State var title: String = ""
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Add Site")
                        .foregroundColor(.white)
                        .font(.system(size: 17, weight: .medium))
                    
                    HStack {
                        
                        Button(action: {
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "chevron.left")
                                    .foregroundColor(Color("primary"))
                                    .font(.system(size: 15, weight: .regular))
                                
                                Text("Back")
                                    .foregroundColor(Color("primary"))
                                    .font(.system(size: 16, weight: .regular))
                            }
                        })
                        
                        Spacer()
                    }
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 8, content: {
                    
                    Text("Title")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .medium))
                    
                    ZStack(alignment: .leading) {
                        
                        Text("App.aave")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(title.isEmpty ? 1 : 0)
                        
                        TextField("", text: $title)
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                Spacer()
                
                Button(action: {
                    
                    if !websites.contains(title) {
                        
                        websites.append(title)
                    }
                    
                    router.wrappedValue.dismiss()
                    
                }, label: {
                    
                    Text("Save")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                        .padding()
                })
                .opacity(title.isEmpty ? 0.5 : 1)
                .disabled(title.isEmpty ? true : false)
            }
        }
    }
}

#Preview {
    AddWebsite()
}
