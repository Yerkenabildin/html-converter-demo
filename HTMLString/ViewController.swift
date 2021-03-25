import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        let btn1 = UIButton(type: .system)
        btn1.setTitle("GCD Test", for: .normal)
        btn1.frame = .init(x: 20, y: 50, width: 300, height: 44)
        btn1.addTarget(self, action: #selector(runGCDTest), for: .touchUpInside)
        view.addSubview(btn1)


        let btn2 = UIButton(type: .system)
        btn2.setTitle("Layout Test", for: .normal)
        view.addSubview(btn2)
        btn2.frame = .init(x: 20, y: 100, width: 300, height: 44)
        btn2.addTarget(self, action: #selector(runLayoutTest), for: .touchUpInside)
    }

    @objc
    private func runGCDTest() {
        print("\nRun GCD Test. Expected pos: 1")
        DispatchQueue.main.async {
            print("First DispatchQueue.main.async. Expected pos: 4")
        }
        print("Before HTML. Expected pos: 2")
        convertHTML()
        print("After HTML. Expected pos: 3")
        DispatchQueue.main.async {
            print("Second DispatchQueue.main.async. Expected pos: 5")
        }
    }


    @objc
    private func runLayoutTest() {
        print("\nRun Layout Test. Expected pos: 1")
        view.setNeedsLayout()
        print("Before HTML. Expected pos: 2")
        convertHTML()
        print("After HTML. Expected pos: 3")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews. Expected pos: 4")
    }

    private func convertHTML() {
        do {
            let html = "Text <br> <b>Bold Text</b>"
            let htmlData: Data! = html.data(using: .utf8)
            let result = try NSAttributedString(
                data: htmlData,
                options: [.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil
            )
            print("html length: \(html.count). converted result length: \(result.length)")
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
}

