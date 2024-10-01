//
//  OverlayViewController.swift
//  Sybrin.iOS.Common.Showcase
//
//  Created by Default on 2020/11/04.
//  Copyright © 2020 Sybrin Systems. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

final class OverlayViewController: UIViewController {
    
    // MARK: Private Properties
    // Camera
    private final var CameraHandlerObj: CameraHandler!
    private final var CameraView, BusyIndicator: UIView!
    private final var MockSuccess, MockFailure: UIButton!
    
    private final var PreviousFrameCount = 0
    private final var PreviousFPSCount: Double = Date().timeIntervalSince1970 * 1000
    private final var LastFrame: CMSampleBuffer?
    
    // Frame Counter
    private final var FrameCount: Int = 0
    
    // MARK: Public Properties
    public static var failureMockCallback: (() -> Void)? = nil
    public static var successMockCallback: ((_ image: UIImage) -> Void)? = nil
    
    // MARK: Overrides
    override final func viewDidLoad() {
        super.viewDidLoad()
        
        AddCameraView()
    }
    
    public final override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        FrameCount = 0
        
        StartupOverlay()
    }
    
    public final override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    public final override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    public final override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public final override var preferredStatusBarStyle: UIStatusBarStyle { return AppDelegate.framework.statusBarStyle }
    
    // MARK: Private Methods
    private final func AddCameraView() {
        CameraView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        CameraView.backgroundColor = .black
        
        self.view.addSubview(CameraView)
    }
    
    private final func AddMockButtons(to: UIView) {
        let middleLowerPoint: CGPoint = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height - 150)
        let padding = 10
        let buttonHeight = 100
        
        let mockFailureX: Int = padding
        let mockFailureY: Int = Int(middleLowerPoint.y) + padding
        let mockFailureWidth: Int = Int(middleLowerPoint.x) - (padding * 2)
        let mockFailureHeight: Int = buttonHeight - (padding * 2)
        MockFailure = UIButton(frame: CGRect(x: mockFailureX, y: mockFailureY, width: mockFailureWidth, height: mockFailureHeight))
        MockFailure.setTitle("Mock Failure", for: .normal)
        MockFailure.backgroundColor = UIColor.systemRed
        MockFailure.setTitleColor(.white, for: .normal)
        MockFailure.layer.cornerRadius = 10
        MockFailure.addTarget(self, action: #selector(failurePressed), for: .touchUpInside)
        
        let mockSuccessX: Int = Int(middleLowerPoint.x) + padding
        let mockSuccessY: Int = Int(middleLowerPoint.y) + padding
        let mockSuccessWidth: Int = Int(middleLowerPoint.x) - (padding * 2)
        let mockSuccessHeight: Int = buttonHeight - (padding * 2)
        MockSuccess = UIButton(frame: CGRect(x: mockSuccessX, y: mockSuccessY, width: mockSuccessWidth, height: mockSuccessHeight))
        MockSuccess.setTitle("Mock Success", for: .normal)
        MockSuccess.backgroundColor = UIColor.systemGreen
        MockSuccess.setTitleColor(.white, for: .normal)
        MockSuccess.layer.cornerRadius = 10
        MockSuccess.addTarget(self, action: #selector(successPressed), for: .touchUpInside)
        
        to.addSubview(MockFailure)
        to.addSubview(MockSuccess)
    }
    
    private final func AddBusyIndicator(to: UIView) {
        let busyIndicatorX: Int = -10
        let busyIndicatorY: Int = 0
        let busyIndicatorWidth: Int = 100
        let busyIndicatorHeight: Int = 100
        BusyIndicator = UIView(frame: CGRect(x: busyIndicatorX, y: busyIndicatorY, width: busyIndicatorWidth, height: busyIndicatorHeight))
        BusyIndicator.backgroundColor = UIColor.systemRed
        BusyIndicator.layer.cornerRadius = 10
        
        to.addSubview(BusyIndicator)
    }
    
    private final func StartupOverlay() {
        
        AccessHandler.checkCameraAccess { [weak self] granted -> Void in
            guard let self = self else { return }
            
            if granted {
                var cameraOptions = CameraOptions()
                cameraOptions.minimumResolution = CGSize(width: 720, height: 1280)
                cameraOptions.maximumResolution = CGSize(width: 1080, height: 1920)
                cameraOptions.minimumFramesPerSecond = 30
                cameraOptions.maximumFramesPerSecond = 60
                cameraOptions.preference = .FPS
                
                self.CameraHandlerObj = CameraHandler(self.CameraView, cameraPosition: AppDelegate.framework.cameraPosition, cameraOptions: cameraOptions)
                self.CameraHandlerObj.outputType = .CMSampleBuffer
                self.CameraHandlerObj.delegate = self
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    self.ConfigureOverlay(self.CameraView)
                    
                    CommonUI.delegate = self
                    CommonUI.addFlashLightButton(to: nil)
                    CommonUI.addBackButton(to: nil)
                    
                    GestureHandler.delegate = self
                    GestureHandler.addSwipeGesture(on: self.CameraView, for: .right)
                    
                    self.AddMockButtons(to: self.CameraView)
                    self.AddBusyIndicator(to: self.CameraView)
                }
                    
            } else {
                AccessHandler.showUIAlertForCameraPermission(self) { [weak self] in
                    guard let self = self else { return }
                    
                    self.RemoveSybrinViewController()
                }
            }
        }
        
    }
    
    private final func ConfigureOverlay(_ view: UIView) {
        
        let cameraPreviewWidth = view.frame.width
        let cameraPreviewHeight = view.frame.height
        
        let overlayWidth = (cameraPreviewWidth * 0.9)
        let overlayHeight = overlayWidth
        
        let overlayY = ((cameraPreviewHeight / 2) - (overlayHeight / 2))
        let overlayX = ((cameraPreviewWidth / 2) - (overlayWidth / 2))
        
        let overlayRect: CGRect = CGRect(x: overlayX, y: overlayY, width: overlayWidth , height: overlayHeight)
        let overlayView: UIView = UIView(frame: overlayRect)
        overlayView.tag = 100
        
        // Adding the overlay to the camera preview layer
        view.addSubview(overlayView)
            
        // Setting point values
        CommonUI.labelStartPoint = CGPoint(x: CGFloat(overlayX), y: CGFloat(overlayY))
        CommonUI.subLabelStartPoint = CGPoint(x: CGFloat(overlayX), y: CGFloat(overlayY + (overlayHeight)))
        
        // Add Overlay
        CommonUI.addOverlay(to: view)
        
        let cornerRadius: CGFloat = AppDelegate.framework.cutoutCornerRadius
        
        // Adding Cutout
        CommonUI.addRectCutouts(addBorder: (AppDelegate.framework.cutoutBorderStyle == .Surrounding), withRoundedCorners: (width: cornerRadius, height: cornerRadius), overlayView)
        
        // Adding Borders
        if AppDelegate.framework.cutoutBorderStyle == .Inside {
            CommonUI.addInsideCornerBorders(to: overlayView)
        } else if AppDelegate.framework.cutoutBorderStyle == .Outside {
            CommonUI.addOutsideCornerBorders(to: overlayView)
        }
        
        // Adding Text
        CommonUI.updateLabelText(to: "Scan the QR Code")
        
    }
    
    private final func RemoveSybrinViewController() {

        ViewController.closingStartTime = Date().timeIntervalSince1970 * 1000
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.dismiss(animated: true) {
                CommonUI.removeOverlay()
            }
        }
        
    }
    
    // MARK: Buttons
    @objc private final func failurePressed(sender: UIButton!) {
        OverlayViewController.failureMockCallback?()
        RemoveSybrinViewController()
    }
    
    @objc private final func successPressed(sender: UIButton!) {
        if let image = LastFrame?.toUIImage(fixOrientation: true) {
            OverlayViewController.successMockCallback?(image)
            RemoveSybrinViewController()
        }
    }
    
}

