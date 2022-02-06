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
	@IBOutlet weak var starButton: UIBarButtonItem!
	
	private var isStarFiltered = false
	private var notesModel = NotesModel()
	private var notes = [Note]()
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		
		// Set self as delegate for notesModel
		notesModel.delegate = self
		
		setStarFilterButton()
		
		// Retrieve all notes according to the filter status
		isStarFiltered ? notesModel.getNotes(true) : notesModel.getNotes()
		
	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		let notesVC = segue.destination as! NoteViewController
		
		// If the user has selected a row, transition to note vc
		if tableView.indexPathForSelectedRow != nil {
			
			// Set the note and notes model properties of the note vc
			notesVC.note = notes[tableView.indexPathForSelectedRow!.row]
			
			// Deselect the selected row so that it doesn't interfere with new note creation
			tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: false)
		}
		
		// Whether its a new note or a selected note, we still want to pass through the notes model
		notesVC.notesModel = notesModel
		
	}
	
	
	func setStarFilterButton() {
		
		// Set the status of the star filter button
		let imageName = isStarFiltered ? "star.fill" : "star"
		starButton.image = UIImage(systemName: imageName)
		
	}
	
	
	@IBAction func starFilterTapped(_ sender: Any) {
		
		// Toggle the star filter status
		isStarFiltered.toggle()
		
		// Run the query
		isStarFiltered ? notesModel.getNotes(true) : notesModel.getNotes()
		
		// Update the star button
		setStarFilterButton()
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


