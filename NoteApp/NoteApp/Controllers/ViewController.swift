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
		
//		let db = Firestore.firestore()
		
		tableView.delegate = self
		tableView.dataSource = self
		
		notesModel.getNotes()
		
		
	}
	
	
}

	// MARK: - TableView DataSource Methods

extension ViewController: UITableViewDataSource {
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return notes.count
		
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
		
		return cell
		
	}
	
	
}


	// MARK: - TableView Delegate Methods

extension ViewController: UITableViewDelegate {
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
	
}




