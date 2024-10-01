//
//  ViewController.swift
//  Sybrin.iOS.Common.Showcase
//
//  Created by Nico Celliers on 2020/08/25.
//  Copyright © 2020 Sybrin Systems. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Private Properties
    // IBActions
    @IBOutlet weak var featureTextField: UITextField!
    @IBOutlet weak var textOutput: UITextView!
    
    // Licensing Test
    private final var licenseHandler: LicenseHandler = LicenseHandler()
    private final var scanCountTotal: Int = 0
    
    private final var attemptUpdateSuccessUsageCount: Int = 0
    private final var confirmedUpdateSuccessUsageCount: Int = 0
    
    private final var updateUsageCountFailed: Int = 0
    
    // Overlay Test
    private final var successCallback: ((_ image: UIImage) -> Void)!
    private final var failureCallback: (() -> Void)!
    
    // MARK: Public Properties
    // Measuring Performance
    public static var startupStartTime: Double = 0
    public static var startupEndTime: Double = 0
    public static var closingStartTime: Double = 0
    public static var closingEndTime: Double = 0
    public static var startupTimes: [Double] = []
    public static var closingTimes: [Double] = []
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        successCallback = { [weak self] (image: UIImage) in
            guard let self = self else { return }
            self.scanCountTotal += 1
            self.attemptUpdateSuccessUsageCount += 1
            
            switch self.licenseHandler.updateCount(f: self.featureTextField.text ?? "") {
                case .success(_):
                    self.confirmedUpdateSuccessUsageCount += 1
                    "License update count success".addTo(textOutput: self.textOutput, view: self.view)
                case .failure(_):
                    self.updateUsageCountFailed += 1
                    "License update count failed".addTo(textOutput: self.textOutput, view: self.view)
            }
            
            GalleryHandler.saveImage(image, name: "Test_\(self.scanCountTotal)") { (path) in
                "Save image at \"\(path)\" ".addTo(textOutput: self.textOutput)
            }
        }
        failureCallback = {
            "Scan failed".addTo(textOutput: self.textOutput, view: self.view)
        }
        
        OverlayViewController.successMockCallback = successCallback
        OverlayViewController.failureMockCallback = failureCallback
    }
    
    override func viewWillAppear(_ animated: Bool) {

        if ViewController.closingStartTime > 0 {
            ViewController.closingEndTime = Date().timeIntervalSince1970 * 1000
            let time = ViewController.closingEndTime - ViewController.closingStartTime
            "Closing took \(time)ms".addTo(textOutput: self.textOutput, view: self.view)
            ViewController.closingTimes.append(time)
        }
        
    }
    
    // MARK: Buttons
    @IBAction func clearTextButtonTapped(_ sender: Any) {
        textOutput.text = ""
    }
    
    @IBAction func initializeSybrinLicenseButtonTapped(_ sender: Any) {
        let result: Result<Bool, LicenseError> = licenseHandler.initialize(with: CommonHelper.sybrinLicenseKey)
        
        CommonHelper.executeWithDeveloperAccess { [weak self] in
            guard let self = self else { return }
            
            self.licenseHandler.sdkType = .Identity
        }
        
        switch result {
        case .success(_):
            "License initialization success".addTo(textOutput: self.textOutput, view: self.view)
        case .failure(let error):
            "License initialization failed: \(error)".addTo(textOutput: self.textOutput, view: self.view)
        }
    }
    
    @IBAction func initializeClientLicenseButtonTapped(_ sender: Any) {
        let result: Result<Bool, LicenseError> = licenseHandler.initialize(with: CommonHelper.clientLicenseKey)
        
        CommonHelper.executeWithDeveloperAccess { [weak self] in
            guard let self = self else { return }
            
            self.licenseHandler.sdkType = .Identity
        }
        
        switch result {
        case .success(_):
            "License initialization success".addTo(textOutput: self.textOutput, view: self.view)
        case .failure(let error):
            "License initialization failed: \(error)".addTo(textOutput: self.textOutput, view: self.view)
        }
    }
    
    @IBAction func validateLicenseOnlineButtonTapped(_ sender: Any) {
        let result: Result<Bool, LicenseError> = licenseHandler.validateLicense(forceOnlineValidation: true)
        
        switch result {
        case .success(_):
            "License validation online success".addTo(textOutput: self.textOutput, view: self.view)
        case .failure(let error):
            "License validation online failed: \(error)".addTo(textOutput: self.textOutput, view: self.view)
        }
    }
    
    @IBAction func validateLicenseButtonTapped(_ sender: Any) {
        let result: Result<Bool, LicenseError> = licenseHandler.validateLicense()
        
        switch result {
        case .success(_):
            "License validation success".addTo(textOutput: self.textOutput, view: self.view)
        case .failure(let error):
            "License validation failed: \(error)".addTo(textOutput: self.textOutput, view: self.view)
        }
    }
    
    @IBAction func resetLicenseButtonTapped(_ sender: Any) {
        licenseHandler = LicenseHandler()
        
        scanCountTotal = 0
        
        attemptUpdateSuccessUsageCount = 0
        confirmedUpdateSuccessUsageCount = 0
        
        updateUsageCountFailed = 0
    }
    
    @IBAction func updateCountButtonTapped(_ sender: Any) {
        scanCountTotal += 1
        attemptUpdateSuccessUsageCount += 1
        
        switch licenseHandler.updateCount(f: featureTextField.text ?? "") {
        case .success(_):
            confirmedUpdateSuccessUsageCount += 1
            "License update count success".addTo(textOutput: self.textOutput, view: self.view)
        case .failure( let error):
            updateUsageCountFailed += 1
            "License update count failed: \(error)".addTo(textOutput: self.textOutput, view: self.view)
        }
    }
    
    @IBAction func licenseResultsButtonTapped(_ sender: Any) {
        "LICENSE RESULTS:".addTo(textOutput: self.textOutput)
        "Total scans: \(scanCountTotal)".addTo(textOutput: self.textOutput)
        
        "Attempted success scans: \(attemptUpdateSuccessUsageCount)".addTo(textOutput: self.textOutput)
        "Confirmed success scans: \(confirmedUpdateSuccessUsageCount)".addTo(textOutput: self.textOutput)
        
        "Confirmed failed scans: \(updateUsageCountFailed)".addTo(textOutput: self.textOutput)
    }
    
    @IBAction func performanceResultsButtonTapped(_ sender: Any) {
        "PERFORMANCE RESULTS:".addTo(textOutput: self.textOutput)
        "Startup time count: \(ViewController.startupTimes.count)".addTo(textOutput: self.textOutput)
        "Startup time average: \(ViewController.startupTimes.avg())".addTo(textOutput: self.textOutput)
        "Startup time highest: \(ViewController.startupTimes.max() ?? 0)".addTo(textOutput: self.textOutput)
        "Startup time lowest: \(ViewController.startupTimes.min() ?? 0)".addTo(textOutput: self.textOutput)
        "Startup time standard deviation: \(ViewController.startupTimes.std())".addTo(textOutput: self.textOutput)
        "".addTo(textOutput: self.textOutput)
        "Closing time count: \(ViewController.closingTimes.count)".addTo(textOutput: self.textOutput)
        "Closing time average: \(ViewController.closingTimes.avg())".addTo(textOutput: self.textOutput)
        "Closing time highest: \(ViewController.closingTimes.max() ?? 0)".addTo(textOutput: self.textOutput)
        "Closing time lowest: \(ViewController.closingTimes.min() ?? 0)".addTo(textOutput: self.textOutput)
        "Closing time standard deviation: \(ViewController.closingTimes.std())".addTo(textOutput: self.textOutput)
    }
    
    @IBAction func openOverlay(_ sender: Any) {
        ViewController.startupStartTime = Date().timeIntervalSince1970 * 1000
        self.performSegue(withIdentifier: "showOverlay", sender: self)
    }
    
}

// MARK: Extensions
extension Array where Element: FloatingPoint {
    
    func sum() -> Element {
        return self.reduce(0, +)
    }

    func avg() -> Element {
        return self.sum() / Element(self.count)
    }

    func std() -> Element {
        let mean = self.avg()
        let v = self.reduce(0, { $0 + ($1-mean)*($1-mean) })
        return sqrt(v / (Element(self.count) - 1))
    }

}

extension String {
    
    func addTo(textOutput: UITextView? = nil, view: UIView? = nil) {
        print(self)
        if let textOutput = textOutput {
            textOutput.text.append("\(textOutput.text.count > 0 ? "\n" : "")\(self)")
        }
        if let view = view {
            self.showToast(on: view)
        }
    }

}
