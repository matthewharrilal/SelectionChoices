//
//  ViewController.swift
//  SelectionChoice
//
//  Created by Space Wizard on 8/6/24.
//

import UIKit

class SelectionChoiceViewController: UIViewController {
    
    private var selectedSet: Set<IndexPath> = Set()
    private let maxSelections: Int = 3
    
    private lazy var collectionView: UICollectionView = {
        let layout = ChoiceCollectionViewLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ChoiceCollectionViewCell.self, forCellWithReuseIdentifier: ChoiceCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setup()
    }
}

extension SelectionChoiceViewController {
    
    func setup() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
}

extension SelectionChoiceViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChoiceCollectionViewCell.identifier, for: indexPath) as? ChoiceCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

extension SelectionChoiceViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ChoiceCollectionViewCell else { return }
       
        if selectedSet.contains(indexPath) {
            selectedSet.remove(indexPath)
        } else if selectedSet.count < maxSelections {
            selectedSet.insert(indexPath)
        } else {
            print("Too many options selected")
            return
        }

        print("Index path \(indexPath) current selection status \(selectedSet.contains(indexPath))")
        cell.onHandleSelectionChoice(didSelect: selectedSet.contains(indexPath))
    }
}
