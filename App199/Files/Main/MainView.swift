//
//  MainView.swift
//  App199
//
//  Created by Вячеслав on 9/28/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Main")
                    .foregroundColor(.white)
                    .font(.system(size: 19, weight: .medium))
                    .padding()
                
                VStack(alignment: .leading, spacing: 25) {
                    
                    VStack(alignment: .leading, spacing: 6, content: {
                        
                        Text("Total Balance")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .regular))
                        
                        Text("$\(viewModel.deposits.map(\.amount).reduce(0, +))")
                            .foregroundColor(.white)
                            .font(.system(size: 23, weight: .semibold))
                    })
                    
                    HStack {
                        
                        Text("+\(13)%")
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
                    
                    VStack(alignment: .leading, spacing: 6, content: {
                        
                        Text("Websites")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .regular))
                        
                        Text("\(viewModel.websites.count)")
                            .foregroundColor(.white)
                            .font(.system(size: 23, weight: .semibold))
                    })
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                .padding(.horizontal)
                
                if viewModel.websites.isEmpty {
                    
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
                            
                            ForEach(viewModel.websites, id: \.self) { index in

                                Button(action: {
                                    
                                    viewModel.selected_website_string = index
                                    viewModel.current_website = viewModel.deposits.filter{($0.website_name ?? "") == index}.first
                                    
                                    print(viewModel.current_website)
                                    viewModel.fetchDeposits(isFilter: true)
                                    
                                    viewModel.isDetail = true
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        Image("item_logo")
                                        
                                        VStack(alignment: .leading, spacing: 5, content: {
                                            
                                            Text(index)
                                                .foregroundColor(.white)
                                                .font(.system(size: 16, weight: .medium))
                                            
                                            Text("\(viewModel.deposits.filter{($0.website_name ?? "") == index}.count) items")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 13, weight: .regular))
                                        })
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .trailing, spacing: 5, content: {
                                            
                                            Text("$\(viewModel.deposits.filter{($0.website_name ?? "") == index}.map(\.amount).reduce(0, +))")
                                                .foregroundColor(.white)
                                                .font(.system(size: 16, weight: .medium))
                                            
                                            Text("+\(Int.random(in: 1...25))%")
                                                .foregroundColor(Color(red: 29/255, green: 227/255, blue: 180/255))
                                                .font(.system(size: 13, weight: .regular))
                                        })
                                        
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 13, weight: .regular))
                                    }
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                                })
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .onAppear {
            
            viewModel.fetchDeposits(isFilter: false)
        }
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            MainDetailView(viewModel: viewModel)
        })
    }
}

#Preview {
    MainView()
}
