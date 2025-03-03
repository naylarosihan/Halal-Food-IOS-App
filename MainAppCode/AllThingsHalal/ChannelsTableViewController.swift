//
//  ChannelsTableViewController.swift
//  AllThingsHalal
//
//  Created by PettaMarukka on 3/6/2024.
//

import UIKit
import Firebase


class ChannelsTableViewController: UITableViewController {
    
    let SEGUE_CHANNEL = "channelSegue"
    let CELL_CHANNEL = "channelCell"
    
    var channels = [Channel]()
    
    var channelsRef: CollectionReference?
    var databaseListener: ListenerRegistration?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let database = Firestore.firestore()
        channelsRef = database.collection("channels")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        databaseListener = channelsRef?.addSnapshotListener { [weak self] (querySnapshot, error) in
            if let error = error {
                print("Error getting channels: \(error)")
                return
            }
            
            self?.channels.removeAll()
            querySnapshot?.documents.forEach { snapshot in
                let id = snapshot.documentID
                let name = snapshot["name"] as! String
                let channel = Channel(id: id, name: name)
                self?.channels.append(channel)
            }
            
            self?.tableView.reloadData()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseListener?.remove()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return channels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Make sure that the dequeued cell uses the CELL_CHANNEL identifier.
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_CHANNEL, for: indexPath)

                // Get a reference to the current channel using the index path and set the cell's textLabel to be the channel name.
        let channel = channels[indexPath.row]
        cell.textLabel?.text = channel.name // Corrected to access the 'name' property

        return cell
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = channels[indexPath.row]
        performSegue(withIdentifier: SEGUE_CHANNEL, sender: channel)
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true // Allow editing for all channel cells
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let channelToDelete = channels[indexPath.row]
            
            let alert = UIAlertController(title: "Delete Channel", message: "Are you sure you want to permanently delete this channel?", preferredStyle: .alert)
            
          
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
                // Proceed with deleting the channel
                self?.channelsRef?.document(channelToDelete.id).delete() { error in
                    if let error = error {
                        print("Error removing channel: \(error)")
                    } else {
                        DispatchQueue.main.async {
                            if indexPath.row < self?.channels.count ?? 0 {
                                // Remove from local data array
                                self?.channels.remove(at: indexPath.row)
                                // Delete the row from the table view
                                tableView.deleteRows(at: [indexPath], with: .fade)
                            }
                        }
                    }
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    

    @IBAction func addChannel(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Add New Channel", message: "Enter channel name below", preferredStyle: .alert)
                alertController.addTextField()

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Create", style: .default) { [unowned self] _ in
            guard let channelName = alertController.textFields?.first?.text, !channelName.isEmpty else { return }
            let doesExist = channels.contains { $0.name.lowercased() == channelName.lowercased() }
            if !doesExist {
                self.channelsRef?.addDocument(data: ["name": channelName])
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        self.present(alertController, animated: false, completion: nil)
    }
}
