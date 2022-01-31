//
//  WeekDayPicker.swift
//  Weather
//
//  Created by Анастасия Лосикова on 21.01.2022.
//

import UIKit

@IBDesignable class WeekDayPicker: UIControl {
    var selectedDay: Day? = nil {
        didSet {
            self.updateSelectedDay()
            self.sendActions(for: .valueChanged)
        }
    }
    
    private var buttons = [UIButton]()
    private var stackView: UIStackView!
    
    private func setupView() {
        for day in Day.allDays {
            let button = UIButton(type: .system)
            button.setTitle(day.title, for: .normal)
            button.setTitleColor(.lightGray, for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.addTarget(self, action: #selector(selectDay(_:)), for: .touchUpInside)
            self.buttons.append(button)
        }
        
        stackView = UIStackView(arrangedSubviews: self.buttons)
        
        self.addSubview(stackView)
        
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
    
    private func updateSelectedDay() {
        for (index, button) in self.buttons.enumerated() {
            guard let day = Day(rawValue: index) else {return}
            button.isSelected = day == self.selectedDay
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    @objc private func selectDay(_ sender: UIButton) {
        guard let index = self.buttons.index(of: sender) else {return}
        guard let day = Day(rawValue: index) else {return}
        self.selectedDay = day
    }
}
