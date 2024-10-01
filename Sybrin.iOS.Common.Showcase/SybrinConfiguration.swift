//
//  SybrinConfiguration.swift
//  Sybrin.iOS.Common.Showcase
//
//  Created by Default on 2021/02/08.
//  Copyright © 2021 Sybrin Systems. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

public final class SybrinConfiguration: SybrinCommonConfiguration {
    
    // MARK: Internal Properties
    static var OverlayColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
    static var OverlayLabelTextColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    static var OverlaySubLabelTextColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    
    static var OverlayBorderColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    static var OverlayBorderThickness: CGFloat = 5
    static var OverlayBorderLength: CGFloat = 32
    
    static var OverlayBlurStyle: UIBlurEffect.Style = .dark
    static var OverlayBlurIntensity: CGFloat = 1
    
    static var CutoutBorderStyle: SybrinBorderStyle = .Outside
    static var CutoutCornerRadius: CGFloat = 0
    
    static var CameraPosition: AVCaptureDevice.Position = .back
    
    static var StatusBarStyle: UIStatusBarStyle = .lightContent
    
    static var EnvironmentKey: String = "ZPNzpDSI7kLNmurByjWBrcmmnRd5N5yGJBIvxVKXqjIrKp0No2OyNF/3KIQOtKH+/tGDkx7QX2RhcKkRuhvgMAYSCz1mg8d969YZj2SWmMxQw/PuDxjtO0Sa5Pycl+oqBWSyAbhbnIUejAqWshT2B1z4pf1a8fP/Npu/vakrG0NxIsq9o+CuBu01mjTsRtWLVOyOtJXaKQ+rs5R9Xcy7Q0agNcjQt9re19K5E8qwUGa/tUimeSSUO8vQ6bClyZdz7DQ9olWwjw3jiLuesZ+aqUs3QKOGVnGchrdQKifz6cUOgMHqwMGR12kK8tSKaRcFhQc5AmgUBkXT8NPAGEntUZUMtsRB8Ck7qmslMqb8GoAZjFwNNekFHsJ3ooonHHw1/JGQpDWgwvoMd0Mkk5toS/lAt12voLPhJ6pKNjGiGFSLRUzn6+6j93wkkePss+8ut5qKoi5+Kz0I4VhAg6n9ONKp4nKNqZJDWaCFaKhFXdvX5nKVsmUkTfxhXy4E+q1J8cD0eRuNEr9eMiRo3hGWLsQQ1u4FRABb9CvUdifmV6KLTuawR1jwAV5uFgGRwRSzFdoay+Ygq2Rvh8e67L03DcbpswUA34iAmrx9jD03Rgw1GNkElLXkiWHAMRw3L/F74OGAxFEjXOYFqhkYtB8qo2Bmt63QDstVWGsEvnfBHbnNorD8Ga1plDE+QRGQblP1mWOtMCdIKRkwRWaAm4LEXWSU2geciV6tuziK++WpKlbO5a7d500xajr0aB8zoNhhHk94rCX+zGdLBc8sHAEK8KYIeZ7E1tc4CTTlF4a/6DYUe2dZYT8f2h7wbq5rfmMeYqHJFA4eAle2m4neO7sfTPA4pHGt0rDLcPff2u105RedExYfJek9WKFnNRYQnRJzOfcFXBY+Q8bwBGCGJ1JkVxC/Xf/ULj8w5V5LhCkbWaTTi8DcNzmKJ3G8mHDY+m98gnXdwTir5QKU1AkfBMcUNH30GTbXMf6uG3XXogQTEGwCL0oEgSm10nnafWgx58Ug0EhdyUpurCfEp39Cje5lrbzXZKKJ/R/7QJiHVDrK2wJWYVFcqLxr4HpDy/Jyap0GxZTixM83sSmzv4FzTpuCPcw6Tc8X7Za7Sgian05LXCb2Ncot+Vus259/FFP+VTPuUgFGtuvSz9exTNcoi0ZBI6q5twfRUw8QZYYZNdJjflnsUVOMFdvlRbfN69KVcxJQDJuInfhcQ6EUnw1c+Uk1FztHgiommabRO+ETfpOTRD4i7bvLXCcsN/cneVs7CHowzbmY02fT/PHOlPWfEM2pdGEef2d1Avrk0hlXiJ2HFW1E7foUxQWloMFibraUV4J1QVp5G+6voWZVKK0LucfC/YWIyf7ZzvWZG+gM4dhN88MTwQfx70xqOnMo2lqFdJOyc7/psHwBF9a72aLKmgqW0KmxYk7wuLuwe0gX4KHV+mihYnM2/qpQGsDuNxT/AXVDlasKy6ox06Y1fPkmC8TV0w=="

    // MARK: Public Properties
    public final var overlayColor: UIColor = SybrinConfiguration.OverlayColor
    public final var overlayLabelTextColor: UIColor = SybrinConfiguration.OverlayLabelTextColor
    public final var overlaySubLabelTextColor: UIColor = SybrinConfiguration.OverlaySubLabelTextColor
    
    public final var overlayBorderColor: UIColor = SybrinConfiguration.OverlayBorderColor
    public final var overlayBorderThickness: CGFloat = SybrinConfiguration.OverlayBorderThickness
    public final var overlayBorderLength: CGFloat = SybrinConfiguration.OverlayBorderLength
    
    public final var overlayBlurStyle: UIBlurEffect.Style = SybrinConfiguration.OverlayBlurStyle
    public final var overlayBlurIntensity: CGFloat = SybrinConfiguration.OverlayBlurIntensity
    
    public final var cutoutBorderStyle: SybrinBorderStyle = SybrinConfiguration.CutoutBorderStyle
    public final var cutoutCornerRadius: CGFloat = SybrinConfiguration.CutoutCornerRadius
    
    public final var cameraPosition: AVCaptureDevice.Position = SybrinConfiguration.CameraPosition
    
    public final var statusBarStyle: UIStatusBarStyle = SybrinConfiguration.StatusBarStyle
    
    public final var environmentKey: String = SybrinConfiguration.EnvironmentKey
    
}

public enum SybrinBorderStyle {
    case Surrounding
    case Inside
    case Outside
}
