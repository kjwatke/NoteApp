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
	@IBOutlet weak var starButton: UIButton!
	
	var note: Note?
	var notesModel: NotesModel?
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		if note != nil {
			
			// User is viewing an existing note, so populate the fields
			titleTextField.text = note?.title
			bodyTextView.text = note?.body
			
			// Set the status of the star button
			setStarButtonImage()
		}
		else {
			// Note property is nil, so create a new note
			
			// Create the note
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
	}
	
	
	override func viewDidDisappear(_ animated: Bool) {
		
		super.viewDidDisappear(animated)
		
		note = nil
		titleTextField.text = ""
		bodyTextView.text = ""
		
	}
	
	
	func setStarButtonImage() {
	
			// Set the status of the star button
		let imageName = note!.isStarred ? "star.fill" : "star"
		starButton.setImage(UIImage(systemName: imageName), for: .normal)
		
	}
	
	
	@IBAction func deleteTapped(_ sender: Any) {
		
		if note != nil {
			
			notesModel?.deleteNote(note!)
			
		}
		
		dismiss(animated: true, completion: nil)
	}
	
	
	@IBAction func saveTapped(_ sender: Any) {
		
		// Update to existing note
		note?.title = titleTextField.text ?? ""
		note?.body = bodyTextView.text ?? ""
		note?.lastUpdatedAt = Date()
		
		// Send it to the notes model
		notesModel?.saveNote(note!)
		
		dismiss(animated: true, completion: nil)
		
	}
	
	@IBAction func starTapped(_ sender: Any) {
		
		// Change the property in the note
		note?.isStarred.toggle()
		
		// Update the database
		notesModel?.updateFavStatus(note!.docID, note!.isStarred)
		
		// Update the button
		setStarButtonImage()
	}
	
}
