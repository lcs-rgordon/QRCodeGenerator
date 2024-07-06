import Cocoa
import PlaygroundSupport
import CoreImage

/// Creates a QR code for the given text
func qrImage(from providedText: String) -> CIImage? {
    guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
    let qrData = providedText.data(using: String.Encoding.utf8)
    qrFilter.setValue(qrData, forKey: "inputMessage")

    let qrTransform = CGAffineTransform(scaleX: 10, y: 10)
    return qrFilter.outputImage?.transformed(by: qrTransform)
}

final class QRViewController : NSViewController {
    let qrCodeColor = NSColor(red:0, green:0, blue:0, alpha:1.00)

    override func loadView() {
        guard let qrURLImage = qrImage(from: "Russell Gordon\nrgordon@lcs.on.ca") else { return }
        let context = CIContext()
        guard let qrCGImage = context.createCGImage(qrURLImage, from: CGRect(x: 0, y: 0, width: 325, height: 325)) else { return }
        let imageView = NSImageView(image: NSImage(cgImage: qrCGImage, size: NSSize(width: 200, height: 200)))
        self.view = imageView
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = QRViewController()
