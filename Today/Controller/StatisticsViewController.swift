import UIKit

class StatisticsViewController: UIViewController {
    
    //MARK: - Variables
    private var reminder: [Reminder] = []
    private let dropDownOptions = ["Option 1", "Option 2", "Option 3"]
    
    
    //MARK: - UI Components
    private let scrollView = scrollView()
    private let contentView = contentView()
    private let dailyPerfContentView = contentView()
    private let titleLabel = labelText()
    private lazy var dropDownBtn = dropDownButton()
    var dropDownStackView: UIStackView?

    
    //MARK: - LifeCycle
    init(reminder: [Reminder]) {
        self.reminder = reminder
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backPrimary
        updateUI()
        setupUI()
    }
    
    
    //MARK: - Selectors
    private func updateUI() {
        titleLabel.text = "daily perfomance".uppercased()
        dropDownBtn.addTarget(self, action: #selector(didTapDropDownButton), for: .touchUpInside)
        
        dailyPerfContentView.backgroundColor = .backPrimary
        dailyPerfContentView.layer.cornerRadius = 10
        dailyPerfContentView.backgroundColor = .todayListCellBackground
    }
    
    func createDropDownMenu() {
        dropDownStackView = UIStackView()
        dropDownStackView?.axis = .vertical
        dropDownStackView?.alignment = .fill
        dropDownStackView?.distribution = .fillEqually
        dropDownStackView?.spacing = 5
        dropDownStackView?.translatesAutoresizingMaskIntoConstraints = false
        dropDownStackView?.backgroundColor = .backTh

        
        for option in dropDownOptions {
            let optionButton = UIButton()
            optionButton.setTitle(option, for: .normal)
            optionButton.setTitleColor(.black, for: .normal)
            optionButton.addTarget(self, action: #selector(didSelectOption(_:)), for: .touchUpInside)
            dropDownStackView?.addArrangedSubview(optionButton)
        }
        
        view.addSubview(dropDownStackView!)

        NSLayoutConstraint.activate([
            dropDownStackView!.topAnchor.constraint(equalTo: dropDownBtn.bottomAnchor, constant: 5),
            dropDownStackView!.leadingAnchor.constraint(equalTo: dropDownBtn.leadingAnchor, constant: -10),
            dropDownStackView!.trailingAnchor.constraint(equalTo: dropDownBtn.trailingAnchor, constant: 10)
        ])
    }
    
    @objc func didTapDropDownButton() {
        if dropDownStackView == nil {
            createDropDownMenu()
        } else {
            dropDownStackView?.isHidden = !dropDownStackView!.isHidden
        }
    }
    
    @objc func didSelectOption(_ sender: UIButton) {
        dropDownBtn.setTitle(sender.currentTitle, for: .normal)
        dropDownStackView?.isHidden = true
    }
}


//MARK: Setup Constrain
extension StatisticsViewController {
    private func setupUI() {
        setupScrollView()
        setupTitleLabel()
        setupDaylyPerfContentView()
        setupDailyStatisticsView()
        setupDropDownButton()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 800),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25)
        ])
    }
    
    private func setupDaylyPerfContentView() {
        contentView.addSubview(dailyPerfContentView)
        
        NSLayoutConstraint.activate([
            dailyPerfContentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            dailyPerfContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dailyPerfContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dailyPerfContentView.heightAnchor.constraint(equalToConstant: 330)
        ])
    }
    
    private func setupDailyStatisticsView() {
        let barChartView = DailyStatisticsView(frame: CGRect(x: 0, y: 20, width: view.frame.width - 40, height: 280))
        barChartView.backgroundColor = .clear
    
        barChartView.layer.cornerRadius = 10
        dailyPerfContentView.addSubview(barChartView)
        
        barChartView.taskCounts = [2, 4, 1, 5, 0, 3, 2]
    }
    
    private func setupDropDownButton() {
        contentView.addSubview(dropDownBtn)
        
        NSLayoutConstraint.activate([
            dropDownBtn.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 2.5),
            dropDownBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
        ])
    }
}


//MARK: - Make UI
extension StatisticsViewController {
    private static func scrollView() -> UIScrollView {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = true
        view.alwaysBounceVertical = true
        view.backgroundColor = .backPrimary
        return view
    }
    
    private static func contentView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backPrimary
        return view
    }
    
    private static func labelText() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .body
        label.textColor = .labelPrimary
        return label
    }
    
    private func dropDownButton() -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(.labelPrimary, for: .normal)
        btn.setTitle("Option 1", for: .normal)
        return btn
    }
    
    private func dropDownStaskView() -> UIStackView {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 5
        return view
    }
}
