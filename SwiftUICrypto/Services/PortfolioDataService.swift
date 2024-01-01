//
//  PortfolioDataService.swift
//  SwiftUICrypto
//
//  Created by Medhat Mebed on 1/2/24.
//

import Foundation
import CoreData

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"
    
    @Published var savedEntities = [PortfolioEntity]()
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { [weak self] _, error in
            if let error = error {
                print("error loading data from core data: \(error)")
            }
            self?.getPortfolio()
        }
        
    }
    //MARK: - PUBLIC FUNCTIONS
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        // check if coin already in portfolio
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    
    //MARK: - Private functions
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching portfolio entities \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to core data : \(error)")
        }
    }
    private func applyChanges() {
        save()
        getPortfolio()
    }
    
}
