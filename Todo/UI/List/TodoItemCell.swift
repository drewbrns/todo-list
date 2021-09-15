//
//  TodoItemCell.swift
//  Todo
//
//  Created by Drew Barnes on 13/09/2021.
//

import UIKit

class TodoItemCell: UITableViewCell {

    static let cellId = "TodoItemCell"

    private var activeColor = UIColor(
        red: 164 / 255,
        green: 31 / 255,
        blue: 36 / 255,
        alpha: 1
    )

    @IBOutlet weak private(set) var titleLabel: UILabel!
    @IBOutlet weak private(set) var subTitleLabel: UILabel!
    @IBOutlet weak private(set) var dateLabel: UILabel!
    @IBOutlet weak private(set) var checkMarkView: UIView!
    @IBOutlet weak private(set) var checkMarkInnerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        layoutCheckMarkViewAsRounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with vm: TodoItemViewModel?) {
        if let vm = vm {
            renderState(with: vm)
        } else {
            renderEmptyState()
        }
    }

    @IBAction func completeTaskButtonTapped(_ sender: Any) {
    }

    private func renderState(with vm: TodoItemViewModel) {
        self.titleLabel.text = vm.label
        self.subTitleLabel.text = vm.notes
        self.dateLabel.text = vm.dueDate
        renderCheckmarkView(isComplete: vm.isComplete)
    }

    private func renderEmptyState() {
        self.titleLabel.text = ""
        self.subTitleLabel.text = ""
        self.dateLabel.text = ""
        renderCheckmarkView(isComplete: false)
    }

    private func renderCheckmarkView(isComplete: Bool) {
        if isComplete {
            self.checkMarkInnerView.backgroundColor = activeColor
        } else {
            self.checkMarkView.backgroundColor = .white
        }
    }

    private func layoutCheckMarkViewAsRounded() {
        checkMarkView.layer.cornerRadius = 15
        checkMarkView.clipsToBounds = true
        checkMarkInnerView.layer.cornerRadius = 12
        checkMarkInnerView.clipsToBounds = true
    }
}
