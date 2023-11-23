//
//  ContentView.swift
//  contacts_2
//
//  Created by Emanuele De Rogatis on 20/11/23.
//

import SwiftUI

struct Contact: Identifiable {
    var id = UUID()
    var name: String
    var phoneNumber: String
}

class ContactStore: ObservableObject {
    @Published var contacts = [
        Contact(name: "Gordon Freeman", phoneNumber: "66473677281"),
        Contact(name: "Manny Calavera", phoneNumber: "56576668989")
    ]
    
    func addContact(name: String, phoneNumber: String) {
        let newContact = Contact(name: name, phoneNumber: phoneNumber)
        contacts.append(newContact)
    }
}

struct ContentView: View {
    @ObservedObject var contactStore = ContactStore()
    @State private var newName = ""
    @State private var newPhoneNumber = ""
    @State private var isAddContactSheetPresented = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(contactStore.contacts) { contact in
                    VStack(alignment: .leading) {
                        Text(contact.name)
                            .font(.headline)
                            .accessibilityLabel(Text("Name: \(contact.name)"))
                        Text(contact.phoneNumber)
                            .accessibilityLabel(Text("Phone number: \(contact.phoneNumber)"))
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                Button(action: {
                    isAddContactSheetPresented = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isAddContactSheetPresented) {
                AddContactView(contactStore: contactStore, isPresented: $isAddContactSheetPresented)
            }
        }
    }
}

struct AddContactView: View {
    @ObservedObject var contactStore: ContactStore
    @Binding var isPresented: Bool
    @State private var newName = ""
    @State private var newPhoneNumber = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Contact")) {
                    TextField("Name", text: $newName)
                        .accessibilityLabel(Text("Insert new contact name"))
                    TextField("phone number", text: $newPhoneNumber)
                        .accessibilityLabel(Text("Insert new contact name"))
                                                .accessibilityHint(Text("be sure to include the country code if necessary"))
                        .navigationTitle("Add contact")
                        .toolbar {
                            ToolbarItemGroup(placement: .automatic) {
                                Button(action: {
                                    contactStore.addContact(name: newName, phoneNumber: newPhoneNumber)
                                    isPresented = false
                                }) {
                                    Text("Add")
                                        .accessibilityLabel(Text("Add contact"))
                                }
                            }
                        }
                }
            }
        }
    }
}
