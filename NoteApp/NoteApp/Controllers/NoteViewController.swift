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
	
	
	override func viewDidDisappear(_ animated: Bool) {
		
		super.viewDidDisappear(animated)
		
		note = nil
		titleTextField.text = ""
		bodyTextView.text = ""
		
	}
	
	@IBAction func deleteTapped(_ sender: Any) {
		
		if note != nil {
			
			notesModel?.deleteNote(note!)
			
		}
		
		dismiss(animated: true, completion: nil)
	}
	
	
	@IBAction func saveTapped(_ sender: Any) {
		
		if note == nil {
			
			// Brand new note
			let n = Note(
				docID: UUID().uuidString,
				title: titleTextField.text ?? "",
				body: bodyTextView.text ?? "",
				isStarred: false,
				createdAt: Date(),
				lastUpdatedAt: Date()
			)
			
			note = n
		}
		else {
			
			// Update to existing note
			note?.title = titleTextField.text ?? ""
			note?.body = bodyTextView.text ?? ""
			note?.lastUpdatedAt = Date()

		}
		
		notesModel?.saveNote(note!)
		
		dismiss(animated: true, completion: nil)
		
	}
	
}
