//
//  ViewController.swift
//  KarmaScore
//
//  Created by user238851 on 13/04/24.
//

import UIKit

class ViewController<T: ViewModel>: UIViewController {
    // MARK: - @IBOutlet
    var viewModel: T?

    // MARK: - Properties

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUi()
    }

    // MARK: - @IBAction

    // MARK: - Functions
    func setUi() {
        navigationController?.navigationBar.isHidden = true
    }
}
