//
//  SchoolTableViewController.swift
//  NJSchools
//
//  Created by Kinneret Kanik on 04/10/2021.
//

import UIKit

class SchoolTableViewController: UITableViewController {

    let njSchoolsModel = NJSchoolsModel.sharedInstance
    var njCounties : [String] = [] //creates a array when you put the type inside of the sqaure bracets
    
    var selectedSchool : School?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "NJ Counties & Schools"
        
        njCounties = Array(njSchoolsModel.njCountiesNschools.keys).sorted()
        
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return njCounties.count //returning
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let county = njCounties[section]
        return njSchoolsModel.njCountiesNschools[county]!.count // we can use a ! not a ? because we know its from the model and exists always.
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return njCounties[section] //gives us a header as the county
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        let county = njCounties[section]
        return String(njSchoolsModel.njCountiesNschools[county]!.count) //returns

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "schoolCells", for: indexPath) as! CustomSchoolTableViewCell //makes the cell refer to our CustomSchoolTableViewCell


        let county = njCounties[indexPath.section]
        // Configure the cell...
        cell.schoolName.text = njSchoolsModel.njCountiesNschools[county]?[indexPath.row].properties.name
        cell.schoolPhone.text = njSchoolsModel.njCountiesNschools[county]?[indexPath.row].properties.phone
        
        let ratingsCount = njSchoolsModel.njCountiesNschools[county]?[indexPath.row].properties.ratings ?? 0
        let ratingStars = String(repeating: "⭐️", count: ratingsCount)
        cell.schoolRating.text = ratingStars
        
        // cell.schoolTypeImage.image = UIImage(named: ) //!! change when you have the image based on school type (switch statement)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //selection
        let county = njCounties[indexPath.section]
        let school = njSchoolsModel.njCountiesNschools[county]! [indexPath.row] //will give you the school
        selectedSchool = school
         
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

}
