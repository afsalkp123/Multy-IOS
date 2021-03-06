//
//  EPContactCell.swift
//  EPContacts
//
//  Created by Prabaharan Elangovan on 13/10/15.
//  Copyright © 2015 Prabaharan Elangovan. All rights reserved.
//

import UIKit

class EPContactCell: UITableViewCell {

    @IBOutlet weak var contactTextLabel: UILabel!
    @IBOutlet weak var contactDetailTextLabel: UILabel!
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactInitialLabel: UILabel!
    @IBOutlet weak var contactContainerView: UIView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var contact: EPContact?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = UITableViewCellSelectionStyle.none
        contactContainerView.layer.masksToBounds = true
        contactContainerView.layer.cornerRadius = contactContainerView.frame.size.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateInitialsColorForIndexPath(_ indexpath: IndexPath) {
        //Applies color to Initial Label
        let colorArray = [EPGlobalConstants.Colors.amethystColor,EPGlobalConstants.Colors.asbestosColor,EPGlobalConstants.Colors.emeraldColor,EPGlobalConstants.Colors.peterRiverColor,EPGlobalConstants.Colors.pomegranateColor,EPGlobalConstants.Colors.pumpkinColor,EPGlobalConstants.Colors.sunflowerColor]
        let randomValue = (indexpath.row + indexpath.section) % colorArray.count
        contactInitialLabel.backgroundColor = colorArray[randomValue]
    }
 
    func updateContactsinUI(_ contact: EPContact, indexPath: IndexPath, subtitleType: SubtitleCellValue) {
        self.contact = contact
        //Update all UI in the cell here
        self.contactTextLabel?.text = contact.displayName()
        updateSubtitleBasedOnType(subtitleType, contact: contact)
        if contact.thumbnailProfileImage != nil {
            self.contactImageView?.image = contact.thumbnailProfileImage
            self.contactImageView.isHidden = false
            self.contactInitialLabel.isHidden = true
        } else {
            self.contactInitialLabel.text = contact.contactInitials()
            updateInitialsColorForIndexPath(indexPath)
            self.contactImageView.isHidden = true
            self.contactInitialLabel.isHidden = false
        }
    }
    
    func updateSubtitleBasedOnType(_ subtitleType: SubtitleCellValue , contact: EPContact) {
        switch subtitleType {
        case .phoneNumber:
            let phoneNumberCount = contact.phoneNumbers.count
            
            if phoneNumberCount == 1  {
                contactDetailTextLabel.text = "\(contact.phoneNumbers[0].phoneNumber)"
            }
            else if phoneNumberCount > 1 {
                contactDetailTextLabel.text = "\(contact.phoneNumbers[0].phoneNumber) and \(contact.phoneNumbers.count-1) more"
            }
            else {
                contactDetailTextLabel.text = EPGlobalConstants.Strings.phoneNumberNotAvaialable
            }
        case .email:
            let emailCount = contact.emails.count
        
            if emailCount == 1  {
                contactDetailTextLabel.text = "\(contact.emails[0].email)"
            }
            else if emailCount > 1 {
                contactDetailTextLabel.text = "\(contact.emails[0].email) and \(contact.emails.count-1) more"
            }
            else {
                contactDetailTextLabel.text = EPGlobalConstants.Strings.emailNotAvaialable
            }
        case .birthday:
            contactDetailTextLabel.text = contact.birthdayString
        case .organization:
            contactDetailTextLabel.text = contact.company
        case .cryptoAddresses:
            let subtitle = contact.addresses.map { $0.address }.joined(separator: ", ")
            contactDetailTextLabel.text = subtitle
            
            if subtitle.isEmpty {
                topConstraint.constant = 18
            } else {
                topConstraint.constant = 10
            }
        }
    }
}
