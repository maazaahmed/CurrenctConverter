//
//  ViewController.swift
//  MSE_Final_Q1
//
//  Created by Maaz's Macbook Pro on 11/02/2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController{
 
    var currencyArray : [Currency] = []
    var currencyNameArray : [CurrencyName] = []
    var index = 0
    var toConvert = String()
    var value = Double()
    @IBOutlet weak var currencyContainer: UIView!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var labelConversionRate: UILabel!
    @IBOutlet weak var textFieldFirstValue: UITextField!
    @IBOutlet weak var textFieldSecondValue: UITextField!
    @IBOutlet weak var buttonFirstValue: UIButton!
    @IBOutlet weak var buttonSecondValue: UIButton!
    @IBOutlet weak var buttonReverseCurrency: UIButton!
    @IBOutlet weak var butttonSettings: UIButton!
    
    @IBOutlet weak var secondValueTextField: UITextField!
    
    @IBOutlet weak var firstValueTextField: UITextField!
    
    var apiCurrentRates = "http://data.fixer.io/api/latest?access_key=e4f7c634d0dd1a3b6d8cf4dfb16ae111"
    var apiDates = "http://data.fixer.io/api/latest?access_key=e4f7c634d0dd1a3b6d8cf4dfb16ae111"
    var apiSymbols = "http://data.fixer.io/api/symbols?access_key=ab6ff2cd75c01b23ae2748741c59bae8"
    override func viewWillAppear(_ animated: Bool) {
        toConvert = "PKR"
        callAPI()
        callAPI2()
    }
    override func viewDidLoad() {
        currencyContainer.isHidden = true
        super.viewDidLoad()
    }
    
    @IBAction func buttonChangeCurrency(){
        tableView.reloadData()
        currencyContainer.isHidden = false
    }
    @IBAction func buttonReverseCurrencies() {
        
        let temp = buttonFirstValue.titleLabel?.text
        buttonFirstValue.titleLabel?.text = buttonSecondValue.titleLabel?.text
        buttonSecondValue.titleLabel?.text = temp
        
        let temp2 = textFieldFirstValue.text
        textFieldFirstValue.text = textFieldSecondValue.text
        textFieldSecondValue.text = temp2
    }
}
extension ViewController{
    func callAPI(){
        AF.request(apiCurrentRates).responseJSON { (data) in
            print("Start")
            //print(data.value)
            guard let films = data.value else{
                return
            }
            let newFilms = films as! [String : Any]
            //  print("IT IS HERE", newFilms)
            print(newFilms["rates"])
            let newNew = newFilms["rates"] as! [String : Any]
            print(newNew)
            for (key,value) in newNew {
                var curr = Currency()
                curr.name = key
                curr.value = value as! Double
               // print("\(key) = \(value)")
                self.currencyArray.append(curr)
                print(self.currencyArray.count)
            }
        }
    }
    func callAPI2(){
        print("HERE")
        AF.request(apiSymbols).responseJSON { (data) in
            print("Start")
            //print(data.value)
            guard let films = data.value else{
                return
            }
            let newFilms = films as! [String : Any]
            let newNew = newFilms["symbols"] as! [String : Any]
            for (key,value) in newNew {
                var currName = CurrencyName()
                currName.name = key
                currName.abbreviation = value as! String
                self.currencyNameArray.append(currName)
                print(key)
                print(value)
            }
            
        }
    }
    @IBAction func conversion(){
        for i in currencyArray{
            if i.name == toConvert{
                value = i.value
            }
        }
        var values = Double(firstValueTextField.text!)
        print(values)
        values = values! * value
        secondValueTextField.text! = String(values!)
    }
}
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath)
        let label1 = cell.viewWithTag(1000) as! UILabel
        let label2 = cell.viewWithTag(1001) as! UILabel
        label1.text = currencyNameArray[indexPath.row].name
        label2.text = currencyNameArray[indexPath.row].abbreviation
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyNameArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        buttonSecondValue.titleLabel?.text = currencyNameArray[index].name
        toConvert = currencyNameArray[index].name
        currencyContainer.isHidden = true
      
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
