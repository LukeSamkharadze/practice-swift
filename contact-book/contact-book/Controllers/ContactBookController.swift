//
//  ContactBookController.swift
//  contact-book
//
//  Created by admin on 08.01.22.
//
	
import UIKit

class ContactBookController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var starButton: UIButton!
    
    private var contacts = [
        "S": [("Luka Samkharadze", true), ("Saba Samkharadze", false)],
        "M": [("Luka Mamkharadze", true)],
        "D": [("Luka Damkharadze", false)]
    ]
    
    var isShowingStarred = false
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ContactCell", bundle: nil), forCellReuseIdentifier: "ContactCell")
        tableView.register(UINib(nibName: "ContactHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "ContactHeader")
    }
    
    @IBAction func handleStarButtonClick(_ sender: UIButton) {
        isShowingStarred = !isShowingStarred
        
        if (isShowingStarred) {
            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        else {
            sender.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        tableView.reloadData()
        
    }
    
    @IBAction func handleNewContactButtonClick(_ sender: UIButton) {
        let alert = UIAlertController(title: "New Contact", message: nil, preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "First name"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Last name"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Phone number"
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in })
        
        alert.addAction(UIAlertAction(title: "Save", style: .default) { (action:UIAlertAction!) in
            let firstName = alert.textFields![0].text!
            let lastName = alert.textFields![1].text!
            
            if(firstName == "" || lastName == "") {
                return
            }
            
            let firstLetterInLastName = lastName[0...0]
            
            if(self.contacts[firstLetterInLastName] == nil) {
                self.contacts[firstLetterInLastName] = []
            }
            
            self.contacts[firstLetterInLastName]?.append((firstName + " " + lastName, false))
            
            self.tableView.reloadData()
        })

        self.present(alert, animated: true, completion: nil)
    }
}

extension ContactBookController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if(isShowingStarred) {
            return contacts.values.filter{$0.filter{$0.1==isShowingStarred}.count > 0}.count
        }
        else {
            return contacts.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var contactsToShow = contacts
        
        if(isShowingStarred) {
            contactsToShow = contacts.filter{$0.value.filter{$0.1==isShowingStarred}.count > 0}
        }
        
        let contactHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ContactHeader") as! ContactHeader
        
        let key = Array(contactsToShow.keys).sorted{$0 < $1}[section]
        
        contactHeader.label.text = key
        
        return contactHeader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var contactsToShow = contacts;
        
        if(isShowingStarred) {
            let filteredContacts = contacts.filter{$0.value.filter{$0.1==isShowingStarred}.count > 0}
            
            var starredContacts = [String:[(String, Bool)]]()
            
            filteredContacts.forEach {
                let starredContactsOnCurrentKey = $0.value.filter{$0.1==isShowingStarred}
                starredContacts[$0.key] = starredContactsOnCurrentKey
            }
            
            contactsToShow = starredContacts
        }
        
        let key = Array(contactsToShow.keys).sorted{$0 < $1}[section]
        
        return contactsToShow[key]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var contactsToShow = contacts
        
        if(isShowingStarred) {
            let filteredContacts = contacts.filter{$0.value.filter{$0.1==isShowingStarred}.count > 0}
            
            var starredContacts = [String:[(String, Bool)]]()
            
            filteredContacts.forEach {
                let starredContactsOnCurrentKey = $0.value.filter{$0.1==isShowingStarred}
                starredContacts[$0.key] = starredContactsOnCurrentKey
            }
            
            contactsToShow = starredContacts
        }
        
        let contactCell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell

        let key = Array(contactsToShow.keys).sorted{$0 < $1}[indexPath.section]

        let firstName = String(contactsToShow[key]![indexPath.row].0.split(separator: " ")[0])
        let lastName = String(contactsToShow[key]![indexPath.row].0.split(separator: " ")[1])

        let boldAttributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: contactCell.label.font.pointSize)]

        contactCell.label.attributedText =
            NSMutableAttributedString(string:String(firstName) + " ") +
            NSMutableAttributedString(string:lastName[0...0], attributes:boldAttributes) +
            NSMutableAttributedString(string:String(lastName[1..<(lastName.count)]))

        contactCell.isStarred = contacts[key]![indexPath.row].1
        contactCell.starClickedDelegate = { [weak self] in
            self?.contacts[key]![indexPath.row].1 = !(self?.contacts[key]![indexPath.row].1)!
            self?.tableView.reloadData()
        }
        
        return contactCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            var contactsShown = contacts
            
            if(isShowingStarred) {
                let filteredContacts = contacts.filter{$0.value.filter{$0.1==isShowingStarred}.count > 0}
                
                var starredContacts = [String:[(String, Bool)]]()
                
                filteredContacts.forEach {
                    let starredContactsOnCurrentKey = $0.value.filter{$0.1==isShowingStarred}
                    starredContacts[$0.key] = starredContactsOnCurrentKey
                }
                
                contactsShown = starredContacts
            }
            
            let key = Array(contactsShown.keys).sorted{$0 < $1}[indexPath.section]
            
            let indexInContacts = contacts[key]!.firstIndex(where: {$0 == contactsShown[key]![indexPath.row]})
            
            contacts[key]!.remove(at: indexInContacts!)
            
            contacts = contacts.filter {$0.value.count > 0}
            
            tableView.reloadData()
        }
    }
}


