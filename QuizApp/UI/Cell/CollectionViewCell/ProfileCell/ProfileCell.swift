//
//  ProfileCell.swift
//  NewsApp
//
//  Created by user238851 on 13/04/24.
//

import UIKit

final class ProfileCell: UICollectionViewCell {
    //MARK: - @IBOutlets
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    
    //MARK: - Properties
    
    //MARK: - Life-Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgProfile.layer.cornerRadius = imgProfile.frame.height / 2
        setData()
    }
    
    //MARK: - @IBActions
    @IBAction func didTapButtonEditProfile(_ sender: Any) {
    }
    
    @IBAction func didTapButtonWebsite(_ sender: Any) {
    }
    
    //MARK: - Functions
    private func setData() {
        imgProfile.imageWith()
        lblName.text = UserDefaults.userName
    }
}
