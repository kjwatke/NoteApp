//
//  NotesViewController.swift
//  NoteApp
//
//  Created by Kevin  Watke on 2/5/22.
//

import UIKit

class NoteViewController: UIViewController {

	@IBOutlet weak var titleTextField: UILabel!
	@IBOutlet weak var bodyTextField: UITextView!
	
	var note: Note?
	var notesModel: NotesModel?
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		guard note != nil else {
			print("no notes available")
			return
		}
		
		titleTextField.text = note?.title
		bodyTextField.text = note?.body
	}
	
	
	@IBAction func deleteTapped(_ sender: Any) {
	}
	
	
	@IBAction func saveTapped(_ sender: Any) {
	}
	

}
