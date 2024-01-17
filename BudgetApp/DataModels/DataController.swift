//
//  DataController.swift
//  BudgetApp
//
//  Created by Lakshan Sivakumar on 15/1/24.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "transport")
    
    init(){
        container.loadPersistentStores {
            desc, error in if let error = error{
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext){
        do {
            try context.save()
            print("Data saved!")
        } catch{
            print("Data was not able to be saved")
        }
    }
    
    func addTransport(transportNote: String, amount: Double, date: Date, context: NSManagedObjectContext){
        let transport = Transport(context: context)
        transport.id = UUID()
        transport.date = date
        transport.transportNote = transportNote
        transport.amount = amount
        save(context: context)
        print(transport.date!)
    }
    func editTransport(transport: Transport, transportNote:String, amount: Double, context:NSManagedObjectContext){
        transport.date = Date()
        transport.transportNote = transportNote
        transport.amount = amount
        save(context: context)
    }
    func addSalary(note: String, salaryAmount: Double, salaryMonth: Date, context:NSManagedObjectContext){
        let salary = Salary(context: context)
        salary.note = note
        salary.salary = salaryAmount
        salary.salaryMonth = Date()
        save(context: context)
        print(salary.salary)
    }
}
