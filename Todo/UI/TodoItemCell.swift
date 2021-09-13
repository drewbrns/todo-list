//
//  TodoItemCell.swift
//  Todo
//
//  Created by Drew Barnes on 13/09/2021.
//

import UIKit

class TodoItemCell: UITableViewCell {

    static let cellId = String(describing: self)

    private var activeColor = UIColor(
        red: 164 / 255,
        green: 31 / 255,
        blue: 36 / 255,
        alpha: 1
    )

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var checkMarkView: UIView!
    @IBOutlet weak var checkMarkInnerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkMarkView.layer.cornerRadius = 15
        checkMarkView.clipsToBounds = true
        checkMarkInnerView.layer.cornerRadius = 12
        checkMarkInnerView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func completeTaskButtonTapped(_ sender: Any) {
    }

    private func renderCheckmarkView(isComplete: Bool) {
        if isComplete {
            self.checkMarkInnerView.backgroundColor = activeColor
        } else {
            self.checkMarkView.backgroundColor = .white
        }
    }
}
