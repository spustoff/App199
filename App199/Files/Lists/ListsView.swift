//
//  ListsView.swift
//  App199
//
//  Created by Вячеслав on 9/28/23.
//

import SwiftUI

struct ListsView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Lists")
                    .foregroundColor(.white)
                    .font(.system(size: 19, weight: .medium))
                    .padding()
                
                if viewModel.websites.isEmpty {
                    
                    VStack(spacing: 7, content: {
                        
                        Image("empty")
                        
                        Text("There are no sites for staking")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                        
                        Text("Click on the plus sign below")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .regular))
                    })
                    .frame(maxHeight: .infinity, alignment: .center)
                    .padding()
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: true) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.websites, id: \.self) { index in
                            
                                NavigationLink(destination: {
                                    
                                    MainDetailView(viewModel: viewModel)
                                        .navigationBarBackButtonHidden()
                                    
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
    }
}

#Preview {
    ListsView()
}
