//
//  NotesViewController.swift
//  NoteApp
//
//  Created by Kevin  Watke on 2/5/22.
//

import UIKit

class NoteViewController: UIViewController {

	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var bodyTextView: UITextView!
	
	var note: Note?
	var notesModel: NotesModel?
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		guard note != nil else {
			print("no notes available")
			return
		}
		
		titleTextField.text = note?.title
		bodyTextView.text = note?.body
	}

	
	@IBAction func deleteTapped(_ sender: Any) {
		
		guard self.note != nil else {
			return
		}
		
		
	}
	
	
	@IBAction func saveTapped(_ sender: Any) {
		
		guard self.note == nil else {
			
			// Update to existing note
			self.note?.title = titleTextField.text ?? ""
			self.note?.body = bodyTextView.text ?? ""
			self.note?.lastUpdatedAt = Date()
			
			self.notesModel?.saveNote(self.note!)
			
			dismiss(animated: true, completion: nil)
			
			return
		}
		
		// Brand new note
		let n = Note(
			docID: UUID().uuidString,
			title: titleTextField.text ?? "",
			body: bodyTextView.text ?? "",
			isStarred: false,
			createdAt: Date(),
			lastUpdatedAt: Date()
		)
		
		self.notesModel?.saveNote(n)
		
		dismiss(animated: true, completion: nil)
		
	}
	
	
	
	

}
