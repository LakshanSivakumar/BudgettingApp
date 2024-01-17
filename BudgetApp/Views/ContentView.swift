//
//  ContentView.swift
//  BudgetApp
//
//  Created by Lakshan Sivakumar on 12/1/24.
//

import SwiftUI
import Charts
import CoreData
struct DetailView: View {
    var body: some View{
        Text("This is detail view")
    }
}
struct ContentView: View {
    @FetchRequest(sortDescriptors: []) var salaryInfo: FetchedResults<Salary>
    @Environment(\.managedObjectContext) var managedObjContext
    @State  var costs = 0.0
    @State var costFinal =  UserDefaults.standard.double(forKey: "Costs")
    @State  var salary: Double = 0.0
    @State var salaryFinal = UserDefaults.standard.double(forKey: "Salary")
    @State  var remainingBudget = UserDefaults.standard.double(forKey: "remainingBudget")
    @FocusState  var nameIsFocused: Bool



    var body: some View {
        NavigationStack{
            Text("Categories")
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading){
                    NavigationLink(){
                        TransportView()
                        
                    } label: {
                        Label("Transport", systemImage: "bus")
                        
                    }
                    NavigationLink{
                        DetailView()
                    } label:{
                        Label("Food", systemImage: "fork.knife.circle.fill")
                    }
                    NavigationLink{
                        TransactionHistory()
                    } label:{
                        Label("History", systemImage: "clock.fill")
                    }
                }
            }
            VStack{
                Form{
                    Section{
                        HStack() {
                            Text("Salary:")
                            TextField("Salary", value: $salary  , format: .currency(code: Locale.current.currency?.identifier ?? "SGD"))
                                .keyboardType(.decimalPad).focused($nameIsFocused)
                        }
                        HStack{
                            Text("Costs:")
                            TextField("Costs", value:$costs, format:.currency(code: Locale.current.currency?.identifier ?? "SGD")).keyboardType(.decimalPad).focused($nameIsFocused)
                        }
                        
                        
                    }
                    Section(header: Text("")){
                        Button(){
                        }label: {
                            Text("Submit")
                        }.onTapGesture {
                                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                            DataController().addSalary(note: "Test", salaryAmount: salary, salaryMonth: Date(), context: managedObjContext)
                            }.frame(maxWidth: .infinity)
                    }
                    Button(){
                    }label:{
                        Text("Reset")
                    }.onTapGesture {
                        salaryFinal = 0.0
                        costFinal = 0.0
                        remainingBudget = 0.0
                        UserDefaults.standard.set(salaryFinal,forKey:"Salary")
                        UserDefaults.standard.set(costFinal,forKey: "Costs")
                        UserDefaults.standard.set(remainingBudget,forKey: "remainingBudget")
                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                    }.tint(.red).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)

                    }
            }.onTapGesture {
                nameIsFocused = false
            }
                Section{
                    Text("\(salaryFinal)" as String)
                    Text("Total cost this month is \(costFinal, specifier:"%.2f")")
                    Text("Budget Remaining is \(remainingBudget, specifier: "%.2f")")
                }
            

            }
            .navigationTitle("Budget App")
            .navigationBarTitleDisplayMode(.inline)
                   
        }

    }

#Preview {
    ContentView()
}
