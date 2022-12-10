//
//  SpotViewModel.swift
//  SnacktacularUI
//
//  Created by Remi Pacifico Hansen on 11/14/22.
//

import Foundation
import FirebaseFirestore

class SpotViewModel: ObservableObject {
    @Published var spot = Spot()
    
    func saveSpot(spot: Spot) async -> Bool {
        let db = Firestore.firestore()
        if let id = spot.id {
            do {
                try await db.collection("spots").document(id).setData(spot.dictionary)
                print("😎 Data updated successfully!")
                return true
            }catch {
                print("😡 ERROR: Could not update data in 'spots' \(error.localizedDescription)")
                return false
            }
        }else {
            do {
                _ = try await db.collection("spots").addDocument(data: spot.dictionary)
                print("😎Data added successfully")
                return true
            }catch {
                print("😡 ERROR: Could not create a new spot in 'spots' \(error.localizedDescription)")
                return false
            }
        }
    }
}
