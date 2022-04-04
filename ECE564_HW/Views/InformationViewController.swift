//
//  ViewController.swift
//  ECE564_HW
//
//  Created by Ric Telford on 5/11/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var readOnly = true
    
    // display person
    var displayPerson : DukePerson = DukePerson()
    
    // input text fields
    var firstName = UITextField()
    var lastName = UITextField()
    var whereFrom = UITextField()
    var netid = UITextField()
    var deg = UITextField()
    var team = UITextField()
    
    // email field - computed
    var email = UILabel()
    
    // input text fields (become arrays)
    var hobbies = UITextField()
    var languages = UITextField()
    
    // input segmented control fields
    var gender = UISegmentedControl(items: ["Male", "Female", "Nonbinary"])
    var dukeRole = UISegmentedControl(items: ["Prof", "TA", "Student", "Other"])
    
    // picture support
    var userImg = UIImageView()
    var userImgButton: UIButton = UIButton()
    var userImgController: UIImagePickerController = UIImagePickerController()

    // result label
    var resultLabel = UILabel()
    
    // progress bar
//    let progressBar = UIProgressView()
    
    // store user inputted info
    var firstNameInput : String?
    var lastNameInput : String?
    var whereFromInput: String?
    var netidInput : String?
    var degInput: String?
    var teamInput: String?
    var hobbyInput: String?
    var langInput: String?
    var genderSelected : Gender?
    var dukeRoleSelected: DukeRole?
    
    // store pre-edit variables
    var firstNameInputTemp : String?
    var lastNameInputTemp : String?
    var whereFromInputTemp : String?
    var netidInputTemp : String?
    var degInputTemp : String?
    var teamInputTemp : String?
    var hobbyInputTemp : String?
    var langInputTemp : String?
    var genderSelectedTemp : Gender?
    var dukeRoleSelectedTemp : DukeRole?
    
    @IBOutlet weak var flipViewButton: UIButton?
    
    override func loadView() {
        // You can change color scheme if you wish
        print("MADE IT")
        print("the person is")
        print(self.displayPerson)
        
        let view = UIView()
        view.backgroundColor = .white
        
        self.view = view
        
        let label = UILabel()
        label.frame = CGRect(x: 100, y: 20, width: 200, height: 20)
        label.text = "ECE 564 Class Directory"
        label.textColor = .black
        view.addSubview(label)
        
        // first name
        // label
        let fnameLabel = UILabel()
        fnameLabel.frame = CGRect(x: 25, y: 50, width: 200, height: 20)
        fnameLabel.text = "First Name:"
        fnameLabel.textColor = .black
        view.addSubview(fnameLabel)
        // text field
        firstName.frame = CGRect(x: 150, y: 50, width: 200, height: 20)
        firstName.layer.borderWidth = 0.5
        firstName.layer.borderColor = UIColor.lightGray.cgColor
        firstName.layer.cornerRadius = 3.0
        firstName.clearButtonMode = .whileEditing
        firstName.autocorrectionType = .no
        firstName.addTarget(self, action: #selector(changeFirst(_:)), for: .editingChanged)
        view.addSubview(firstName)
       
        // last name
        // label
        let lnameLabel = UILabel()
        lnameLabel.frame = CGRect(x: 25, y: 80, width: 200, height: 20)
        lnameLabel.text = "Last Name:"
        lnameLabel.textColor = .black
        view.addSubview(lnameLabel)
        // text field
        lastName.frame = CGRect(x: 150, y: 80, width: 200, height: 20)
        lastName.layer.borderWidth = 0.5
        lastName.layer.borderColor = UIColor.lightGray.cgColor
        lastName.layer.cornerRadius = 3.0
        lastName.clearButtonMode = .whileEditing
        lastName.autocorrectionType = .no
        lastName.addTarget(self, action: #selector(changeLast(_:)), for: .editingChanged)
        view.addSubview(lastName)
        
        // netID
        // label
        let netLabel = UILabel()
        netLabel.frame = CGRect(x: 25, y: 110, width: 200, height: 20)
        netLabel.text = "netID:"
        netLabel.textColor = .black
        view.addSubview(netLabel)
        // text field
        netid.frame = CGRect(x: 150, y: 110, width: 200, height: 20)
        netid.layer.borderWidth = 0.5
        netid.layer.borderColor = UIColor.lightGray.cgColor
        netid.layer.cornerRadius = 3.0
        netid.clearButtonMode = .whileEditing
        netid.autocorrectionType = .no
        netid.autocapitalizationType = .none
        netid.addTarget(self, action: #selector(changeNet(_:)), for: .editingChanged)
        view.addSubview(netid)
        
        // where from
        // label
        let fromLabel = UILabel()
        fromLabel.frame = CGRect(x: 25, y: 140, width: 200, height: 20)
        fromLabel.text = "From:"
        fromLabel.textColor = .black
        view.addSubview(fromLabel)
        // text field
        whereFrom.frame = CGRect(x: 150, y: 140, width: 200, height: 20)
        whereFrom.layer.borderWidth = 0.5
        whereFrom.layer.borderColor = UIColor.lightGray.cgColor
        whereFrom.layer.cornerRadius = 3.0
        whereFrom.clearButtonMode = .whileEditing
        whereFrom.autocorrectionType = .no
        whereFrom.addTarget(self, action: #selector(changeFrom(_:)), for: .editingChanged)
        view.addSubview(whereFrom)
        
        // degree
        // label
        let degLabel = UILabel()
        degLabel.frame = CGRect(x: 25, y: 170, width: 200, height: 20)
        degLabel.text = "Degree:"
        degLabel.textColor = .black
        view.addSubview(degLabel)
        // text field
        deg.frame = CGRect(x: 150, y: 170, width: 200, height: 20)
        deg.layer.borderWidth = 0.5
        deg.layer.borderColor = UIColor.lightGray.cgColor
        deg.layer.cornerRadius = 3.0
        deg.clearButtonMode = .whileEditing
        deg.autocorrectionType = .no
        deg.addTarget(self, action: #selector(changeDegree(_:)), for: .editingChanged)
        view.addSubview(deg)
        
        // hobby
        // label
        let hobbyLabel = UILabel()
        hobbyLabel.frame = CGRect(x: 25, y: 200, width: 200, height: 20)
        hobbyLabel.text = "Hobbies:"
        hobbyLabel.textColor = .black
        view.addSubview(hobbyLabel)
        // text field
        hobbies.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        hobbies.layer.borderWidth = 0.5
        hobbies.layer.borderColor = UIColor.lightGray.cgColor
        hobbies.layer.cornerRadius = 3.0
        hobbies.clearButtonMode = .whileEditing
        hobbies.autocorrectionType = .no
        hobbies.autocapitalizationType = .none
        hobbies.addTarget(self, action: #selector(changeHobby(_:)), for: .editingChanged)
        view.addSubview(hobbies)
        
        // languages
        // label
        let langLabel = UILabel()
        langLabel.frame = CGRect(x: 25, y: 230, width: 200, height: 20)
        langLabel.text = "Languages:"
        langLabel.textColor = .black
        view.addSubview(langLabel)
        // text field
        languages.frame = CGRect(x: 150, y: 230, width: 200, height: 20)
        languages.layer.borderWidth = 0.5
        languages.layer.borderColor = UIColor.lightGray.cgColor
        languages.layer.cornerRadius = 3.0
        languages.clearButtonMode = .whileEditing
        languages.autocorrectionType = .no
        languages.addTarget(self, action: #selector(changeLang(_:)), for: .editingChanged)
        view.addSubview(languages)
        
        // team
        // label
        let teamLabel = UILabel()
        teamLabel.frame = CGRect(x: 25, y: 260, width: 200, height: 20)
        teamLabel.text = "Team:"
        teamLabel.textColor = .black
        view.addSubview(teamLabel)
        // text field
        team.frame = CGRect(x: 150, y: 260, width: 200, height: 20)
        team.layer.borderWidth = 0.5
        team.layer.borderColor = UIColor.lightGray.cgColor
        team.layer.cornerRadius = 3.0
        team.clearButtonMode = .whileEditing
        team.autocorrectionType = .no
        team.addTarget(self, action: #selector(changeTeam(_:)), for: .editingChanged)
        view.addSubview(team)
        
        // email
        // label
        let emailLabel = UILabel()
        emailLabel.frame = CGRect(x: 25, y: 290, width: 200, height: 20)
        emailLabel.text = "Email:"
        emailLabel.textColor = .black
        view.addSubview(emailLabel)
        // text field
        email.frame = CGRect(x: 150, y: 290, width: 200, height: 20)
//        email.layer.borderWidth = 0.5
//        email.layer.borderColor = UIColor.lightGray.cgColor
//        email.layer.cornerRadius = 3.0
//        email.addTarget(self, action: #selector(changeLang(_:)), for: .editingChanged)
        view.addSubview(email)
        
        // gender
        gender.frame = CGRect(x: 25, y: 325, width: 325, height: 25)
        gender.addTarget(self, action: #selector(selectGender(_:)), for: .valueChanged)
        view.addSubview(gender)
        
        // duke role
        dukeRole.frame = CGRect(x: 25, y: 360, width: 325, height: 25)
        dukeRole.addTarget(self, action: #selector(selectRole(_:)), for: .valueChanged)
        view.addSubview(dukeRole)
        
        // clear button
        let clearButton = UIButton()
        clearButton.frame = CGRect(x: 50, y: 400, width: 125, height: 40)
        clearButton.layer.borderWidth = 0.75
        clearButton.layer.cornerRadius = 5
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.setTitle("Clear Fields", for: .normal)
        clearButton.backgroundColor = .white
        clearButton.addTarget(self, action: #selector(clearButtonClicked(_:)), for: .touchUpInside)
//        view.addSubview(clearButton)
    
        // add/update button
        let addUpdateButton = UIButton()
        addUpdateButton.frame = CGRect(x: 200, y: 400, width: 125, height: 40)
        addUpdateButton.layer.borderWidth = 0.75
        addUpdateButton.layer.cornerRadius = 5
        addUpdateButton.setTitleColor(.black, for: .normal)
        addUpdateButton.setTitle("Add/Update", for: .normal)
        addUpdateButton.backgroundColor = .lightGray
//        addUpdateButton.addTarget(self, action: #selector(addUpdateButtonClicked(_:)), for: .touchUpInside)
//        view.addSubview(addUpdateButton)

        // image
        userImg.frame = CGRect(x: 120, y: 425, width: 150, height: 150)
        view.addSubview(userImg)
        userImgButton.frame = userImg.frame
        userImgButton.addTarget(self, action: #selector(changeUserImg), for: .touchDown)
        view.addSubview(userImgButton)
        userImgController.delegate = self
 
        self.navigationController?.isToolbarHidden = false

        var items = [UIBarButtonItem]()

        if (readOnly) {
            items.append ( UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editMode)))
            print("got to readonly")
        }
        if (!readOnly) {
            storeTempValues()
            items.append ( UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addUpdateButtonClicked)))
            items.append ( UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(hitCancel)))
        }
        
        
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil) )
        items.append( UIBarButtonItem(title: "Flip", style: UIBarButtonItem.Style.plain, target: self, action: #selector(flipCard)) ) // replace add with your function

        self.toolbarItems = items // this made the difference. setting the item
//        // interaction
//        if flipViewButton != nil {
//            print("FUCK MEMEMEMEMEMEM")
//            let flipViewButton = flipViewButton!
//            flipViewButton.frame = CGRect(x: 120, y: 455, width: 40, height: 30)
//            view.addSubview(flipViewButton)
//            flipViewButton.setTitle("Flip View", for: .normal)
//            flipViewButton.tintColor = .white
//        }
        
        
        // result label
//        resultLabel.frame = CGRect(x: 105, y: 480, width: 250, height: 200)
//        resultLabel.text = ""
//        resultLabel.textColor = .black
//        resultLabel.textAlignment = .center
//        resultLabel.lineBreakMode = .byWordWrapping
//        resultLabel.numberOfLines = 8
//        view.addSubview(resultLabel)
        
        self.updateInfoView()
        
        setInteract()
        
        
        
        
//        let totalWidth : CGFloat = UIScreen.main.bounds.width
//        let totalHeight = UIScreen.main.bounds.height
        
//        view.addSubview(progressBar)
//        progressBar.isHidden = true
//        progressBar.frame = CGRect(x: 0, y: totalHeight - 5, width: totalWidth, height: 0)
//        progressBar.transform = CGAffineTransform(scaleX: 1, y: 1.5)
//        progressBar.progressTintColor = .purple
        
        // You can add code here
    }
    
    @IBAction func unwindToInfoView(sender: UIStoryboardSegue){}
    
    // prepare display person for selected cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navViewController = segue.destination as? UINavigationController,
           let destination = navViewController.viewControllers.first as? FlipViewController {
            if segue.identifier == "flipSegue" {
                let data = displayPerson
                destination.displayPerson = data
//                destination.isReadOnly = true
            }
        }
    }

    
    // You can add code here
    func clear() {
        // clearing text fields
        firstName.text = ""
        lastName.text = ""
        whereFrom.text = ""
        netid.text = ""
        deg.text = ""
        hobbies.text = ""
        languages.text = ""
        team.text = ""
        email.text = ""
        // clearing segmented controls
        gender.selectedSegmentIndex = -1
        dukeRole.selectedSegmentIndex = -1
        // clearing variables with user input
        firstNameInput = nil
        lastNameInput = nil
        whereFromInput = nil
        netidInput = nil
        degInput = nil
        hobbyInput = nil
        langInput = nil
        teamInput = nil
        genderSelected = nil
        dukeRoleSelected = nil
        userImg.image = nil
    }
    
    private func setInteract() {
        view.isUserInteractionEnabled = !readOnly
    }
    
    @objc func editMode() {
        // store temp values
        storeTempValues()
        
        view.isUserInteractionEnabled = true
        
        var items = [UIBarButtonItem]()
        items.append ( UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addUpdateButtonClicked)))
        items.append ( UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(hitCancel)))
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil) )
        items.append( UIBarButtonItem(title: "Flip", style: UIBarButtonItem.Style.plain, target: self, action: #selector(flipCard)) ) // replace
        
        self.toolbarItems = items // this made the difference. setting the item
    }
    
    func storeTempValues() {
        firstNameInputTemp = firstName.text
        lastNameInputTemp = lastName.text
        whereFromInputTemp = whereFrom.text
        netidInputTemp = netid.text
        degInputTemp = deg.text
        teamInputTemp = team.text
        hobbyInputTemp = hobbies.text
        langInputTemp = languages.text
        genderSelectedTemp = genderSelected
        dukeRoleSelectedTemp = dukeRoleSelected
    }
    
    @objc func hitCancel() {
        print("HIT CANCEL")
        
        firstName.text = firstNameInputTemp
        lastName.text = lastNameInputTemp
        whereFrom.text = whereFromInputTemp
        netid.text = netidInputTemp
        deg.text = degInputTemp
        team.text = teamInputTemp
        hobbies.text = hobbyInputTemp
        languages.text = langInputTemp
        genderSelected = genderSelectedTemp
        
        switch (displayPerson.gender) {
        case Gender.Male:
            gender.selectedSegmentIndex = 0
        case Gender.Female:
            gender.selectedSegmentIndex = 1
        case Gender.NonBinary:
            gender.selectedSegmentIndex = 2
        }
        
        dukeRoleSelected = dukeRoleSelectedTemp
        switch (displayPerson.role) {
        case DukeRole.Professor:
            dukeRole.selectedSegmentIndex = 0
        case DukeRole.TA:
            dukeRole.selectedSegmentIndex = 1
        case DukeRole.Student:
            dukeRole.selectedSegmentIndex = 2
        case DukeRole.Other:
            dukeRole.selectedSegmentIndex = 3
        }
        
        view.isUserInteractionEnabled = false
        
        var items = [UIBarButtonItem]()
        items.append ( UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editMode)))
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil) )
        items.append( UIBarButtonItem(title: "Flip", style: UIBarButtonItem.Style.plain, target: self, action: #selector(flipCard)) )
        
        self.toolbarItems = items
        
        self.readOnly = true
        updateInfoView()
    }
    
    @objc func flipCard() {
        performSegue(withIdentifier: "flipSegue", sender: nil)
    }
    
    func toString(_ array: [String]) -> String {
        return array.joined(separator: ",")
    }
    
    func toArray(_ string: String) -> [String] {
        return string.components(separatedBy: ",")
    }
    
    func parseFromJSON(input: Data) -> [DukePerson]? {
        let decode = JSONDecoder()
        do {
            let decoded = try decode.decode([DukePerson].self, from: input)
            print("parsed data from JSON")
            return decoded
        } catch let error as NSError {
            print("json error: \(error)")
            return nil
        }
    }
    
    // if first name changes
    @objc func changeFirst(_ user_input: UITextField) {
        firstNameInput = user_input.text
    }
    
    // if last name changes
    @objc func changeLast(_ user_input: UITextField) {
        lastNameInput = user_input.text
    }
    
    // if where from changes
    @objc func changeFrom(_ user_input: UITextField) {
        whereFromInput = user_input.text
    }
    
    // if netid changes
    @objc func changeNet(_ user_input: UITextField) {
        netidInput = user_input.text
    }
    
    // if degree changes
    @objc func changeDegree(_ user_input: UITextField) {
        degInput = user_input.text
    }
    
    // if hobbies changes
    @objc func changeHobby(_ user_input: UITextField) {
        hobbyInput = user_input.text
    }
    
    // if languages changes
    @objc func changeLang(_ user_input: UITextField) {
        langInput = user_input.text
    }
    
    // if team changes
    @objc func changeTeam(_ user_input: UITextField) {
        teamInput = user_input.text
    }
    
    // if gender changes
    @objc func selectGender(_ user_input: UISegmentedControl) {
        let input = user_input.selectedSegmentIndex
        switch input {
        case 0:
            genderSelected = Gender.Male
        case 1:
            genderSelected = Gender.Female
        case 2:
            genderSelected = Gender.NonBinary
        default:
            break
        }
    }
    
    // if role changes
    @objc func selectRole(_ user_input: UISegmentedControl) {
        let input = user_input.selectedSegmentIndex
        switch input {
        case 0:
            dukeRoleSelected = DukeRole.Professor
        case 1:
            dukeRoleSelected = DukeRole.TA
        case 2:
            dukeRoleSelected = DukeRole.Student
        default:
            dukeRoleSelected = DukeRole.Other
        }
    }
    
//    @objc func downButtonClicked(_ btn: UIButton){
//        REST(delegate: self).download()
//    }
    
    override func viewDidAppear(_ animated: Bool) {
//        loadInitialData()
//        serverDataAlert()
    }
    
//    func loadInitialData() {
//        _ = DukeDatabase.loadDukePerson()
//    }
//
//    @objc func serverDataAlert() {
//        let alert = UIAlertController(title: "Load data from server", message: nil, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { action in
//            self.progressBar.isHidden = false
//            self.progressBar.setProgress(0, animated: false)
//            REST(delegate: self).download()
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        self.present(alert, animated: true)
//    }
    
    @objc func changeUserImg() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Choose from Album", style: .default, handler: { action in self.chooseFromAlbum()}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // access camera roll for photos, doesn't allow to choose photo/movie
    func chooseFromAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            userImgController.sourceType = .savedPhotosAlbum
            userImgController.allowsEditing = false
            present(userImgController, animated: true, completion: nil)
        }
    }
    
    // UIImagePickerControllerDelegate method
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImg.image = chosenImg.copy(toSize: CGSize(width: 144, height: 144))
            userImg.contentMode = .scaleAspectFill
            resultLabel.text = "Image upload successful. Please save changes."
        }
        dismiss(animated: true, completion: nil)    // hide the pop-up choose photo scene
    }

    // add/update button clicked
    @objc func addUpdateButtonClicked(){
        print("Made IT")
        
        if firstNameInput == nil || lastNameInput == nil || whereFromInput == nil || netidInput == nil || degInput == nil || genderSelected == nil || dukeRoleSelected == nil {
            resultLabel.text = "Please enter first name, last name, netID, location, degree, gender, and role"
            resultLabel.textColor = .red
            print("firstNameInput")
        }
        else {
            // turn input strings into arrays
            var hobbyArray = [""]
            if hobbyInput != nil {
                hobbyArray = toArray(hobbyInput!)
            }
            
            var langArray = [""]
            if langInput != nil {
                langArray = toArray(langInput!)
            }
            
            if teamInput == nil {
                teamInput = ""
            }
            
            let imgString : String
            if (userImg.image == nil) {
                imgString = getBase64FromImage(from: UIImage(named: "defaultImg")!)!
            }
            else {
                imgString = getBase64FromImage(from: userImg.image!)!

            }
            print("this is the image string")
            print(imgString)
            
            if (email.text == nil) {
                email.text = netidInput! + "@duke.edu"
            }
            
            let result = DukeDatabase.addUpdatePerson(first: firstNameInput!, last: lastNameInput!, whereFrom: whereFromInput!, netid: netidInput!, degree: degInput!, team: teamInput!, hobbies: hobbyArray, languages: langArray, gender: genderSelected!, role: dukeRoleSelected!, image: imgString, email: email.text!)
            
            print("the email is again \(result.1.email)")
            
            
            if netidInput == "jrb127" {
                REST().upload(person: result.1)
            }
            
            hitCancel()
            
//            resultLabel.text = result.0
//            resultLabel.textColor = .purple
//            clear()
            
        }
    }
    
    func updateInfoView() {
        let person: DukePerson = displayPerson

        userImg.image = getImageFromBase64(from: person.userImg) ?? UIImage(named: person.netid+"Img") ?? UIImage(named: "defaultImg")
        
        firstName.text = person.firstName
        firstNameInput = person.firstName
        
        lastName.text = person.lastName
        lastNameInput = person.lastName
        
        whereFrom.text = person.whereFrom
        whereFromInput = person.whereFrom
        
        netid.text = person.netid
        netidInput = person.netid
        
        deg.text = person.deg
        degInput = person.deg
        
        team.text = person.group
        teamInput = person.group
        
        
        email.text = person.netid + "@duke.edu"
        
        // NEED TO ADD TO CONSTRUCTOR
        hobbies.text = toString(person.hobbies)
        hobbyInput = toString(person.hobbies)

        languages.text = toString(person.languages)
        langInput = toString(person.languages)
    
        genderSelected = person.gender
        switch (person.gender) {
        case Gender.Male:
            gender.selectedSegmentIndex = 0
        case Gender.Female:
            gender.selectedSegmentIndex = 1
        case Gender.NonBinary:
            gender.selectedSegmentIndex = 2
        }
        
        dukeRoleSelected = person.role
        switch (person.role) {
        case DukeRole.Professor:
            dukeRole.selectedSegmentIndex = 0
        case DukeRole.TA:
            dukeRole.selectedSegmentIndex = 1
        case DukeRole.Student:
            dukeRole.selectedSegmentIndex = 2
        case DukeRole.Other:
            dukeRole.selectedSegmentIndex = 3
        }
    }
    
    // find button clicked
    @objc func findButtonClicked(_ btn: UIButton) {
        // make sure user enters first and last name
        
        
        if netidInput == nil && (firstNameInput == nil || lastNameInput == nil) {
            resultLabel.text = "Please provide a first and last name"
            resultLabel.textColor = .red
        }
        // if user enters both
        else {
            var result : (DukePerson?, String)
            
            if netidInput != nil {
                result = DukeDatabase.findPersonNet(netidInput!)
            }
            else {
                result = DukeDatabase.findPerson(first: firstNameInput!, last: lastNameInput!)
            }
            
            // if no results are found
            if result.0 == nil {
                resultLabel.text = "The person was not found"
                resultLabel.textColor = .red
                return
            }
            
            // add text to result label
            resultLabel.text = result.1
            resultLabel.textColor = .blue
            
            let person = result.0!
            
            // add image to view
            
            userImg.image = getImageFromBase64(from: person.userImg) ?? UIImage(named: person.netid+"Img") ?? UIImage(named: "defaultImg")
            
            firstName.text = person.firstName
            firstNameInput = person.firstName
            
            lastName.text = person.lastName
            lastNameInput = person.lastName
            
            // have to change both to prevent unexpected behavior
            whereFrom.text = person.whereFrom
            whereFromInput = person.whereFrom
            
            netid.text = person.netid
            netidInput = person.netid
            
            deg.text = person.deg
            degInput = person.deg
            
            team.text = person.group
            teamInput = person.group
            
            email.text = person.netid + "@duke.edu"
            
            // NEED TO ADD TO CONSTRUCTOR
            hobbies.text = toString(person.hobbies)
            hobbyInput = toString(person.hobbies)

            languages.text = toString(person.languages)
            langInput = toString(person.languages)
        
            genderSelected = person.gender
            switch (person.gender) {
            case Gender.Male:
                gender.selectedSegmentIndex = 0
            case Gender.Female:
                gender.selectedSegmentIndex = 1
            case Gender.NonBinary:
                gender.selectedSegmentIndex = 2
            }
            
            dukeRoleSelected = person.role
            switch (person.role) {
            case DukeRole.Professor:
                dukeRole.selectedSegmentIndex = 0
            case DukeRole.TA:
                dukeRole.selectedSegmentIndex = 1
            case DukeRole.Student:
                dukeRole.selectedSegmentIndex = 2
            case DukeRole.Other:
                dukeRole.selectedSegmentIndex = 3
            }
        }
    }
    
    func getImageFromBase64(from base64String: String) -> UIImage? {
        let imageData = Data.init(base64Encoded: base64String)
        if imageData == nil {
            return nil
        }
        let image = UIImage(data: imageData!)
        return image
    }
    
    func getBase64FromImage(from image: UIImage) -> String? {
        let imgData: Data? = image.jpegData(compressionQuality: 1.0)
        let base = imgData?.base64EncodedString()
        return base
    }
    
    @objc func clearButtonClicked(_ btn: UIButton){
        clear()
        resultLabel.text = ""
    }
    
}

extension UIImage {
    // copy and redraw to new size
    func copy(toSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(toSize)
        self.draw(in: CGRect(origin: .zero, size: toSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
