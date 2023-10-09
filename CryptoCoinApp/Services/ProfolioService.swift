//
//  ProfolioService.swift
//  CryptoCoinApp
//
//  Created by s on 09/10/2023.
//

import Foundation
import CoreData


class ProfolioService {
    
    private let containerName: String = "ProfolioContainer"
    
    @Published var profolioEntities: [ProfolioEntity] = []
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    //MARK: - init
     init() {
        fetchProfolio()
    }
    
 
    
    //MARK: - Public
    
    public func updateProfolio(coin: CoinModel, amount: Double) {
        // Check if profolio is found in Profoio Entities
        if let entity = profolioEntities.first(where: {$0.profolioID == coin.id}) {
            if amount > 0 {
                // update Entity if amount is greater than zero
                update(entity: entity, amount: amount)
            }else {
                // Delete Entity if amount is less than zero
                deleteProfolio(profolioEntity: entity)
            }
        }else{
            // Add entity if Entity is not found
            addProfolio(coin: coin, amount: amount)
        }
    }
    
    //MARK: - Private
    
    // Fetch Data
   private func fetchProfolio() {
        let request: NSFetchRequest<ProfolioEntity> = ProfolioEntity.fetchRequest()
        do {
            profolioEntities = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching fruits: \(error)")
        }
    }
    
    // Add ProfolioEntity
    private func addProfolio(coin: CoinModel, amount: Double) {
        let newProfolio =  ProfolioEntity(context: persistentContainer.viewContext )
        newProfolio.profolioID = coin.id
        newProfolio.profolioAmount = amount
        applyChanges()
    }
    
    private func deleteProfolio(profolioEntity: ProfolioEntity) {
        persistentContainer.viewContext.delete(profolioEntity)
        applyChanges()
    }
    
    private func update(entity: ProfolioEntity, amount: Double) {
        entity.profolioAmount = amount
        applyChanges()
    }
    
    private func applyChanges() {
        saveContext()
        fetchProfolio()
    }
    
    // save
   private func saveContext() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
    }
}

