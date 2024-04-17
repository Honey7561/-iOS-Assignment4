//
//  DataCell.swift
//  APICalling
//
//  Created by user238851 on 13/04/24.
//

import UIKit

enum DataCellEvent {
    case next(isRightAns: Bool)
}

final class DataCell: UICollectionViewCell {
    //MARK: - @IBOutlets
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblEmoji: UILabel!
    @IBOutlet weak var btnTrue: UIButton!
    @IBOutlet weak var btnFalse: UIButton!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    
    //MARK: - Properties
    var model: ResultModel? {
        didSet {
            loadData()
        }
    }
    var bag = Bag()
    var subJect = AppSubject<DataCellEvent>()
    var publisher: AppAnyPublisher<DataCellEvent> {
        subJect.eraseToAnyPublisher()
    }
    private var isRightAns: Bool = false
    
    //MARK: - Life-Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetUI()
        bag = Bag()
    }
    
    //MARK: - @IBActions
    @IBAction func btnAnsTap(_ sender: UIButton) {
        btnTrue.isUserInteractionEnabled = false
        btnFalse.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.2) {
            self.lblEmoji.isHidden = false
            if sender.tag == 0 {
                self.handleAnswer(isTrue: true, tag: 0)
            } else {
                self.handleAnswer(isTrue: false, tag: 1)
            }
        }
    }
    
    @IBAction func btnNextTap(_ sender: Any) {
        subJect.send(.next(isRightAns: isRightAns))
    }
    
    //MARK: - Functions
    private func loadData() {
        guard let model = model else { return }
        
        lblQuestion.text = model.question
    }
    
    private func resetUI() {
        lblEmoji.isHidden = true
        btnTrue.isUserInteractionEnabled = true
        btnFalse.isUserInteractionEnabled = true
        btnTrue.setTitleColor(.black, for: .normal)
        btnTrue.backgroundColor = .clear
        btnFalse.setTitleColor(.black, for: .normal)
        btnFalse.backgroundColor = .clear
        lblEmoji.text = ""
        isRightAns = false
    }
    
    private func handleAnswer(isTrue: Bool, tag: Int) {
        guard let correctAnswer = model?.correctAnswer?.uppercased() else { return }
        let selectedAnswer = isTrue ? "True" : "False"
        if tag == 0 {
            if selectedAnswer.uppercased() == correctAnswer {
                btnTrue.setTitleColor(.black, for: .normal)
                btnTrue.backgroundColor = .systemGreen
                isRightAns = true
                lblEmoji.text = "😍"
            } else {
                btnFalse.setTitleColor(.black, for: .normal)
                btnFalse.backgroundColor = .systemGreen
                btnTrue.setTitleColor(.white, for: .normal)
                btnTrue.backgroundColor = .red
                isRightAns = false
                lblEmoji.text = "😔"
            }
        } else {
            if selectedAnswer.uppercased() == correctAnswer {
                btnFalse.setTitleColor(.black, for: .normal)
                btnFalse.backgroundColor = .systemGreen
                isRightAns = true
                lblEmoji.text = "😍"
            } else {
                btnTrue.setTitleColor(.black, for: .normal)
                btnTrue.backgroundColor = .systemGreen
                btnFalse.setTitleColor(.white, for: .normal)
                btnFalse.backgroundColor = .red
                isRightAns = false
                lblEmoji.text = "😔"
            }
        }
    }
}
