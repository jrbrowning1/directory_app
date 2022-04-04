//: This is the playground file to use for submitting HW1.  You will add your code where noted below.  Make sure you only put the code required at load time in the ``loadView()`` method.  Other code should be set up as additional methods (such as the code called when a button is pressed).
  
import UIKit
import PlaygroundSupport

enum Gender : String {
    case Male = "Male"
    case Female = "Female"
    case NonBinary = "Non-binary"
}

class Person {
    var firstName = "First"
    var lastName = "Last"
    var whereFrom = "Anywhere"  // this is just a free String - can be city, state, both, etc.
    var gender : Gender = .Male
    var hobbies = ["none"]
}

enum DukeRole : String {
    case Professor = "Professor"
    case TA = "Teaching Assistant"
    case Student = "Student"
    case Other = "Other"
}

protocol ECE564 {
    var degree : String { get }
    var languages: [String] { get }
    var team : String { get }
}

// You can add code here

// need enum for program
//enum Program : String {
//    case Undergrad = "Undergrad"
//    case Grad = "Grad"
//    case Other = "Not Applicable"
//}

// sub-class Person class, support ECE564 and CustomStringConvertible protocol
class DukePerson: Person, ECE564, CustomStringConvertible {
    
    var role : DukeRole = .Student
//    var program : Program = .Other
    var netid : String = ""
    var deg : String = ""
    var langs = [String]()
    var group : String = ""
    
    // support CustomStringConvertible protocol
    var description : String {
        // first name + last name + location
        var descrip : String = "\(self.firstName) \(self.lastName) is from \(self.whereFrom). "
        // use correct pronouns for role and netID
        if self.gender == Gender.Female {
            descrip += "She is a \(self.role) pursuing a \(self.deg). Her netID is \(self.netid)."
        }
        else if self.gender == Gender.Male {
            descrip += "He is a \(self.role) pursuing a \(self.deg). His netID is \(self.netid)."
        }
        else {
            descrip += "They are a \(self.role) pursuing a \(self.deg). Their netID is \(self.netid)."
        }
        // gender pronouns
        var pronoun : String = ""
        if self.gender == Gender.Female {
            pronoun = "Her"
        }
        else if self.gender == Gender.Male {
            pronoun = "His"
        }
        else{
            pronoun = "Their"
        }
        // hobby description
        descrip += " " + pronoun + " hobbies include"
        if self.hobbies.count > 1 {
            for index in 0...self.hobbies.count-2{
                if index >= 1 {
                    descrip += ","
                }
                descrip += " "
                descrip += self.hobbies[index]
            }
            descrip += " and " + self.hobbies[self.hobbies.count-1] + ". "
        }
        else {
            descrip += " " + self.hobbies[0] + ". "
        }
        // languages description
        descrip += pronoun + " languages include"
        if self.languages.count > 1 {
            for index in 0...self.languages.count-2{
                if index >= 1 {
                    descrip += ","
                }
                descrip += " "
                descrip += self.languages[index]
            }
            descrip += " and " + self.languages[self.languages.count-1] + ". "
        }
        else {
            descrip += " " + self.languages[0] + ". "
        }
        
        return descrip
    }
    
    // support ECE564 protocol
    var degree: String {
        return "They are pursuing a \(self.deg)"
    }
    var languages: [String] {
        return self.langs
    }
    var team: String {
        return "They are on team \(self.group)"
    }
    
    // initializer
    init(firstName: String, lastName: String, whereFrom: String, netid: String, degree: String, hobbies: [String], languages: [String], gender: Gender, role: DukeRole){
        super.init()
        self.firstName = firstName
        self.lastName = lastName
        self.whereFrom = whereFrom
        self.netid = netid
        self.deg = degree
        self.hobbies = hobbies
        self.langs = languages
        self.gender = gender
        self.role = role
//        self.program = program
    }
}

// store data in array
var person_list = [DukePerson]()

