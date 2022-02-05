	//
	//  ViewController.swift
	//  NoteApp
	//
	//  Created by Kevin  Watke on 2/5/22.
	//

import UIKit
import Firebase

class ViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	private var notesModel = NotesModel()
	private var notes = [Note]()
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		
		// Set self as delegate for notesModel
		notesModel.delegate = self
		
		notesModel.getNotes()
		
	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		let notesVC = segue.destination as! NoteViewController
		
		// Verify that a user has selected a note
		guard tableView.indexPathForSelectedRow != nil else  {
			print("No row is current selected at")
			return
		}
		
		// Pass the note data for the tapped row to the NoteViewController
		notesVC.note = notes[tableView.indexPathForSelectedRow!.row]
		notesVC.notesModel = self.notesModel
	}
	
	
}

	// MARK: - TableView DataSource Methods

extension ViewController: UITableViewDataSource {
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return notes.count
		
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
		
		let titleLabel = cell.viewWithTag(1) as? UILabel
		titleLabel?.text = notes[indexPath.row].title
		
		let bodyLabel = cell.viewWithTag(2) as? UILabel
		bodyLabel?.text = notes[indexPath.row].body
		
		return cell
		
	}
	
	
}


	// MARK: - TableView Delegate Methods

extension ViewController: UITableViewDelegate {
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
	
}

// MARK: - NotesModel Delegate Methods

extension ViewController: NotesModelDelegate {


	func notesRetrieved(notes: [Note]) {
		
		// Set notes property and refresh tableView
		self.notes = notes
		
		// Refresh the table
		tableView.reloadData()
		
	}
	
	
	
	
}


