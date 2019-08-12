//
//  ViewController.swift
//  SpringApp
//
//  Created by apple on 11/08/19.
//  Copyright © 2019 Rajat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate , UITableViewDelegate, UITableViewDataSource  {
  
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrRes = [[String : AnyObject]]()   //Array of dictionary
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var searchTextField: UITextField!
    let findAllString = "http://localhost:8483/empData/findAll"
    
 
    var items: [String] = ["We", "Heart", "Swift"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "jsonCell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self

        // Do any additional setup after loading the view.
        firstName.delegate = self
        firstName.becomeFirstResponder()
        lastName.delegate = self
        number.delegate = self
        loadData(urlToFetch : findAllString)
        
        self.tableView.tableFooterView = UIView()
        
    }
    
    func loadData(urlToFetch : String){
        print(urlToFetch)
        
        AF.request(urlToFetch).responseJSON { (responseData) -> Void in
            print(responseData)
            let swiftJsonVar = JSON(responseData.data as Any)
            if let resData = swiftJsonVar["list"].arrayObject{
                self.arrRes = resData as! [[String:AnyObject]]
            }
            
            if(self.arrRes.count>0){
                self.tableView.reloadData()
            }
            
        }
        
        print(arrRes)
        
        self.tableView.reloadData()
        
    }

    @IBAction func saveData(_ sender: Any) {
    
        let firstNameInput = self.firstName.text!
        let lastNameInput = self.lastName.text!
        let numberInput = self.number.text!
        
        let url = URL(string:  "http://localhost:8483/empData/add?firstname=\(firstNameInput)&lastname=\(lastNameInput)&phone=\(numberInput)")
        
        AF.request(url!).validate()
        
        let alertController = UIAlertController(title: "Alert", message: "Data Saved", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss" , style: .default , handler : { action in
            switch action.style{
                case .default:
                    self.loadData(urlToFetch: self.findAllString)
                @unknown default:
                    print("default")

            }}))
        
        self.present(alertController,animated: true,completion: nil)
        
        self.firstName.text = ""
        self.lastName.text = ""
        self.number.text = ""
        self.firstName.becomeFirstResponder()

    }
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.arrRes.count)
            return self.arrRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "jsonCell", for: indexPath)
        
        var dict = arrRes[indexPath.row]
        cell.textLabel?.text = dict["fullName"] as? String
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var dict = arrRes[indexPath.row]
        
        let id = dict["id"] as? Int
        let fname = dict["firstName"] as? String
        let lname = dict["lastName"] as? String
        let fullname = dict["fullName"] as? String
        let mail = dict["mail"] as? String
        let phone = dict["number"] as? String

        
        let result = "id: \(id!) \n First Name: \(fname!)\n Last Name: \(lname!)\nFull Name: \(fullname!) \nEmail: \(mail!)\nContact: \(phone!)\n"
        
        let alertController = UIAlertController(title: "Employee Details ", message: result, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss" , style: .default ))
        
        self.present(alertController,animated: true,completion: nil)
        
    }

    @IBAction func searchButton(_ sender: Any) {
        let keyword = self.searchTextField.text
        let url = "http://localhost:8483/empData/findByName?firstname=\(keyword!)"
        loadData(urlToFetch: url)
    
    }
    
    
    @IBAction func refresh(_ sender: Any) {
        loadData(urlToFetch: findAllString)
        self.searchTextField.text = ""
    }
    
}