// MARK: Extensions
extension OverlayViewController: CameraDelegate {
    
    public final func processFrameCMSampleBuffer(_ frame: CMSampleBuffer) {
        LastFrame = frame
        
        if FrameCount == 0 {
            ViewController.startupEndTime = Date().timeIntervalSince1970 * 1000
            let time = ViewController.startupEndTime - ViewController.startupStartTime
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                "Startup took \(time)ms".addTo(view: self.view)
            }
            ViewController.startupTimes.append(time)
        }
        
        FrameCount += 1
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let isCameraBusy = self.CameraHandlerObj.isCameraBusy
            
            self.BusyIndicator.backgroundColor = (isCameraBusy) ? UIColor.systemRed : UIColor.systemGreen
        }
        
        let currentTime = Date().timeIntervalSince1970 * 1000
        if currentTime > PreviousFPSCount + 1000 {
            print("Processing: \(frame.width)x\(frame.height) @ \((FrameCount - PreviousFrameCount)) fps")
            PreviousFPSCount = currentTime
            PreviousFrameCount = FrameCount
        }
        
    }
    
}

extension OverlayViewController: CommonUIDelegate {
    
    public final func handleBackButtonPressed() {
        RemoveSybrinViewController()
    }
    
}

extension OverlayViewController: SwipeGestureDelegate {
    
    public final func handleSwipeRight() {
        RemoveSybrinViewController()
    }
    
}
