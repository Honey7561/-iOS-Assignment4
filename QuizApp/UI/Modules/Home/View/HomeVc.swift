//
//  HomeVc.swift
//  NewsApp
//
//  Created by user238851 on 13/04/24.
//

import UIKit

final class HomeVc: ViewController<HomeVm> {
    //MARK: - @IBOutlets
    @IBOutlet weak var clvHome: UICollectionView!
    
    //MARK: - Properties
    private var disposeBag = Bag()
    private var input = AppSubject<HomeVm.Input>()
    private var currentScore: Int = 0
    
    //MARK: - Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HomeVm()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        input.send(.getData)
    }
    
    override func setUi() {
        super.setUi()
        
        clvHome.delegate = self
        clvHome.dataSource = self
        clvHome.register(R.nib.dataCell)
        configureCollectionView()
    }
    
    //MARK: - @IBActions
    
    //MARK: - Functions
    private func bindViewModel() {
        viewModel?.transform(input: input.eraseToAnyPublisher()).weekSink(self) { strongSelf, event in
            switch event {
            case let .loader(isLoading):
                isLoading ? strongSelf.showHUD() : strongSelf.hideHUD()
            case let .showError(msg):
                strongSelf.showAlert(msg: msg)
            case .dataGet:
                strongSelf.clvHome.reload()
            }
        }.store(in: &disposeBag)
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return AppLayout.shared.homeSection()
        }
        clvHome.setCollectionViewLayout(layout, animated: true)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension HomeVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.arrData.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DataCell = clvHome.deque(indexPath: indexPath)
        guard let model = viewModel?.arrData[indexPath.row] else { return .init() }
        cell.model = model
        cell.lblCount.text = "\(indexPath.row + 1)/\(viewModel?.arrData.count ?? 0)"
        cell.btnNext.setTitle(indexPath.row == (viewModel?.arrData.count ?? 0) - 1 ? "Show Result" : "Next", for: .normal)
        cell.publisher.weekSink(self) { strongSelf, event in
            switch event {
            case .next(let isRightAns):
                strongSelf.currentScore = isRightAns ? strongSelf.currentScore + 1 : strongSelf.currentScore
                if indexPath.row < (strongSelf.viewModel?.arrData.count ?? 0) - 1 {
                    strongSelf.clvHome.scrollToItem(at: IndexPath(row: indexPath.row + 1, section: 0), at: .right, animated: true)
                } else {
                    strongSelf.viewModel?.router.show(sheet: .detail(score: "\(strongSelf.currentScore)/\(strongSelf.viewModel?.arrData.count ?? 0)"), presentationStyle: .fullScreen, transitionStyle: .crossDissolve)
                    UserDefaults.historyArr.append(strongSelf.currentScore)
                    strongSelf.clvHome.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
                }
            }
        }.store(in: &cell.bag)
        return cell
    }
}
