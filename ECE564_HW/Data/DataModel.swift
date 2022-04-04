//
//  DataModel.swift
//  ECE564_HW
//
//  Created by Jonathan Browning on 1/24/22.
//  Copyright © 2022 ECE564. All rights reserved.
//

import Foundation

enum Gender : String, Codable {
    case Male = "Male"
    case Female = "Female"
    case NonBinary = "Non-binary"
}

class Person: Codable {
    var firstName = "First"
    var lastName = "Last"
    var whereFrom = "Anywhere"  // this is just a free String - can be city, state, both, etc.
    var gender : Gender = .Male
    var hobbies = ["none"]
    
    init() {
    }
    
    private enum CodingKeys: String, CodingKey {
        case firstname
        case lastname
        case wherefrom
        case gender
        case hobbies
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        firstName = try container.decodeIfPresent(String.self, forKey: .firstname) ?? "First"
        lastName = try container.decodeIfPresent(String.self, forKey: .lastname) ?? "Last"
        whereFrom = try container.decodeIfPresent(String.self, forKey: .wherefrom) ?? "Unknown"
        gender = try container.decodeIfPresent(Gender.self, forKey: .gender) ?? .NonBinary
        hobbies = try container.decodeIfPresent([String].self, forKey: .hobbies) ?? []
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(firstName, forKey: .firstname)
        try container.encode(lastName, forKey: .lastname)
        try container.encode(whereFrom, forKey: .wherefrom)
        try container.encode(gender, forKey: .gender)
        try container.encode(hobbies, forKey: .hobbies)
    }
}

enum DukeRole : String, Codable {
    case Professor = "Professor"
    case TA = "TA"
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
    var userImg: String = "defaultImg"
    var department: String = "NA"
    var id: String = "default id"
    var email: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case netid = "netid"
        case email = "email"
        case role = "role"
        case degree = "degree"
        case languages = "languages"
        case team = "team"
        case userImg = "picture"
        case department = "department"
        case id = "id"

    }
    
    override init() {
        super.init()
    }
    
    // initializer
    convenience init(firstName: String, lastName: String, whereFrom: String, netid: String, degree: String, team: String, hobbies: [String], languages: [String], gender: Gender, role: DukeRole, userImg: String, email: String){
        self.init()
        self.firstName = firstName
        self.lastName = lastName
        self.whereFrom = whereFrom
        self.netid = netid
        self.deg = degree
        self.hobbies = hobbies
        self.langs = languages
        self.group = team
        self.gender = gender
        self.role = role
        self.userImg = userImg
        self.email = email
        // self.program = program
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)

        netid = try container.decodeIfPresent(String.self, forKey: .netid) ?? ""

        role = try container.decodeIfPresent(DukeRole.self, forKey: .role) ?? .Other
        deg = try container.decodeIfPresent(String.self, forKey: .degree) ?? ""
        langs = try container.decodeIfPresent([String].self, forKey: .languages) ?? ["None"]
        group = try container.decodeIfPresent(String.self, forKey: .team) ?? ""
        userImg = try container.decodeIfPresent(String.self, forKey: .userImg) ?? ""
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(netid, forKey: .netid)
        try container.encode(role, forKey: .role)
        try container.encode(deg, forKey: .degree)
        try container.encode(langs, forKey: .languages)
        try container.encode(group, forKey: .team)
        try container.encode(userImg, forKey: .userImg)
        try container.encode(department, forKey: .department)
        try container.encode(netid, forKey: .id)
        try container.encode(email, forKey: .email)
    }
    
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
        else if self.languages.count == 1 {
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

}

// add or update person function: TO DO
//func addUpdatePerson(first: String, last: String, whereFrom: String, netid: String, degree: String, team: String, hobbies: [String], languages: [String], gender: Gender, role: DukeRole, image: String, email: String) -> (String, DukePerson) {
//    // asuume person does not exist
//    var found : Bool = false
//    var returnPerson: DukePerson? = nil
//    // cleanup input
//    let firstName = first.trimmingCharacters(in: .whitespacesAndNewlines)
//    let lastName = last.trimmingCharacters(in: .whitespacesAndNewlines)
//    let email = "\(netid)@duke.edu"
//    // loop through data
//    for person in person_list {
//        // if they're in the database
//        if person.firstName.lowercased() == firstName.lowercased() && person.lastName.lowercased() == lastName.lowercased() {
//            person.whereFrom = whereFrom
//            person.netid = netid
//            person.deg = degree
//            person.group = team
//            person.hobbies = hobbies
//            person.langs = languages
//            person.gender = gender
//            person.role = role
//            person.userImg = image
//            person.email = email
//            returnPerson = person
//            found = true
//            break
//        }
//    }
//    // if the person was found
//    if found {
//        print("the email is \(returnPerson!.email)")
//        return ("The person has been updated", returnPerson!)
//    }
//    // if the person was not found and needs to be added
//    else {
//        returnPerson = DukePerson(firstName: firstName, lastName: lastName, whereFrom: whereFrom, netid: netid, degree: degree, team: team, hobbies: hobbies, languages: languages, gender: gender, role: role, userImg: image, email: email)
//        person_list.append(returnPerson!)
//        return ("The person has been added", returnPerson!)
//    }
//}
