//
//  TableViewController.swift
//  ECE564_HW
//
//  Created by Jonathan Browning on 2/21/22.
//  Copyright © 2022 ECE564. All rights reserved.
//

import UIKit

class PersonViewCell: UITableViewCell {
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personNameView: UILabel!
    @IBOutlet weak var personDescriptionView: UILabel!
    
}

class PersonTableViewController: UITableViewController, URLSessionDownloadDelegate, UISearchBarDelegate {

    var personList: [String: [DukePerson]] = [:]
    var searchRes: [String: [DukePerson]] = [:]
    var searchActive = false
    
    var calledSwipe = false
    var standinPath: IndexPath = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    let progressBar = UIProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ECE564 Class Directory"
       
        let totalWidth : CGFloat = UIScreen.main.bounds.width
        
        view.addSubview(progressBar)
        progressBar.isHidden = true
        progressBar.frame = CGRect(x: 0, y: 0, width: totalWidth, height: 0)
        progressBar.transform = CGAffineTransform(scaleX: 1, y: 1.5)
        progressBar.progressTintColor = .purple
        
        searchBar.delegate = self
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search by netID or name", attributes: [.foregroundColor: UIColor.gray])
        
//        tableView.register(PersonViewCell.self, forCellReuseIdentifier: "PersonViewCell")
        tableView.delegate = self
        
        loadInitialData()
        serverDataAlert()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchBar.text = ""
        updateInfoView()
    }
    
    func loadInitialData() {
        _ = DukeDatabase.loadDukePerson()
        self.updateInfoView()
    }
    
    @objc func serverDataAlert() {
        let alert = UIAlertController(title: "Load data from server", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { action in
            self.progressBar.isHidden = false
            self.progressBar.setProgress(0, animated: false)
            REST(delegate: self).download()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func downloadClicked(_ sender: Any) {
//        REST(delegate: self).download()
        self.serverDataAlert()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let frac = Float(100*totalBytesWritten/totalBytesExpectedToWrite) / 100
        DispatchQueue.main.async {
            self.progressBar.setProgress(frac, animated: false)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask:URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let data = try? Data(contentsOf: location) else { return }
//        let jsonString = String(data: data, encoding: .utf8)
//        print("this is the data")
//        print(jsonString!)
        guard let loaded = parseFromJSON(input: data) else { return }
        if DukeDatabase.updateDatabase(with: loaded) {
            print("download successful")
            self.progressBar.isHidden = true
            self.updateInfoView()
        }
        else {
            print("download unsuccessful")
        }
//        print(loaded)
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
    
    private func getKeyFromSection(section: Int) -> String {
        let data = searchActive ? searchRes : personList
        let allKeys = Array(data.keys)
        let key = allKeys[section]
        return key
    }
    
    func groupPeople(input: [DukePerson]) -> [String: [DukePerson]] {
        var teamDic: [String: [DukePerson]] = [:]
        for person in input {
            switch person.role {
            case .Student:
                if person.group == "" || person.group == "NA" || person.group == "N/A" || person.group == "TBD" || person.group == "Not Applicable, or NA" || person.group.lowercased() == "none" {
                    // group students with placeholder team name together
                    teamDic.updateValue(teamDic["Student", default: []] + [person], forKey: "Student")
                } else {
                    teamDic.updateValue(teamDic[person.group, default: []] + [person], forKey: person.group)
                }
            case .Professor:
                teamDic.updateValue(teamDic["Professor", default: []] + [person], forKey: "Professor")
                break
            case .TA:
                teamDic.updateValue(teamDic["Teaching Assistant", default: []] + [person], forKey: "Teaching Assistant")
                break
            case .Other:
                teamDic.updateValue(teamDic["Other", default: []] + [person], forKey: "Other")
                break
            }
        }
        return teamDic
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return searchActive ? searchRes.count : personList.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return getKeyFromSection(section: section)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = searchActive ? searchRes : personList
        
        print("the section in question is \(section)")
        let key = getKeyFromSection(section: section)
        
        print("the key is " + key)
        guard let rowNum = data[key]?.count else {
            return 0
        }
        
        return rowNum
    }
    
    // configuring the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = searchActive ? searchRes : personList
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonViewCell", for: indexPath) as! PersonViewCell
        
        let key = getKeyFromSection(section: indexPath.section)
        let tempPerson:DukePerson = data[key]![indexPath.row]
        
        cell.personImageView.image = getImageFromBase64(from: tempPerson.userImg)
        cell.personNameView.text = "\(tempPerson.firstName) \(tempPerson.lastName)"
        cell.personDescriptionView.text = tempPerson.description
        
        return cell
    }
    
    // swiping action - adapted from apple developer site
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let key = getKeyFromSection(section: indexPath.section)
        guard let person = personList[key]?[indexPath.row] else {
            return nil
        }
        
        // delete action
        let delete = UIContextualAction(style: .normal, title: "Delete") { [self] _,_,_ in
            if DukeDatabase.deletePerson(netID: person.netid) {
                self.updateInfoView()
            }
        }
        delete.backgroundColor = .systemRed
        
        // edit action
        let edit = UIContextualAction(style: .normal, title: "Edit") { [self] _,_,_ in
            self.calledSwipe = true
            self.standinPath = indexPath
            self.tableView(self.tableView, didSelectRowAt: indexPath)
        }
        edit.backgroundColor = .systemBlue

        let configuration = UISwipeActionsConfiguration(actions: [edit, delete])
        configuration.performsFirstActionWithFullSwipe = false

        return configuration
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "fromList", sender: self)
    }
    
    // prepare display person for selected cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navViewController = segue.destination as? UINavigationController,
           let destination = navViewController.viewControllers.first as? InformationViewController {
            if segue.identifier == "fromList" {
                let data = searchActive ? searchRes : personList
                let indexPath = self.tableView.indexPathForSelectedRow ?? self.standinPath
                let key = getKeyFromSection(section: indexPath.section)
                let person = data[key]![indexPath.row]
                destination.displayPerson = person
                destination.readOnly = !self.calledSwipe
                print("THE PERSON IS ")
                print(person)
//                destination.isReadOnly = true
            }
            if segue.identifier == "fromListAdd" {
//                destination.displayPerson = nil
            }
        }
    }
    
    // search bar change logic -- pulled from Apple Developer Site
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    // COULD DELETE
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange userSearch: String) {
        searchRes = groupPeople(input: DukeDatabase.generalSearch(userSearch))
        searchActive = searchRes.count != 0
        self.tableView.reloadData()
    }
    
    func updateInfoView() {
        self.personList = groupPeople(input: DukeDatabase.display)
        self.calledSwipe = false
        self.tableView.reloadData()
    }
    
    func getImageFromBase64(from base64String: String) -> UIImage? {
        let imageData = Data.init(base64Encoded: base64String)
        if imageData == nil {
            return nil
        }
        let image = UIImage(data: imageData!)
        return image
    }

}



