//
//  AddView.swift
//  App199
//
//  Created by Вячеслав on 9/28/23.
//

import SwiftUI

struct AddView: View {
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Add")
                    .foregroundColor(.white)
                    .font(.system(size: 19, weight: .medium))
                    .padding()
                
                HStack {
                    
                    NavigationLink(destination: {
                        
                        AddWebsite()
                            .navigationBarBackButtonHidden()
                        
                    }, label: {
                        
                        Image("website")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 170, height: 170)
                    })
                    
                    NavigationLink(destination: {
                        
                        AddCryptoView()
                            .navigationBarBackButtonHidden()
                        
                    }, label: {
                        
                        Image("crypto")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 170, height: 170)
                    })
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
        }
    }
}

#Preview {
    AddView()
}
