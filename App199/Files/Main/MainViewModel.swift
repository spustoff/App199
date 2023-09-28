//
//  MainViewModel.swift
//  App199
//
//  Created by Вячеслав on 9/28/23.
//

import SwiftUI
import CoreData

final class MainViewModel: ObservableObject {
    
    @Published var deposits: [MainModel] = []
    @Published var current_website: MainModel?
    
    @AppStorage("websites") var websites: [String] = []
    
    @Published var crypto: String = ""
    @Published var crypto_list: [String] = ["BTC", "ETH", "XRP", "USDT", "USDC", "USDB", "BNB"]
    
    @Published var start_date: Date = Date()
    @Published var end_date: Date = Date()
    
    @Published var amount: String = ""
    
    @Published var apr: String = ""
    @Published var interest_date: String = ""
    
    @Published var pairs: [String] = ["EURUSD", "EURTRY", "EURKZT", "EURJPY", "USDTRY", "USDKZT", "USDRUB"]
    @Published var current_pair: String = "EURUSD"
    
    @Published var isAdd: Bool = false
    @Published var isDetail: Bool = false
    
    @Published var selected_website_string: String = ""
    
    func addDeposit(completion: @escaping () -> (Void)) {
        
        CoreDataStack.shared.modelName = "MainModel"
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let trans = NSEntityDescription.insertNewObject(forEntityName: "MainModel", into: context) as! MainModel
        
        trans.crypto = crypto
        trans.website_name = selected_website_string
        trans.start_date = start_date
        trans.end_date = end_date
        trans.amount = Int16(amount) ?? 0
        trans.apr = apr
        trans.payment_date = Int16(interest_date) ?? 0
        
        CoreDataStack.shared.saveContext()
        
        completion()
    }
    
    func fetchDeposits(isFilter: Bool) {
        
        CoreDataStack.shared.modelName = "MainModel"
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<MainModel>(entityName: "MainModel")

        do {
            
            let branch = try context.fetch(fetchRequest)
            
            if isFilter {
                
                self.deposits = branch.filter{$0.website_name == current_website?.website_name ?? ""}
                
            } else {
                
                self.deposits = branch
            }
            
        } catch let error as NSError {
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.deposits = []
        }
    }
}
