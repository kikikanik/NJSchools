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
    
    var selectedSchool : School? //***
    var selectedIndexPath: IndexPath?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "NJ Counties & Schools"
        
        njCounties = Array(njSchoolsModel.njCountiesNschools.keys).sorted() //sorts the counties
        
        //tableView.estimatedRowHeight = 60
       // tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let reloadIndexPath = selectedIndexPath {
            tableView.reloadRows(at: [reloadIndexPath], with: .automatic)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return  njCounties.count //the number of sections is the number of counties
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let county = njCounties[section]
        return njSchoolsModel.njCountiesNschools[county]!.count // we can use a ! not a ? because we know its from the model and exists always.
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return njCounties[section] //gives us a header as the county
    }

    // this function will get called just before section's headerview is displayed
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.font = UIFont.init(name: "Montserrat-Regular", size: 14)
        header?.textLabel?.textColor = .darkGray
    }
    
    // set size font for section header font
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 26
    }
    
    // this function will get called before display of section's footer
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footer = view as? UITableViewHeaderFooterView
        footer?.textLabel?.font = UIFont.init(name: "Monterrat-Regular", size: 14)
        footer?.textLabel?.textColor = .blue
    }
    
    // set size font for section footer font
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 26
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        let county = njCounties[section]
        return "Total: \(String(njSchoolsModel.njCountiesNschools[county]!.count))" //returns how many schools in that county

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "schoolCell", for: indexPath) as! CustomSchoolTableViewCell
        
        // Configure the cell...

        let county = njCounties[indexPath.section]
        
        if let countyData = njSchoolsModel.njCountiesNschools[county] {
            let school = countyData[indexPath.row]
        
        cell.schoolName.text = school.properties.name
        cell.schoolPhone.text = "Phone: " + school.properties.phone!
        
        cell.schoolRating.text = "Rating: " + getStars(school.properties.ratings)

/*
        let ratingsCount = njSchoolsModel.njCountiesNschools[county]?[indexPath.row].properties.ratings ?? 0
        let ratingStars = String(repeating: "⭐️", count: ratingsCount)
        cell.schoolRating.text = ratingStars
*/
            
        // image view
        switch (school.properties.schoolType) {
        case "CHARTER":
            cell.imageView?.image = UIImage(named: "charter")
        case "PUBLIC":
            cell.imageView?.image = UIImage(named: "public")
        case "PRIVATE":
            cell.imageView?.image = UIImage(named: "private")
        default:
            cell.imageView?.image = UIImage(systemName: "questionmark.square.dashed")
        }
    }
        return cell
}
    
        // set row height
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60
        }

        
        
    // MARK: - TableView Delegates

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        selectedIndexPath = indexPath
        performSegue(withIdentifier: "schoolDetailSegue", sender: self)
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         if let indexPath = selectedIndexPath {
             let selectedCounty = njCounties[indexPath.section]
             let selectedSchool = njSchoolsModel.njCountiesNschools[njCounties[indexPath.section]]?[indexPath.row]
             let editSchool = njSchoolsModel.getSchoolInfo(forSchoolId: selectedSchool!.properties.objectId, inCounty: selectedCounty)
             if(segue.identifier == "schoolDetailSegue") {
                 // destination view controller
                 let dvc = segue.destination as! SchoolDetailViewController
                 dvc.editedSchool = editSchool
                 dvc.county = selectedCounty
             }
         }
     }
}
