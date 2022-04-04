//
//  Database.swift
//  ECE564_HW
//
//  Created by Jonathan Browning on 2/7/22.
//  Copyright © 2022 ECE564. All rights reserved.
//

import Foundation
import UIKit

let p1 = DukePerson(firstName: "Richard", lastName: "Telford", whereFrom: "Chatham County, NC", netid: "rt113", degree: "NA", team: "NA", hobbies: ["reading", "golf", "swimming"], languages: ["Swift", "C", "C++"], gender: .Male, role: .Professor, userImg: "", email: "")
let p2 = DukePerson(firstName: "Wenxin", lastName: "Xu", whereFrom: "Chengdu, China", netid: "wx65", degree: "BS", team: "NA", hobbies: ["photography", "ultimate frisbee"], languages: ["Swift", "Java", "Python"], gender: .Female, role: .TA, userImg: "", email: "")
let p3 = DukePerson(firstName: "Anshu", lastName: "Dwibhashi", whereFrom: "Bangalore, India", netid: "ad353", degree: "BSE, MEng", team: "NA", hobbies: ["punk rock music", "playing guitar"], languages: ["Swift", "C/C++", "Python"], gender: .Male, role: .TA, userImg: "", email: "")
let p4 = DukePerson(firstName: "Andrew", lastName: "Krier", whereFrom: "Saint Paul, Minnesota", netid: "ak513ak513", degree: "BSE", team: "NA", hobbies: ["frisbee", "basketball"], languages: ["Swift", "Java", "Python"], gender: .Male, role: .TA, userImg:"", email: "")
let p5 = DukePerson(firstName: "Jonathan", lastName: "Browning", whereFrom: "Lexington, KY", netid: "jrb127", degree: "BS", team: "NA", hobbies: ["music", "reading", "tennis"], languages: ["Java", "Javascript", "Python"], gender: .Male, role: .Student, userImg:"", email: "")

// store data in array
let defaultData : [DukePerson] = [p1, p2, p3, p4, p5]

class DukeDatabase {
    static let fileManager = FileManager.default
    static let path: URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    static var display: [DukePerson] = defaultData
    static let ArchiveURL = path.appendingPathComponent("DukePersonJSONFile")
    
    // COME BACK TO THIS - MAY BE KEY TO DATA SAVING PROBLEM
    static func updateDatabase(with data: [DukePerson]) -> Bool {
        display = data

        print("updating the database")
        return saveDukePerson(display)
    }
    
    static func loadDukePerson() -> [DukePerson]? {
        let decoder = JSONDecoder()
        var list = [DukePerson]()
        let temp: Data
        do {
            temp = try Data(contentsOf: ArchiveURL)
        } catch let error as NSError {
            print(error)
            return nil
        }
        if let decoded = try? decoder.decode([DukePerson].self, from: temp) {
            list = decoded
            print("this is the list")
            print(list)
        }
        else {
            print("cannot load data")
        }
        display = list
        saveDukePerson(display)
        print("FUCK")
        return display
    }
    
    static func saveDukePerson(_ list: [DukePerson]) -> Bool {
        var outputData = Data()
        let encoder = JSONEncoder()
        print("do I ever get to this function")
        if let encoded = try? encoder.encode(list) {
            if String(data: encoded, encoding: .utf8) != nil {
                outputData = encoded
            }
            else {
                return false
                
            }
            do {
                try outputData.write(to: ArchiveURL)
                print("success")
            } catch let error as NSError {
                print (error)
                return false
            }
            return true
        }
        else {
            return false
            
        }
    }
    
    static func deletePerson(netID: String) -> Bool {
        return updateDatabase(with: display.filter { $0.netid != netID })
    }
    
    // find person function
    static func findPerson(first: String, last: String) -> (DukePerson?, String) {
        // clean up input string before looking
        let firstName = first.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = last.trimmingCharacters(in: .whitespacesAndNewlines)
        // look through each person in list and compare by name
        for person in display {
            if person.firstName.lowercased() == firstName.lowercased() && person.lastName.lowercased() == lastName.lowercased() {
                return (person, person.description)
            }
        }
        return (nil, "Could not find this person")
    }
    
    static func generalSearch(_ userSearch: String) -> [DukePerson] {
        return display.filter({ (DukePerson) -> Bool in
            let searchLower = userSearch.lowercased()
            if DukePerson.netid.lowercased().contains(searchLower) ||
                DukePerson.firstName.lowercased().contains(searchLower) ||
                DukePerson.lastName.lowercased().contains(searchLower) {
                    return true
            }
            return false
        })
    }

    // find person function
    static func findPersonNet(_ net: String) -> (DukePerson?, String) {
        // clean up input string before looking
        let netID = net.trimmingCharacters(in: .whitespacesAndNewlines)
        // look through each person in list and compare by name
        for person in display {
            if person.netid.lowercased() == netID.lowercased() {
                return (person, person.description)
            }
        }
        return (nil, "Could not find this person")
    }
    
    static func addUpdatePerson(first: String, last: String, whereFrom: String, netid: String, degree: String, team: String, hobbies: [String], languages: [String], gender: Gender, role: DukeRole, image: String, email: String) -> (String, DukePerson) {
        // asuume person does not exist
        var found : Bool = false
        var returnPerson: DukePerson? = nil
        // cleanup input
        let firstName = first.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = last.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = "\(netid)@duke.edu"
        // loop through data
        for person in display {
            // if they're in the database
            if person.firstName.lowercased() == firstName.lowercased() && person.lastName.lowercased() == lastName.lowercased() {
                person.whereFrom = whereFrom
                person.netid = netid
                person.deg = degree
                person.group = team
                person.hobbies = hobbies
                person.langs = languages
                person.gender = gender
                person.role = role
                person.userImg = image
                person.email = email
                returnPerson = person
                found = true
                break
            }
        }
        // if the person was found
        if found {
            print("the email is \(returnPerson!.email)")
            return ("The person has been updated", returnPerson!)
        }
        // if the person was not found and needs to be added
        else {
            returnPerson = DukePerson(firstName: firstName, lastName: lastName, whereFrom: whereFrom, netid: netid, degree: degree, team: team, hobbies: hobbies, languages: languages, gender: gender, role: role, userImg: image, email: email)
            display.append(returnPerson!)
            saveDukePerson(display)
            return ("The person has been added", returnPerson!)
        }
    }

    
    

    
    
    
}
