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
	var listener: ListenerRegistration?
	
	
	deinit {
		
		// Unregister database listener
		listener?.remove()
	}
	
	
	func getNotes() {
		
		// Get a reference to the db
		let db = Firestore.firestore()
		
		
		
		// Get all the notes
		listener = db
			.collection("Notes")
			.addSnapshotListener() { snapshot, error in
				
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
	
	func convertNoteToDict(_ note: Note) -> [String:Any] {
		
		var dict = [String:Any]()
		
		dict["docID"] = note.docID
		dict["title"] = note.title
		dict["body"] = note.body
		dict["createdAt"] = note.createdAt
		dict["lastUpdatedAt"] = note.lastUpdatedAt
		dict["isStarred"] = note.isStarred
		
		return dict
	}
	
	
	func deleteNote(_ note: Note) {
		
		let db = Firestore.firestore()
		
		db.collection("Notes").document(note.docID).delete()
	}
	
	
	func saveNote(_ note: Note) {
		
		let db = Firestore.firestore()
		
		db.collection("Notes").document(note.docID).setData(convertNoteToDict(note))
	}
	
}
