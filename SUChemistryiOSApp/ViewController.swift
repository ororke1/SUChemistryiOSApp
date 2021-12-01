//
//  ViewController.swift
//  SUChemistryiOSApp
//

import UIKit

class ViewController: UIViewController {
    
    var button = dropDownBtn()
// User input variables
    var userConcentration:Double = 0.0
    var userSampleName:String = ""
    var userPathLength:Double = 0.0
// Calculation Variables
    var calcWavelength:Double = 0.0
    var calcAbsorbance:Double = 0.0
// RGB variables
    var camRed:Int = 0
    var camGreen:Int = 0
    var camBlue:Int = 0
// sample variables
    var control = SampleData();
    var sampleOne = SampleData()
    var sampleTwo = SampleData()
    var sampleThree = SampleData()
    var sampleFour = SampleData()
        
    
    var label1: UILabel!
    var label2: UILabel!
    var label3: UILabel!
    var textField1: UITextField!
    var textField2: UITextField!
    var safeArea : UILayoutGuide!
    let tableView = UITableView()
    
    let list = ["Hey 1","Hey 2","Hey 3"]
    
    


    override func loadView() {
        view = UIView() // parent class of UIKIT view types
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        
        //Configure the button
        button = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height:0 ))// changing these does nothing
        button.setTitle("Sample List", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        //Add Button to the View Controller
        self.view.addSubview(button)
        
 
        
        //Set the drop down menu's options
        
        //labels contraints
        label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.font = UIFont.systemFont(ofSize: 15)
        label1.textAlignment = .left
        label1.text = "Sample Name:"
        view.addSubview(label1)
        
        label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.font = UIFont.systemFont(ofSize: 15)
        label2.text = "Label 2"
        label2.numberOfLines = 0
        view.addSubview(label2)
      
        //textFields contraints
        
        textField1 = UITextField()
        textField1.translatesAutoresizingMaskIntoConstraints = false
        textField1.font = UIFont.systemFont(ofSize: 15)
        textField1.text = "Input 1"
        view.addSubview(textField1)
        
        textField2 = UITextField()
        textField2.translatesAutoresizingMaskIntoConstraints = false
        textField2.font = UIFont.systemFont(ofSize: 15)
        textField2.autocorrectionType = .no // to get rid of stupid constrain warning -_-
        textField2.text = "Input 2"
        view.addSubview(textField2)
       
        
        //Contraints of dropdown
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true // must find way to scale with other phones
        button.widthAnchor.constraint(equalToConstant: 275).isActive = true
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        button.dropView.dropDownOptions = ["Blue", "Green", "Magenta", "White", "Black", "Pink"]
        
        // add table view
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(ChemCell.self, forCellReuseIdentifier: "cellid")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.backgroundColor = .red
        
        NSLayoutConstraint.activate([ // initial all anchors at the same time
            //label1 and textfield1 constraints
            
            label1.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 100),
            label1.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            
            textField1.topAnchor.constraint(equalTo: label1.topAnchor),
            textField1.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 110),
            
//label 2 contraints
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 25),
            label2.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
         
            
                // textfield 2 constraints
            textField2.topAnchor.constraint(equalTo: label2.topAnchor),
            textField2.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 75),
            tableView.topAnchor.constraint(equalTo: label2.bottomAnchor,constant:0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -100),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                    ])
        
    }

    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
    
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// waiting for others to push code to start working on showing data on UI
    // Deletes the current samples saved data or just clears the screen back to default if no data is saved
    var fileDir:String = ""
    @objc
    func deleteAction(){
        deleteValues()
        // using sample one as a temp variable for right nows
        updateValues(samp: sampleOne)
    }
    // Saves the current samples data(name,concentration, RGB, absorbance, wavelength, thumbnails)
    @objc
    func saveAction(){
        // looks for working directory
        fileDir = "\(getFilePath())"
        
    }
    
    func getFilePath()->URL{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = path[0]
        return documentsDirectory
    }
    
    func defaultValues(samp:SampleData){
        sampleOne.setSampleName(name: "Sample One")
        sampleTwo.setSampleName(name: "Sample Two")
        sampleThree.setSampleName(name: "Sample Three")
        sampleFour.setSampleName(name: "Sample Four")
        
        camRed = 0
        camGreen = 0
        camBlue = 0
        
        userConcentration = 0.0
        userPathLength = 0.0
     //   userSampleName = sampleOne.getSampleName()
    }
    
    func updateValues(samp:SampleData){
        /*
            Waiting for UI to get finished before puttin in major if statement
            that tells the different sample objects to load data onto screen
            
            Makes use of the setters and getters
         */
    }
    
    func deleteValues(){
        // calls default values to reset objects to default standing
        // using only sample one as a temp variable for right now
        defaultValues(samp: sampleOne)
        // check if there is a saved data file to delete or not
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        let name = list[indexPath.row]
        guard let chemCell = cell as? ChemCell else {
            return cell
        }
        //cell.textLabel?.text = name
        chemCell.nameLabel.text = name
        chemCell.resLabel.text = name
        return cell
    }
}
protocol dropDownProtocol {
    func dropDownPressed(string : String)
}
    
    
class dropDownBtn: UIButton, dropDownProtocol {
    
    func dropDownPressed(string: String) {
        self.setTitle(string, for: .normal)
        self.dismissDropDown()
    }
    
    var dropView = dropDownView()
    
    var height = NSLayoutConstraint()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.darkGray
        
        dropView = dropDownView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        dropView.delegate = self
        dropView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func didMoveToSuperview() {
        self.superview?.addSubview(dropView)
        self.superview?.bringSubviewToFront(dropView)
        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true // where the drop spawns
        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true //
        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false {
             
            isOpen = true
            
            NSLayoutConstraint.deactivate([self.height])
            
            if self.dropView.tableView.contentSize.height > 75 { // size of dropdown animation
                self.height.constant = 75
            } else {
                self.height.constant = self.dropView.tableView.contentSize.height
            }
            
            
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height / 2
            }, completion: nil)
            
        } else {
            isOpen = false
            
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.center.y -= self.dropView.frame.height / 2
                self.dropView.layoutIfNeeded()
            }, completion: nil)
            
        }
    }
    
    func dismissDropDown() {
        isOpen = false
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class dropDownView: UIView, UITableViewDelegate, UITableViewDataSource  {
    
    var dropDownOptions = [String]()
    
    var tableView = UITableView()
    
    var delegate : dropDownProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.backgroundColor = UIColor.darkGray
        self.backgroundColor = UIColor.darkGray
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = dropDownOptions[indexPath.row]
        cell.backgroundColor = UIColor.darkGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.dropDownPressed(string: dropDownOptions[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
