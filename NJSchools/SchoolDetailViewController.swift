//
//  SchoolDetailViewController.swift
//  NJSchools
//
//  Created by Kinneret Kanik on 06/10/2021.
//

import UIKit

class SchoolDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var schoolList: UITableView!
    @IBOutlet weak var ratingsStars: UITextField!
    @IBOutlet weak var ratingsSlider: UISlider!
    
    // identifier for TableViewCell
    let schoolCellReuseIdentifier = "schoolCell"
    var editedSchool: School?
    // var editedField: UITextField?
    var editedField: UISlider?
    var enteredRating: Int = 0
    var county: String = ""
    
    // reference to model
    let njSchoolsModel = NJSchoolsModel.sharedInstance
    
    // reference to selected tableViewCells section and row
    var selectedIndexPath: IndexPath?
    
    // local variables
    var njCounties: [String] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Make the VC delegate and datasource
        self.schoolList.dataSource = self
        self.schoolList.delegate = self
        
        // enable slider
        ratingsSlider.isEnabled = true
        initRatingsSlider(editedSchool!.properties.rating)
        
        self.title = editedSchool?.properties.name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: schoolCellReuseIdentifier, for: indexPath)
        
        switch(indexPath.row) {
        case 0:
            cell.textLabel?.text = "County: "
            cell.detailTextLabel?.text = editedSchool?.properties.county
        case 1:
            cell.textLabel?.text = "School Type: "
            cell.detailTextLabel?.text = editedSchool?.properties.schoolType
        case 2:
            cell.textLabel?.text = "Phone: "
            cell.detailTextLabel?.text = editedSchool?.properties.phone
        case 3:
            cell.textLabel?.text = "Rating: "
            cell.detailTextLabel?.text = getStars(editedSchool?.properties.rating ?? 0)
        default:
            cell.textLabel?.text = "?"
            cell.detailTextLabel?.text = "?"
        }
        
        return cell
    }
    
    // ***** this method is not needed as we are just showing values
    /*
    // selected section and row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        ratingsSlider.isEnabled = true      // already set to true in viewDidLoad()
        let schoolRating = njSchoolsModel.njSchools[indexPath.row].properties.rating
        initRatingsSlider(schoolRating)
    }

     */
    
    
    // set the slider position
    func initRatingsSlider(_ rating: Int) {
        ratingsSlider.setValue(Float(rating), animated: true)
        showRatings(rating)
    }
    
    // action method for UISlider
    // TODO: connect to view with cntrl+drag
    @IBAction func setRatings(_ sender: UISlider) {
        print(ratingsSlider.value)
        sender.setValue(Float(lroundf(ratingsSlider.value)), animated: true)
        
        showRatings(Int(ratingsSlider.value))
        updateSchoolRating(Int(ratingsSlider.value))
    }
    
    // return number of emoji stars
    func getStars(_ rating: Int) -> String {
        var s = ""
        if rating > 0 {
            for _ in 1...rating {
                s = s + "⭐️"
            }
        }
        return s
    }
    
    // update the rating in the bottom view
    func showRatings(_ newRating: Int) {
        let s = getStars(newRating)
        print("\(newRating) \(s)")
        ratingsStars.text = s
    }
    
    // This method now has to work with updated the local editedSchool object and reload the table
     
     // update the UI for the selected row
     // invoke the model for rating info
     func updateSchoolRating(_ newRating: Int) {
         editedSchool!.properties.rating = newRating
         self.schoolList.reloadData()
     }
     
    
    
    // action for Barbutton Save - update the model
    @IBAction func save(_ sender: Any) {
        // get the rating
        enteredRating = Int(ratingsSlider.value)
        
        // invoke models update method
        let updateResult = njSchoolsModel.updateSchoolsRating(forSchoolId: editedSchool!.properties.objectId, county: county, rating: enteredRating)
        
        // alert setup
        if(updateResult) {
            showAlert("Updated!")
        } else {
            showAlert("Not Updated")
        }
    }
    
    // construct an AlertController, its actions, and present
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "School Data", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { _ in
    
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
