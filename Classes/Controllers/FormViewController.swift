import UIKit

open class FormViewController: ViewController {
    public lazy var scrollView = ScrollView().edgesToSuperview(top: 0, leading: 0, trailing: 0).bottomToSuperview($bottom)
    public lazy var stackView = VStack().edgesToSuperview().width(to: .width, of: scrollView)
    
    open override func buildUI() {
        super.buildUI()
        _view.body { scrollView }
        scrollView.body { stackView }
        $keyboardHeight.listen { height in
            self.bottom = -1 * height
        }
    }
}
