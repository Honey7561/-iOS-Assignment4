//
//  DetailVc.swift
//  APICalling
//
//  Created by user238851 on 13/04/24.
//

import UIKit

final class DetailVc: ViewController<DetailVm> {
    //MARK: - @IBOutlets
    @IBOutlet weak var lblScore: UILabel!
    
    //MARK: - Properties
    var score: String?
    
    //MARK: - Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = DetailVm()
    }
    
    override func setUi() {
        super.setUi()
        
        lblScore.text = score
    }
    
    //MARK: - @IBActions
    @IBAction func didTapButtonGotIt(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapButtonBack(_ sender: Any) {
        dismiss(animated: true)
    }
    
    //MARK: - Functions
}
