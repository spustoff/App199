//
//  MainDetailAdd.swift
//  App199
//
//  Created by Вячеслав on 9/28/23.
//

import SwiftUI

struct MainDetailAdd: View {
    
    @StateObject var viewModel: MainViewModel
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Add Deposit")
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
                
                ScrollView(.vertical, showsIndicators: true) {
                    
                    LazyVStack(spacing: 30) {
                        
                        Menu {
                            
                            ForEach(viewModel.crypto_list, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.crypto = index
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        Text(index)
                                        
                                        Spacer()
                                        
                                        if viewModel.crypto == index {
                                            
                                            Image(systemName: "xmark")
                                        }
                                    }
                                })
                            }
                            
                        } label: {
                            
                            HStack {
                                
                                Text(viewModel.crypto.isEmpty ? "Select" : viewModel.crypto)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .regular))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                        }
                        
                        VStack(alignment: .leading, spacing: 8, content: {
                            
                            Text("Start date")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .medium))
                            
                            DatePicker("", selection: $viewModel.start_date, displayedComponents: .date)
                                .labelsHidden()
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 8, content: {
                            
                            Text("End date")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .medium))
                            
                            DatePicker("", selection: $viewModel.end_date, displayedComponents: .date)
                                .labelsHidden()
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 8, content: {
                            
                            Text("Amount")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .medium))
                            
                            ZStack(alignment: .leading) {
                                
                                Text("100 ETH")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.amount.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.amount)
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .regular))
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 8, content: {
                            
                            Text("APR")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .medium))
                            
                            ZStack(alignment: .leading) {
                                
                                Text("5%")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.apr.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.apr)
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .regular))
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 8, content: {
                            
                            Text("Interest payment date")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .medium))
                            
                            ZStack(alignment: .leading) {
                                
                                Text("25")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.interest_date.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.interest_date)
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .regular))
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                }
                
                Spacer()
                
                Button(action: {
                    
                    viewModel.addDeposit {
                        
                        viewModel.fetchDeposits(isFilter: true)
                        
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
                .opacity(viewModel.crypto.isEmpty || viewModel.amount.isEmpty || viewModel.apr.isEmpty || viewModel.interest_date.isEmpty ? 0.5 : 1)
                .disabled(viewModel.crypto.isEmpty || viewModel.amount.isEmpty || viewModel.apr.isEmpty || viewModel.interest_date.isEmpty ? true : false)
            }
        }
    }
}

#Preview {
    MainDetailAdd(viewModel: MainViewModel())
}
