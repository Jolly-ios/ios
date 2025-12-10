//
//  Order.swift
//  TestApp
//
//  Created by Ahmad Rafiq on 21/09/2025.
//

import Foundation

struct Order: Codable {
    let id: UUID
    let name: String
    let price: Double
    let quantity: Int
    let dateCreated: Date
    
    init(name: String, price: Double, quantity: Int) {
        self.id = UUID()
        self.name = name
        self.price = price
        self.quantity = quantity
        self.dateCreated = Date()
    }
    
    var totalPrice: Double {
        return price * Double(quantity)
    }
}

// MARK: - Order Manager for UserDefaults persistence
class OrderManager {
    static let shared = OrderManager()
    private let userDefaults = UserDefaults.standard
    private let ordersKey = "SavedOrders"
    
    private init() {}
    
    func saveOrder(_ order: Order) {
        var orders = getAllOrders()
        orders.append(order)
        saveOrders(orders)
    }
    
    func getAllOrders() -> [Order] {
        guard let data = userDefaults.data(forKey: ordersKey),
              let orders = try? JSONDecoder().decode([Order].self, from: data) else {
            return []
        }
        return orders
    }
    
    private func saveOrders(_ orders: [Order]) {
        if let data = try? JSONEncoder().encode(orders) {
            userDefaults.set(data, forKey: ordersKey)
        }
    }
    
    func deleteOrder(at index: Int) {
        var orders = getAllOrders()
        guard index < orders.count else { return }
        orders.remove(at: index)
        saveOrders(orders)
    }
    
    func getTotalOrdersCount() -> Int {
        return getAllOrders().count
    }
}