// add people to list
person_list.append(DukePerson(firstName: "Richard", lastName: "Telford", whereFrom: "Chatham County, NC", netid: "rt113", degree: "NA", hobbies: ["reading", "golf", "swimming"], languages: ["Swift", "C", "C++"], gender: .Male, role: .Professor))
person_list.append(DukePerson(firstName: "Wenxin", lastName: "Xu", whereFrom: "Chengdu, China", netid: "wx65", degree: "BS", hobbies: ["photography", "ultimate frisbee"], languages: ["Swift", "Java", "Python"], gender: .Female, role: .TA))
person_list.append(DukePerson(firstName: "Anshu", lastName: "Dwibhashi", whereFrom: "Bangalore, India", netid: "ad353", degree: "BSE, MEng", hobbies: ["punk rock music", "playing guitar"], languages: ["Swift", "C/C++", "Python"], gender: .Male, role: .TA))
person_list.append(DukePerson(firstName: "Andrew", lastName: "Krier", whereFrom: "Saint Paul, Minnesota", netid: "ak513", degree: "BSE", hobbies: ["frisbee", "basketball"], languages: ["Swift", "Java", "Python"], gender: .Male, role: .TA))
person_list.append(DukePerson(firstName: "Jonathan", lastName: "Browning", whereFrom: "Lexington, KY", netid: "jrb127", degree: "BS", hobbies: ["music", "reading", "tennis"], languages: ["Java", "Javascript", "Python"], gender: .Male, role: .Student))

// find person function
func findPerson(first: String, last: String) -> (DukePerson?, String) {
    // clean up input string before looking
    let firstName = first.trimmingCharacters(in: .whitespacesAndNewlines)
    let lastName = last.trimmingCharacters(in: .whitespacesAndNewlines)
    // look through each person in list and compare by name
    for person in person_list {
        if person.firstName.lowercased() == firstName.lowercased() && person.lastName.lowercased() == lastName.lowercased() {
            return (person, person.description)
        }
    }
    return (nil, "Could not find this person")
}

// add or update person function: TO DO
func addUpdatePerson(first: String, last: String, whereFrom: String, netid: String, degree: String, hobbies: [String], languages: [String], gender: Gender, role: DukeRole) -> String {
    // asuume person does not exist
    var found : Bool = false
    // cleanup input
    let firstName = first.trimmingCharacters(in: .whitespacesAndNewlines)
    let lastName = last.trimmingCharacters(in: .whitespacesAndNewlines)

    // loop through data
    for person in person_list {
        // if they're in the database
        if person.firstName.lowercased() == firstName.lowercased() && person.lastName.lowercased() == lastName.lowercased() {
            person.whereFrom = whereFrom
            person.netid = netid
            person.deg = degree
            person.hobbies = hobbies
            person.langs = languages
            person.gender = gender
            person.role = role
            found = true
            break
        }
    }
    // if the person was found
    if found {
        return "The person has been updated"
    }
    // if the person was not found and needs to be added
    else {
        person_list.append(DukePerson(firstName: firstName, lastName: lastName, whereFrom: whereFrom, netid: netid, degree: degree, hobbies: hobbies, languages: languages, gender: gender, role: role))
        return "The person has been added"
    }
}


class HW1ViewController : UIViewController {
    
    // input text fields
    var firstName = UITextField()
    var lastName = UITextField()
    var whereFrom = UITextField()
    var netid = UITextField()
    var deg = UITextField()
    
    // input text fields (become arrays)
    var hobbies = UITextField()
    var languages = UITextField()
    
    // input segmented control fields
    var gender = UISegmentedControl(items: ["Male", "Female", "Nonbinary"])
    var dukeRole = UISegmentedControl(items: ["Prof", "TA", "Student", "Other"])

    // result label
    var resultLabel = UILabel()
    
