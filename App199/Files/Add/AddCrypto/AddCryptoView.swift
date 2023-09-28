//
//  AddCryptoView.swift
//  App199
//
//  Created by Вячеслав on 9/28/23.
//

import SwiftUI

struct AddCryptoView: View {
    
    @Environment(\.presentationMode) var router
    
    @StateObject var viewModel = AddCryptoViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Add Crypto")
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
                        
                        Text("Ethereum")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.title.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.title)
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                VStack(alignment: .leading, spacing: 8, content: {
                    
                    Text("Current exchange rate")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .medium))
                    
                    ZStack(alignment: .leading) {
                        
                        Text("$10 000")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.rate.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.rate)
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                            .keyboardType(.decimalPad)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                Spacer()
                
                Button(action: {
                    
                    viewModel.addCrypto {
                        
                        router.wrappedValue.dismiss()
                    }
                    
                }, label: {
                    
                    Text("Save")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                        .padding()
                })
                .opacity(viewModel.title.isEmpty || viewModel.rate.isEmpty ? 0.5 : 1)
                .disabled(viewModel.title.isEmpty || viewModel.rate.isEmpty ?  true : false)
            }
        }
    }
}

#Preview {
    AddCryptoView()
}
