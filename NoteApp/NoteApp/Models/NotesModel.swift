//
//  NotesModel.swift
//  NoteApp
//
//  Created by Kevin  Watke on 2/5/22.
//

import Foundation
import Firebase

class NotesModel {
	
	var delegate: NotesModelDelegate?
	
	func getNotes() {
		
		// Get a reference to the db
		let db = Firestore.firestore()
		
		// Get all the notes
		db.collection("Notes")
			.getDocuments { snapshot, error in
				
				// Check for errors
				guard error == nil && snapshot != nil else  {
					
					print("Error with getting the data")
					return
				}
				
				var notes = [Note]()
				
				// Parse documents into notes
				for doc in snapshot!.documents {
					
					// Convert Timestap to Date type
					let createdDate: Date = Timestamp.dateValue(doc["createdAt"] as! Timestamp)()
					let lastUpdatedDate: Date = Timestamp.dateValue(doc["lastUpdatedAt"] as! Timestamp)()
					
					// Initalize a note with current document properties
					let note = Note(docID: doc["docID"] as! String,
									title: doc["title"] as! String,
									body: doc["body"] as! String,
									isStarred: doc["isStarred"] as! Bool,
									createdAt: createdDate,
									lastUpdatedAt: lastUpdatedDate)
					
					notes.append(note)
				}
				
				// Call the delegate and pass back the notes in the main thread
				DispatchQueue.main.async {
					self.delegate?.notesRetrieved(notes: notes)
				}
				
			}
	}
	
}
