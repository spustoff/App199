//
//  MainDetailView.swift
//  App199
//
//  Created by Вячеслав on 9/28/23.
//

import SwiftUI

struct MainDetailView: View {
    
    @StateObject var viewModel: MainViewModel
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text(viewModel.current_website?.website_name ?? "name")
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
                        
                        Button(action: {
                            
                            viewModel.fetchDeposits(isFilter: true)
                            
                        }, label: {
                            
                            Image(systemName: "arrow.counterclockwise")
                                .foregroundColor(Color("primary"))
                                .font(.system(size: 17, weight: .regular))
                        })
                    }
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 25) {
                    
                    VStack(alignment: .leading, spacing: 6, content: {
                        
                        Text("Balance")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .regular))
                        
                        Text("$\(viewModel.deposits.map(\.amount).reduce(0, +))")
                            .foregroundColor(.white)
                            .font(.system(size: 23, weight: .semibold))
                    })
                    
                    HStack {
                        
                        Text("+\(25)%")
                            .foregroundColor(Color("bg"))
                            .font(.system(size: 14 ,weight: .regular))
                            .padding(5)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 29/255, green: 227/255, blue: 180/255)))
                        
                        Spacer()
                        
                        NavigationLink(destination: {
                            
                            MainChart()
                                .navigationBarBackButtonHidden()
                            
                        }, label: {
                            
                            HStack {
                                
                                Text("EUR/USD")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray.opacity(0.6))
                                    .font(.system(size: 14, weight: .regular))
                            }
                        })
                    }
                    
                    Button(action: {
                        
                        viewModel.isAdd = true
                        
                    }, label: {
                        
                        Text("Add Deposit")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                    })
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                .padding(.horizontal)
                
                if viewModel.deposits.isEmpty {
                    
                    VStack(spacing: 7, content: {
                        
                        Image("empty")
                        
                        Text("You have no investments")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                        
                        Text("Add your first crypto investment site")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .regular))
                    })
                    .frame(maxHeight: .infinity, alignment: .center)
                    .padding()
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: true) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.deposits, id: \.self) { index in
                                
                                HStack {
                                    
                                    VStack(alignment: .leading, spacing: 6, content: {
                                        
                                        HStack(content: {
                                            
                                            Text((index.start_date ?? Date()).convertDate(format: "MMM d"))
                                                .foregroundColor(.white)
                                                .font(.system(size: 15, weight: .regular))
                                            
                                            Text("-")
                                                .foregroundColor(.white)
                                                .font(.system(size: 15, weight: .regular))
                                            
                                            Text((index.end_date ?? Date()).convertDate(format: "MMM d"))
                                                .foregroundColor(.white)
                                                .font(.system(size: 15, weight: .regular))
                                        })
                                        
                                        Text(index.crypto ?? "")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 13, weight: .regular))
                                    })
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .trailing, spacing: 6, content: {
                                        
                                        Text("\(index.amount)")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 14, weight: .regular))
                                        
                                        Text("\(index.apr ?? "")% APR")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 14, weight: .regular))
                                    })
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            MainDetailAdd(viewModel: viewModel)
        })
    }
}

#Preview {
    MainDetailView(viewModel: MainViewModel())
}
