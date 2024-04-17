//
//  ExploreVc.swift
//  NewsApp
//
//  Created by user238851 on 13/04/24.
//

import UIKit

final class ExploreVc: ViewController<ExploreVm> {
    //MARK: - @IBOutlets
    @IBOutlet weak var clvExplore: UICollectionView!
    
    //MARK: - Properties
    private var disposeBag = Bag()
    private var input = AppSubject<ExploreVm.Input>()
    
    //MARK: - Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ExploreVm()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        clvExplore.reload()
    }
    
    override func setUi() {
        super.setUi()
        
        clvExplore.delegate = self
        clvExplore.dataSource = self
        clvExplore.register(R.nib.profileCell)
        clvExplore.register(R.nib.historyCell)
        clvExplore.register(R.nib.headerCell, forSupplementaryViewOfKind: "Header")
        configureCollectionView()
    }
    
    //MARK: - @IBActions
    
    //MARK: - Functions
    private func bindViewModel() {
        viewModel?.transform(input: input.eraseToAnyPublisher()).weekSink(self) { strongSelf, event in
            switch event {
            case .loader(let isLoading):
                isLoading ? strongSelf.showHUD() : strongSelf.hideHUD()
            case .showError(let msg):
                strongSelf.showAlert(msg: msg)
            }
        }.store(in: &disposeBag)
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0: return AppLayout.shared.profileSection()
            case 1: return AppLayout.shared.historySection()
            default: return AppLayout.shared.profileSection()
            }
        }
        clvExplore.setCollectionViewLayout(layout, animated: true)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ExploreVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return UserDefaults.historyArr.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell: ProfileCell = clvExplore.deque(indexPath: indexPath)
            let score = UserDefaults.historyArr.reduce(0, +)
            cell.lblScore.text = "Your Total Score Is \(score)."
            return cell
        case 1:
            let cell: HistoryCell = clvExplore.deque(indexPath: indexPath)
            cell.lblTitle.text = "You Previos Score Is \(UserDefaults.historyArr[indexPath.row])/10."
            return cell
        default: return .init()
        }
    }
    
    func collectionView(_: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "Header" {
            guard let header = clvExplore.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: R.nib.headerCell, for: indexPath) else {
                return .init()
            }
            header.lblTitle.text = "History (\(UserDefaults.historyArr.count))"
            return header
        }
        return UICollectionReusableView()
    }
}