    // store user inputted info
    var firstNameInput : String?
    var lastNameInput : String?
    var whereFromInput: String?
    var netidInput : String?
    var degInput: String?
    var hobbyInput: String?
    var langInput: String?
    var genderSelected : Gender?
    var dukeRoleSelected: DukeRole?
    
    
    override func loadView() {
        // You can change color scheme if you wish
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
        fnameLabel.frame = CGRect(x: 25, y: 60, width: 200, height: 25)
        fnameLabel.text = "First Name:"
        fnameLabel.textColor = .black
        view.addSubview(fnameLabel)
        // text field
        firstName.frame = CGRect(x: 150, y: 60, width: 200, height: 25)
        firstName.layer.borderWidth = 0.5
        firstName.layer.borderColor = UIColor.lightGray.cgColor
        firstName.layer.cornerRadius = 3.0
        firstName.addTarget(self, action: #selector(changeFirst(_:)), for: .editingChanged)
        view.addSubview(firstName)
       
        // last name
        // label
        let lnameLabel = UILabel()
        lnameLabel.frame = CGRect(x: 25, y: 100, width: 200, height: 25)
        lnameLabel.text = "Last Name:"
        lnameLabel.textColor = .black
        view.addSubview(lnameLabel)
        // text field
        lastName.frame = CGRect(x: 150, y: 100, width: 200, height: 25)
        lastName.layer.borderWidth = 0.5
        lastName.layer.borderColor = UIColor.lightGray.cgColor
        lastName.layer.cornerRadius = 3.0
        lastName.addTarget(self, action: #selector(changeLast(_:)), for: .editingChanged)
        view.addSubview(lastName)
        
        // where from
        // label
        let fromLabel = UILabel()
        fromLabel.frame = CGRect(x: 25, y: 140, width: 200, height: 25)
        fromLabel.text = "From:"
        fromLabel.textColor = .black
        view.addSubview(fromLabel)
        // text field
        whereFrom.frame = CGRect(x: 150, y: 140, width: 200, height: 25)
        whereFrom.layer.borderWidth = 0.5
        whereFrom.layer.borderColor = UIColor.lightGray.cgColor
        whereFrom.layer.cornerRadius = 3.0
        whereFrom.addTarget(self, action: #selector(changeFrom(_:)), for: .editingChanged)
        view.addSubview(whereFrom)
        
        // netID
        // label
        let netLabel = UILabel()
        netLabel.frame = CGRect(x: 25, y: 180, width: 200, height: 25)
        netLabel.text = "netID:"
        netLabel.textColor = .black
        view.addSubview(netLabel)
        // text field
        netid.frame = CGRect(x: 150, y: 180, width: 200, height: 25)
        netid.layer.borderWidth = 0.5
        netid.layer.borderColor = UIColor.lightGray.cgColor
        netid.layer.cornerRadius = 3.0
        netid.addTarget(self, action: #selector(changeNet(_:)), for: .editingChanged)
        view.addSubview(netid)
        
        // degree
        // label
        let degLabel = UILabel()
        degLabel.frame = CGRect(x: 25, y: 220, width: 200, height: 25)
        degLabel.text = "Degree:"
        degLabel.textColor = .black
        view.addSubview(degLabel)
        // text field
        deg.frame = CGRect(x: 150, y: 220, width: 200, height: 25)
        deg.layer.borderWidth = 0.5
        deg.layer.borderColor = UIColor.lightGray.cgColor
        deg.layer.cornerRadius = 3.0
        deg.addTarget(self, action: #selector(changeDegree(_:)), for: .editingChanged)
        view.addSubview(deg)
        
        // hobby
        // label
        let hobbyLabel = UILabel()
        hobbyLabel.frame = CGRect(x: 25, y: 260, width: 200, height: 25)
        hobbyLabel.text = "Hobbies:"
        hobbyLabel.textColor = .black
        view.addSubview(hobbyLabel)
        // text field
        hobbies.frame = CGRect(x: 150, y: 260, width: 200, height: 25)
        hobbies.layer.borderWidth = 0.5
        hobbies.layer.borderColor = UIColor.lightGray.cgColor
        hobbies.layer.cornerRadius = 3.0
        hobbies.addTarget(self, action: #selector(changeHobby(_:)), for: .editingChanged)
        view.addSubview(hobbies)
        
        // languages
        // label
        let langLabel = UILabel()
        langLabel.frame = CGRect(x: 25, y: 300, width: 200, height: 25)
        langLabel.text = "Languages:"
        langLabel.textColor = .black
        view.addSubview(langLabel)
        // text field
        languages.frame = CGRect(x: 150, y: 300, width: 200, height: 25)
        languages.layer.borderWidth = 0.5
        languages.layer.borderColor = UIColor.lightGray.cgColor
        languages.layer.cornerRadius = 3.0
        languages.addTarget(self, action: #selector(changeLang(_:)), for: .editingChanged)
        view.addSubview(languages)
        
        // gender
        gender.frame = CGRect(x: 25, y: 340, width: 325, height: 25)
        gender.addTarget(self, action: #selector(selectGender(_:)), for: .valueChanged)
        view.addSubview(gender)
        
        // duke role
        dukeRole.frame = CGRect(x: 25, y: 380, width: 325, height: 25)
        dukeRole.addTarget(self, action: #selector(selectRole(_:)), for: .valueChanged)
        view.addSubview(dukeRole)
        
        // clear button
        let clearButton = UIButton()
        clearButton.frame = CGRect(x: 125, y: 415, width: 125, height: 20)
        clearButton.layer.borderWidth = 0.75
        clearButton.layer.cornerRadius = 5
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.setTitle("Clear Fields", for: .normal)
        clearButton.backgroundColor = .white
        clearButton.addTarget(self, action: #selector(clearButtonClicked(_:)), for: .touchUpInside)
        view.addSubview(clearButton)
        
        // add/update button
        let addUpdateButton = UIButton()
        addUpdateButton.frame = CGRect(x: 50, y: 450, width: 125, height: 40)
        addUpdateButton.layer.borderWidth = 0.75
        addUpdateButton.layer.cornerRadius = 5
        addUpdateButton.setTitleColor(.black, for: .normal)
        addUpdateButton.setTitle("Add/Update", for: .normal)
        addUpdateButton.backgroundColor = .lightGray
        addUpdateButton.addTarget(self, action: #selector(addUpdateButtonClicked(_:)), for: .touchUpInside)
        view.addSubview(addUpdateButton)
        
        // find button
        let findButton = UIButton()
        findButton.frame = CGRect(x: 200, y: 450, width: 125, height: 40)
        findButton.layer.borderWidth = 0.75
        findButton.layer.cornerRadius = 5
        findButton.setTitleColor(.black, for: .normal)
        findButton.setTitle("Find", for: .normal)
        findButton.backgroundColor = .lightGray
        findButton.addTarget(self, action: #selector(findButtonClicked(_:)), for: .touchUpInside)
        view.addSubview(findButton)
        
        // result label
        resultLabel.frame = CGRect(x: 25, y: 480, width: 325, height: 200)
        resultLabel.text = ""
        resultLabel.textColor = .black
        resultLabel.textAlignment = .center
        resultLabel.lineBreakMode = .byWordWrapping
        resultLabel.numberOfLines = 8
        view.addSubview(resultLabel)
        
        // You can add code here
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
        genderSelected = nil
        dukeRoleSelected = nil
    }
    
    func toString(_ array: [String]) -> String {
        return array.joined(separator: ",")
    }
    
    func toArray(_ string: String) -> [String] {
        return string.components(separatedBy: ",")
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
    
    // add/update button clicked
    @objc func addUpdateButtonClicked(_ btn: UIButton){
        if firstNameInput == nil || lastNameInput == nil || whereFromInput == nil || netidInput == nil || degInput == nil || hobbyInput == nil || langInput == nil || genderSelected == nil || dukeRoleSelected == nil {
            resultLabel.text = "Please enter all information"
            resultLabel.textColor = .red
        }
        else {
            // turn input strings into arrays
            let hobbyArray = toArray(hobbyInput!)
            let langArray = toArray(langInput!)
            
            let result = addUpdatePerson(first: firstNameInput!, last: lastNameInput!, whereFrom: whereFromInput!, netid: netidInput!, degree: degInput!, hobbies: hobbyArray, languages: langArray, gender: genderSelected!, role: dukeRoleSelected!)
            resultLabel.text = result
            resultLabel.textColor = .purple
            clear()
        }
    }
    
    // find button clicked
    @objc func findButtonClicked(_ btn: UIButton) {
        // make sure user enters first and last name
        if firstNameInput == nil || lastNameInput == nil {
            resultLabel.text = "Please provide a first and last name"
            resultLabel.textColor = .red
        }
        // if user enters both
        else {
            let result = findPerson(first: firstNameInput!, last: lastNameInput!)
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
            
            // have to change both to prevent unexpected behavior
            whereFrom.text = person.whereFrom
            whereFromInput = person.whereFrom
            
            netid.text = person.netid
            netidInput = person.netid
            
            deg.text = person.deg
            degInput = person.deg
            
            
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
    
    @objc func clearButtonClicked(_ btn: UIButton){
        clear()
        resultLabel.text = ""
    }
    
    

}
// Don't change the following line - it is what allows the view controller to show in the Live View window
PlaygroundPage.current.liveView = HW1ViewController()
