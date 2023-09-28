//
//  AddCryptoViewModel.swift
//  App199
//
//  Created by Вячеслав on 9/28/23.
//

import SwiftUI
import CoreData

final class AddCryptoViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var rate: String = ""
    
    @Published var cryptos: [CryptoModel] = []
    
    func addCrypto(completion: @escaping () -> (Void)) {
        
        CoreDataStack.shared.modelName = "CryptoModel"
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let trans = NSEntityDescription.insertNewObject(forEntityName: "CryptoModel", into: context) as! CryptoModel
        
        trans.title = title
        trans.rate = Int16(rate) ?? 0
        
        CoreDataStack.shared.saveContext()
        
        completion()
    }
    
    func fetchCryptos() {
        
        CoreDataStack.shared.modelName = "CryptoModel"
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<CryptoModel>(entityName: "CryptoModel")

        do {
            
            let branch = try context.fetch(fetchRequest)
            
            self.cryptos = branch
            
        } catch let error as NSError {
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.cryptos = []
        }
    }
}
