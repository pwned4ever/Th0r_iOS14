//
//  ViewController.swift
//  taurine
//
//  Created by 23 Aaron on 28/02/2021.
//

import UIKit
import MachO.dyld
import AVFoundation


var pleaseselectthetruth = 0
public extension UIDevice {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod touch (5th gen)"
            case "iPod7,1":                                 return "iPod touch (6th gen)"
            case "iPod9,1":                                 return "iPod touch (7th gen)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4,", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"
            case "iPhone12,8":                              return "iPhone SE (2nd gen)"
            case "iPhone13,2":                              return "iPhone 12"
            case "iPhone13,1":                              return "iPhone 12 mini"
            case "iPhone13,4":                              return "iPhone 12 Pro Max"
            case "iPhone13,3":                              return "iPhone 12 Pro"

            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad (3rd gen)"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad (4th gen)"
            case "iPad6,11", "iPad6,12":                    return "iPad (5th gen)"
            case "iPad7,5", "iPad7,6":                      return "iPad (6th gen)"
            case "iPad7,11", "iPad7,12":                    return "iPad (7th gen)"
            case "iPad11,6", "iPad11,7":                    return "iPad (8th gen)"
                
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad11,4", "iPad11,5":                    return "iPad Air (3rd gen)"
            case "iPad13,2", "iPad13,1":                    return "iPad Air (4th gen)"

            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad mini (5th gen)"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch) (1st gen)"
            case "iPad8,9", "iPad8,10":                     return "iPad Pro (11-inch) (2nd gen)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch) (1st gen)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd gen)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd gen)"
            case "iPad8,11", "iPad8,12":                    return "iPad Pro (12.9-inch) (4th gen)"
            case "iPad13,8", "iPad13,10":                    return "iPad Pro (12.9-inch) (5th gen)"
                
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()

}

class MusicPlayer {
    static let shared = MusicPlayer()
        
    var audioPlayer: AVAudioPlayer!
    func startbtnBackgroundMusic() {
        if let bundle = Bundle.main.path(forResource: "ImmigrantSong", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                self.audioPlayer.setVolume(-0.5, fadeDuration: -1)

                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    func startBackgroundMusic() {
  
        if let bundle = Bundle.main.path(forResource: "GunsBlazing", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                let session = AVAudioSession.sharedInstance()

                try session.setCategory(AVAudioSession.Category.playback)
                try session.setActive(true)

                self.audioPlayer = try AVAudioPlayer(contentsOf: backgroundMusic as URL)
                // self.audioPlayer.delegate = self
                self.audioPlayer.prepareToPlay()
                
                self.audioPlayer.play()
                self.audioPlayer.setVolume(-0.5, fadeDuration: -1)
                // self.audioPlayer.volume = -0.71
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = 8
                
            } catch {
                print(error)
            }
        }
    }
    func stopBackgroundMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }
}

class ViewController: UIViewController, ElectraUI {
    
    var electra: Electra?
    
    fileprivate var scrollAnimationClosures: [() -> Void] = []
    private var popClosure: DispatchWorkItem?
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var backgroundOverlay: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var jailbreakButton: ProgressButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var vibrancyView: UIVisualEffectView!
    @IBOutlet weak var updateOdysseyView: UIVisualEffectView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var switchesView: PanelStackView!
    
    @IBOutlet weak var themeCopyrightButton: UIButton!
    
    @IBOutlet weak var enableTweaksSwitch: UISwitch!
    @IBOutlet weak var restoreRootfsSwitch: UISwitch!
    @IBOutlet weak var logSwitch: UISwitch!
    @IBOutlet weak var nonceSetter: TextButton!
    
    @IBOutlet weak var iphoneipadModellabel: UILabel!
    @IBOutlet weak var uptimelabel: UILabel!

    @IBOutlet weak var containerViewYConstraint: NSLayoutConstraint!
    
    private var themeImagePicker: ThemeImagePicker!
    private var activeColourDefault = ""
    private let colorPickerViewController = UIColorPickerViewController()
    
    private var currentView: (UIView & PanelView)?
    let thorversion = "4.0.6⚡️"
    let thorupdateDate = "1:00AM 10/07/21"
    let thorurlDownload = "github.com/pwned4ever/Th0r_iOS14/blob/main/releases/Th0r14.ipa"// "mega.nz/file/BhNxBSgJ#gNcngNQBtXS0Ipa5ivX09-jtIr7BckUhrA7YMkSFaNM"//

    func shareTh0r() {

        let mesomeuptime = dispatch_time_t.init()
        // let daysofuptime = (((mesomeuptime / 60) / 60) / 24)
        print("[*] imaginary uptime is \(mesomeuptime)\n")
        let modelName = UIDevice.modelName
        // print("my HW_MACHINE is \n", modelName)
        var msgme = "14.3"
        if #available(iOS 14.3, *) { msgme = "14.3"
        } else if #available(iOS 14.2, *) { msgme = "14.2"
        } else if #available(iOS 14.1, *) { msgme = "14.1"
        } else if #available(iOS 14.0.1, *) { msgme = "14.0.1"
        } else if #available(iOS 14.0, *) { msgme = "14.0"}
        let twitsr: String = "@shogunpwnd"
        let anewint = 0
        // progressRing.fontColor = UIColor.green
        let whatsmyuptime = anuptimeaway(Int32(anewint))
        let items = ["I'm using TH{}R \(thorversion) for iOS 14.0-14.3, by:\(twitsr), to jailbreak my \(modelName) - \(msgme). Uptime:\(whatsmyuptime) day, Updated \(thorupdateDate). Download @ \(thorurlDownload)"]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.currentView
        
        let items0 = ["I'm using TH{}R \(thorversion) for iOS 14.0-14.3, by:\(twitsr), to jailbreak my \(modelName) - \(msgme). Uptime:\(whatsmyuptime) days, Updated \(thorupdateDate). Download @ \(thorurlDownload)"] as [Any]
        let activityVC0 = UIActivityViewController(activityItems: items0, applicationActivities: nil)
        activityVC0.popoverPresentationController?.sourceView = self.currentView
        if whatsmyuptime == 1 {
            self.present(activityVC, animated: true, completion: nil)
        } else {
            self.present(activityVC0, animated: true, completion: nil)
        }
    }
    func gonnaanimate() {

        backgroundImage.animationImages = animatedImages(for: "lightningGIF/")
        backgroundImage.animationDuration = 0.9
        backgroundImage.animationRepeatCount = 0
        backgroundImage.image = backgroundImage.animationImages?.first
        backgroundImage.startAnimating()
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This will reset user defaults, used it a lot for testing
        /*
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
        */ // backgroundOverlay


        gonnaanimate()
        currentView = switchesView
        nonceSetter.delegate = NonceManager.shared

        jailbreakButton?.setTitle("Jailbreak", for: .normal)
        
        if #available(iOS 14.4, *) {
            jailbreakButton?.isEnabled = false
            jailbreakButton?.setTitle("Unsupported", for: .normal)
        }
        
        let resultStorage: ObjCBool = false // true or false doesn't matter here, but
        let modelName = UIDevice.modelName
        var msgme = "14.3"
        if #available(iOS 14.7.1, *) { msgme = "14.7.1"
        } else if #available(iOS 14.7, *) { msgme = "14.7"
        } else if #available(iOS 14.6, *) { msgme = "14.6"
        } else if #available(iOS 14.5.1, *) { msgme = "14.5.1"
        } else if #available(iOS 14.5, *) { msgme = "14.5"
        } else if #available(iOS 14.4.2, *) { msgme = "14.4.2"
        } else if #available(iOS 14.4.1, *) { msgme = "14.4.1"
        } else if #available(iOS 14.4, *) { msgme = "14.4"
        } else if #available(iOS 14.3, *) { msgme = "14.3"
        } else if #available(iOS 14.2, *) { msgme = "14.2"
        } else if #available(iOS 14.1, *) { msgme = "14.1"
        } else if #available(iOS 14.0.1, *) { msgme = "14.0.1"
        } else if #available(iOS 14.0, *) { msgme = "14.0"
        }
        if isJailbroken() {
            jailbreakButton?.isEnabled = false
            jailbreakButton?.setTitle("Jailbroken", for: .normal)
            self.iphoneipadModellabel?.isHidden = false
            // self.iOSversionOfdeviceLabel?.isHidden = false
            self.iphoneipadModellabel?.text = "\(modelName)\n\(msgme)"
            // self.iOSversionOfdeviceLabel?.text = "\( msgme)"
            containerView.isUserInteractionEnabled = false
            containerView.isHidden = true
            // progressRing.outerRingColor = UIColor.red
            //self.zbuttonYEA.isHidden = true

            if file_exist("/usr/lib/libsubstitute.dylib") && !file_exist("/taurine") && !file_exist("/Th0r") {
                jailbreakButton?.isEnabled = false
                let msgme = "Remove unc0ver 1st"
                DispatchQueue.main.async { self.jailbreakButton?.setTitle(msgme, for: .init()) }
            } else if file_exist("/.installed_unc0ver") && !file_exist("/Th0r") || file_exist("/var/lib/undecimus") && !file_exist("/Th0r") {
                jailbreakButton?.isEnabled = false
                DispatchQueue.main.async { self.jailbreakButton?.setTitle("Remove unc0ver 1st", for: .init()) }
            } else if file_exist("/taurine") && !file_exist("/Th0r") {
                jailbreakButton?.isEnabled = false
                DispatchQueue.main.async { self.jailbreakButton?.setTitle("Remove taurine 1st", for: .init()) }
            } else if file_exist("/taurine") && file_exist("/Th0r") {
                jailbreakButton?.isEnabled = true
                self.uptimelabel.isHidden = false
                // progressRing.outerRingColor = UIColor.blue
                
                DispatchQueue.main.async {
                    self.jailbreakButton?.setTitle("Share TH{}R?", for: .init())
        
                }
                
                let anewint = 0
                let whatsmyuptime = anuptimeaway(Int32(anewint))
                if whatsmyuptime == 1 { self.uptimelabel.text = " \(whatsmyuptime) day uptime"
                } else if whatsmyuptime == 0 { self.uptimelabel.text = " \(whatsmyuptime) days uptime"
                } else { self.uptimelabel.text = " \(whatsmyuptime) days uptime" }
            } else {
                self.uptimelabel.isHidden = true
                jailbreakButton?.isEnabled = false
                // progressRing.outerRingColor = UIColor.red
                DispatchQueue.main.async {
                    self.jailbreakButton?.setTitle("Jailbroken w/?", for: .init())
                }
            }
            
        } else {   // not jailbroken state
            
            self.iphoneipadModellabel?.isHidden = false
            // self.iOSversionOfdeviceLabel?.isHidden = false
            self.uptimelabel.isHidden = false
            self.iphoneipadModellabel?.text = "\(modelName)\n\(msgme)"
            // self.iOSversionOfdeviceLabel?.text = "\( msgme)"
            
            let anewint = 0
            let whatsmyuptime = anuptimeaway(Int32(anewint))
            if whatsmyuptime == 1 { self.uptimelabel.text = " \(whatsmyuptime) day uptime"
            } else if whatsmyuptime == 0 { self.uptimelabel.text = " \(whatsmyuptime) days uptime"
            } else { self.uptimelabel.text = " \(whatsmyuptime) days uptime" }
            pleaseselectthetruth = 1
            containerView.isHidden = false
            containerView.isUserInteractionEnabled = true
            jailbreakButton?.isEnabled = true
            // formatter.showValueInteger = false
            //self.zbuttonYEA.isHidden = false
            // progressRing.outerRingColor = UIColor.red
            // progressRing.innerRingColor = UIColor.systemGreen
            
            if restoreRootfsSwitch.isOn == true {
                if file_exist("/usr/lib/libsubstitute.dylib") && !file_exist("/taurine") && !file_exist("/Th0r") {
                    print("bastard libsubstitute")
                    restoreRootfsSwitch.isOn = true
                    restoreRootfsSwitch.isEnabled = false
                    enableTweaksSwitch?.isEnabled = false
                    enableTweaksSwitch?.isOn = true
                    DispatchQueue.main.async { self.jailbreakButton?.setTitle("Remove unc0ver?", for: .init()) }
                } else if file_exist("/.installed_unc0ver") && !file_exist("/Th0r") || file_exist("/var/lib/undecimus") && !file_exist("/Th0r") {
                    restoreRootfsSwitch.isOn = true
                    restoreRootfsSwitch.isEnabled = false
                    enableTweaksSwitch?.isEnabled = false
                    enableTweaksSwitch?.isOn = true
                    DispatchQueue.main.async { self.jailbreakButton?.setTitle("Remove unc0ver?", for: .init()) }
                } else if file_exist("/taurine") && !file_exist("/Th0r") {
                    restoreRootfsSwitch.isOn = true
                    restoreRootfsSwitch.isEnabled = false
                    enableTweaksSwitch?.isEnabled = false
                    enableTweaksSwitch?.isOn = true
                    DispatchQueue.main.async { self.jailbreakButton?.setTitle("Remove taurine?", for: .init()) }
                } else if file_exist("/taurine") && file_exist("/Th0r") {
                    // progressRing.outerRingColor = UIColor.red
                    enableTweaksSwitch?.isEnabled = false
                    enableTweaksSwitch?.isOn = true
                    restoreRootfsSwitch.isOn = true
                    restoreRootfsSwitch.isEnabled = true
                    DispatchQueue.main.async { self.jailbreakButton?.setTitle("Remove TH{}R?", for: .init())
                    }
                } else {
                    restoreRootfsSwitch.isOn = true
                    restoreRootfsSwitch.isEnabled = true
                    enableTweaksSwitch?.isEnabled = false
                    enableTweaksSwitch?.isOn = true
                    DispatchQueue.main.async { self.jailbreakButton?.setTitle("Remove JB?", for: .init()) }
                }
            } else {
                
                //self.uptimelabel.isHidden = true

                let isDir = resultStorage.boolValue // Finally!
                if isDir == true {
                }
                if file_exist("/usr/lib/libsubstitute.dylib") && !file_exist("/taurine") && !file_exist("/Th0r") {
                    restoreRootfsSwitch.isOn = true
                    restoreRootfsSwitch.isEnabled = false
                    enableTweaksSwitch?.isEnabled = false
                    enableTweaksSwitch?.isOn = true
                    DispatchQueue.main.async { self.jailbreakButton?.setTitle("Remove unc0ver JB", for: .init()) }
                } else if file_exist("/.installed_unc0ver") && !file_exist("/Th0r") || file_exist("/var/lib/undecimus") && !file_exist("/Th0r") {
                    restoreRootfsSwitch.isOn = true
                    restoreRootfsSwitch.isEnabled = false
                    enableTweaksSwitch?.isEnabled = false
                    enableTweaksSwitch?.isOn = true
                    DispatchQueue.main.async { self.jailbreakButton?.setTitle("Remove unc0ver JB", for: .init()) }
                } else if file_exist("/taurine") && !file_exist("/Th0r") {
                    restoreRootfsSwitch.isOn = true
                    restoreRootfsSwitch.isEnabled = false
                    enableTweaksSwitch?.isEnabled = false
                    enableTweaksSwitch?.isOn = true
                    DispatchQueue.main.async { self.jailbreakButton?.setTitle("Remove taurine JB", for: .init()) }
                } else if file_exist("/taurine") && file_exist("/Th0r") {
                    pleaseselectthetruth = 0
                    enableTweaksSwitch?.isEnabled = true
                    // enableTweaksSwitch?.isOn = true
                    restoreRootfsSwitch.isOn = false
                    restoreRootfsSwitch.isEnabled = true
                    // progressRing.outerRingColor = UIColor.blue
                    // progressRing.innerRingColor = UIColor.green
                    DispatchQueue.main.async { self.jailbreakButton?.setTitle("Enable JB", for: .init()) }
                } else {
                    pleaseselectthetruth = 0
                    restoreRootfsSwitch.isOn = false
                    restoreRootfsSwitch.isEnabled = true
                    enableTweaksSwitch?.isEnabled = true
                   // progressRing.outerRingColor = UIColor.blue
                   // progressRing.innerRingColor = UIColor.green
                    DispatchQueue.main.async { self.jailbreakButton?.setTitle("Jailbreak", for: .init()) }
                }
            }
        }
        
        let refreshAlert = UIAlertController(title: "Music set to play?", message: "Want beats?", preferredStyle: .alert)

        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in// (action: UIAlertAction!) in
             //  print("Handle Ok logic here")
            
                MusicPlayer.shared.startBackgroundMusic()

        }))

        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
              // print("Handle Cancel Logic here")
        }))

        self.present(refreshAlert, animated: true) //, completion: nil)
        

        if getSafeEntitlements().count < 3 {
            self.showAlert("Sanity Check Failed",
                           "Your copy of Th0r has not been signed correctly. Please sign it properly to continue.",
                           sync: false)
            jailbreakButton.isEnabled = false
            jailbreakButton.setTitle("Sanity Check Failed", for: .normal)
        }
        
        /*let updateTapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(shouldOpenUpdateLink))
        updateOdysseyView.addGestureRecognizer(updateTapGestureRecogniser)
        
        AppVersionManager.shared.doesApplicationRequireUpdate { result in
            switch result {
            case .failure(let error):
                print(error)
                return
            
            case .success(let updateRequired):
                if (updateRequired) {
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.5) {
                            self.updateOdysseyView.isHidden = false
                        }
                    }
                }
            }
        }
        */
        self.themeImagePicker = ThemeImagePicker(presentationController: self, delegate: self)
        colorPickerViewController.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(updateTheme), name: ThemesManager.themeChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showColourPicker(_:)), name: ColourPickerCell.showColourPicker, object: nil)
        self.updateTheme()
    }
    
    @objc private func shouldOpenUpdateLink() {
        AppVersionManager.shared.launchBestUpdateApplication()
    }
    
    func animatedImages(for name: String) -> [UIImage] {
        
        var i = 0
        var images = [UIImage]()
        
        while let image = UIImage(named: "\(name)/\(i)") {
            images.append(image)
            i += 1
        }
        return images
    }
    
    @objc func updateTheme() {
        let custom = UserDefaults.standard.string(forKey: "theme") == "custom"
        let customColour = UserDefaults.standard.string(forKey: "theme") == "customColourTheme"
        let theme = ThemesManager.shared.currentTheme
        
        let bgImage: UIImage?
        if custom {
            guard let customImage = ThemesManager.shared.customImage else {
                photoLibrary(nil)
                return
            }
            bgImage = customImage
        } else {
            bgImage = ThemesManager.shared.currentTheme.backgroundImage
        }
        
        if let bgImage = bgImage {
            if custom {
                backgroundImage.image = bgImage
            } else {
                let aspectHeight = self.view.bounds.height
                let aspectWidth = self.view.bounds.width
                    
                let maxDimension = max(aspectHeight, aspectWidth)
                let isiPad = UIDevice.current.userInterfaceIdiom == .pad
                
                backgroundImage.image = ImageProcess.sizeImage(image: bgImage,
                                                               aspectHeight: isiPad ? maxDimension : aspectHeight,
                                                               aspectWidth: isiPad ? maxDimension : aspectWidth,
                                                                center: ThemesManager.shared.currentTheme.backgroundCenter)
            }
        } else {
            backgroundImage.image = nil
        }
        
        if custom || customColour {
            vibrancyView.isHidden = !ThemesManager.shared.customThemeBlur
        } else {
            vibrancyView.isHidden = !theme.enableBlur
        }
        
        backgroundOverlay.backgroundColor = theme.backgroundOverlay ?? UIColor.clear
        themeCopyrightButton.isHidden = theme.copyrightString.isEmpty
        
        jailbreakButton.setGradient(colors: theme.progressGradientColors, delta: theme.progressGradientDelta)
    }
    
    func updateButton(_ title: String) {
        DispatchQueue.main.async {
            self.jailbreakButton.setTitle(title, for: .normal)
        }
    }
    
    func showAlert(_ title: String, _ message: String, sync: Bool, callback: (() -> Void)? = nil, yesNo: Bool = false, noButtonText: String? = nil) {
        let sem = DispatchSemaphore(value: 0)
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: yesNo ? "Yes" : "OK", style: .default) { _ in
                if let callback = callback {
                    callback()
                }
                if sync {
                    sem.signal()
                }
            })
            if yesNo {
                alertController.addAction(UIAlertAction(title: noButtonText ?? "No", style: .default) { _ in
                    if sync {
                        sem.signal()
                    }
                })
            }
            (self.presentedViewController ?? self).present(alertController, animated: true, completion: nil)
        }
        if sync {
            sem.wait()
        }
    }
    
    
    @IBAction func pressrestoreswitch(_ sender: Any) {
       var resultStorage: ObjCBool = false // true or false doesn't matter here, but
       enableTweaksSwitch?.isHidden = false
       enableTweaksSwitch?.isEnabled = false
       enableTweaksSwitch?.isOn = true

       jailbreakButton?.isHidden = false
       jailbreakButton?.isEnabled = true
       //progressRing.outerRingColor = UIColor.red
       //progressRing.innerRingColor = UIColor.green
       containerView.isUserInteractionEnabled = true
       containerView.isHidden = false

        if restoreRootfsSwitch.isOn == true {
           pleaseselectthetruth = 1
           DispatchQueue.main.async {
           if file_exist("/usr/lib/libsubstitute.dylib") && !file_exist("/taurine") && !file_exist("/Th0r") {
               self.jailbreakButton?.setTitle("Remove unc0ver?", for: .init())
           } else if file_exist("/.installed_unc0ver") && !file_exist("/Th0r") || file_exist("/var/lib/undecimus") && !file_exist("/Th0r") {
               self.jailbreakButton?.setTitle("Remove unc0ver?", for: .init())
           } else if file_exist("/taurine") && !file_exist("/Th0r") {
               self.jailbreakButton?.setTitle("Remove taurine?", for: .init())
           } else if file_exist("/taurine") && file_exist("/Th0r") {
               self.jailbreakButton?.setTitle("Remove TH{}R?", for: .init())
           } else {
               self.jailbreakButton?.setTitle("Remove JB?", for: .init()) }
           }
        } else {
           
               enableTweaksSwitch?.isOn = true
               if file_exist("/usr/lib/libsubstitute.dylib") && !file_exist("/taurine") && !file_exist("/Th0r") {
                    pleaseselectthetruth = 1
                    enableTweaksSwitch?.isEnabled = false
                    DispatchQueue.main.async {
                       self.jailbreakButton?.setTitle("Remove unc0ver JB", for: .init())}
               } else if file_exist("/.installed_unc0ver") && !file_exist("/Th0r") || file_exist("/var/lib/undecimus") && !file_exist("/Th0r") {
                   enableTweaksSwitch?.isEnabled = false
                   DispatchQueue.main.async {
                       self.jailbreakButton?.setTitle("Remove unc0ver JB", for: .init())}
               } else if file_exist("/taurine") && !file_exist("/Th0r") {
                    pleaseselectthetruth = 1
                    let msgme = "Remove taurine JB"
                    DispatchQueue.main.async {
                       self.jailbreakButton?.setTitle(msgme, for: .init()) }
               } else if file_exist("/taurine") && file_exist("/Th0r") {
                   enableTweaksSwitch?.isEnabled = true
                   pleaseselectthetruth = 0
                   //progressRing.outerRingColor = UIColor.blue
                   DispatchQueue.main.async {
                       self.jailbreakButton?.setTitle("Enable JB", for: .init()) }
               } else {
                   enableTweaksSwitch?.isEnabled = true
                   pleaseselectthetruth = 0
                   //progressRing.outerRingColor = UIColor.blue
                  // enableTweaksSwitch?.isEnabled = true
                   DispatchQueue.main.async {
                       self.jailbreakButton?.setTitle("Jailbreak", for: .init()) }}
        }
    }

    @IBAction func stopmusicbtn(_ sender: Any) {
         MusicPlayer.shared.stopBackgroundMusic()
     }
     
     @IBAction func startmusicbtn(_ sender: Any) {
         MusicPlayer.shared.startbtnBackgroundMusic()
     }
    
    @IBAction func jailbreak() {
        if isJailbroken() {
            jailbreakButton?.isHidden = false
            containerView.isUserInteractionEnabled = true
            containerView.isHidden = true
            jailbreakButton?.isEnabled = true
            
            shareTh0r()
            
        } else {

            jailbreakButton?.isEnabled = false
            containerView.isUserInteractionEnabled = false
            UIApplication.shared.isIdleTimerDisabled = true
            containerView.alpha = 0.0

            let modelName = UIDevice.modelName
            var msgme = "14.3"
            if #available(iOS 14.3, *) { msgme = "14.3"
            } else if #available(iOS 14.2, *) { msgme = "14.2"
            } else if #available(iOS 14.1, *) { msgme = "14.1"
            } else if #available(iOS 14.0.1, *) { msgme = "14.0.1"
            } else if #available(iOS 14.0, *) { msgme = "14.0"}
            print("     🎵🎵🎵 🎵  🎵 🎵🎵🎵  🎵🎵🎵 \n")
            print("       🎵   🎵  🎵 🎵  🎵  🎵   🎵 \n")
            print("       🎵   🎵🎵🎵 🎵  🎵  🎵🎵🎵  \n")
            print("       🎵   🎵  🎵 🎵🎵🎵  🎵   🎵 \n")
            print("             \(thorversion)\n")
            print("            \(modelName) - \(msgme)\n")
                

            if self.logSwitch.isOn {
                UIView.animate(withDuration: 0.5) {
                    self.containerView.alpha = 0.3
                }
                self.performSegue(withIdentifier: "logSegue", sender: self.jailbreakButton)
            } else {
                UIView.animate(withDuration: 0.5) {
                    self.containerView.alpha = 0.5
                }
            }
            self.jailbreakButton.setTitle("Running Exploit.. 1/3", for: .normal)
            self.jailbreakButton.setProgress(0.33, animated: true)
            
            let enableTweaks = self.enableTweaksSwitch.isOn
            let restoreRootFs = self.restoreRootfsSwitch.isOn
            let generator = NonceManager.shared.currentValue
            #if targetEnvironment(simulator)
            let simulateJailbreak = true
            #else
            let simulateJailbreak = false
            #endif
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                DispatchQueue.global(qos: .userInteractive).async {
                    usleep(500 * 1000)
                    
                    if simulateJailbreak {
                        sleep(1)
                        DispatchQueue.main.async {
                            self.jailbreakButton.setTitle("Jailbreaking.. 2/3", for: .normal)
                            self.jailbreakButton.setProgress(0.4, animated: true)
                        }
                        var outStream = StandardOutputStream.shared
                        var errStream = StandardErrorOutputStream.shared
                        print("Testing log", to: &outStream)
                        print("Testing stderr", to: &errStream)
                        
                        sleep(2)
                        DispatchQueue.main.async {
                            self.jailbreakButton.setTitle("Jailbreaking.. 3/3", for: .normal)
                            self.jailbreakButton.setProgress(0.8, animated: true)
                        }
                        print("Testing log2", to: &outStream)
                        print("Testing stderr2", to: &errStream)
                        
                        sleep(1)
                        DispatchQueue.main.async {
                            self.jailbreakButton.setTitle("Jailbroken", for: .normal)
                            self.jailbreakButton.setProgress(1.0, animated: true)
                        }
                        print("Testing log3", to: &outStream)
                        print("Testing stderr3", to: &errStream)
                        
                        self.showAlert("Test alert", "Testing an alert message", sync: true)
                        print("Alert done")
                        
                        return
                    }
                    
                    if #available(iOS 14.4, *) {
                        fatalError("Unable to get kernel r/w")
                    }
                    
                    var hasKernelRw = false
                    var any_proc = UInt64(0)
                    
                    if #available(iOS 14, *){
                        print("Selecting cicuta_virosa for iOS 14.0 - 14.3")
                        if cicuta_virosa() == 0 {
                            any_proc = our_proc_kAddr
                            hasKernelRw = true
                        }
                    }
                    guard hasKernelRw else {
                        DispatchQueue.main.async {
                            self.jailbreakButton.setTitle("Error: Exploit Failed", for: .normal)
                            self.jailbreakButton.setProgress(0, animated: true)
                        }
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.jailbreakButton.setTitle("Please Wait... 2/3", for: .normal)
                        self.jailbreakButton.setProgress(0.66, animated: true)
                    }
                    let electra = Electra(ui: self,
                                          any_proc: any_proc,
                                          enable_tweaks: enableTweaks,
                                          restore_rootfs: restoreRootFs,
                                          nonce: generator)
                    self.electra = electra
                    let err = electra.jailbreak()
                    
                    DispatchQueue.main.async {
                        self.jailbreakButton.setProgress(1.0, animated: true)
                        if err != .ERR_NOERR {
                            self.showAlert("Oh no", "\(String(describing: err))", sync: false, callback: {
                                UIApplication.shared.beginBackgroundTask {
                                    print("odd. this should never be called.")
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    
    func popCurrentView(animated: Bool) {
        guard let currentView = currentView,
            !currentView.isRootView else {
            return
        }
        let scrollView: UIScrollView = self.scrollView
        if !animated {
            currentView.isHidden = true
            scrollView.contentSize = CGSize(width: currentView.parentView.frame.maxX, height: scrollView.contentSize.height)
        } else {
            scrollAnimationClosures.append {
                currentView.parentView.viewShown()
                currentView.isHidden = true
                scrollView.contentSize = CGSize(width: currentView.parentView.frame.maxX, height: scrollView.contentSize.height)
            }
        }
        self.currentView = currentView.parentView
        scrollView.scrollRectToVisible(currentView.parentView.frame, animated: animated)
        
        if !currentView.parentView.isRootView {
            self.resetPopTimer()
        }
    }
    
    func resetPopTimer() {
        self.popClosure?.cancel()
        let popClosure = DispatchWorkItem {
            self.popCurrentView(animated: true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: popClosure)
        self.popClosure = popClosure
    }
    
    func cancelPopTimer() {
        self.popClosure?.cancel()
        self.popClosure = nil
    }
    
    @IBAction func showPanel(button: PanelButton) {
        let userInteractionEnabled = scrollView.isUserInteractionEnabled
        scrollView.isUserInteractionEnabled = false
        
        button.childPanel.isHidden = false
        self.currentView = button.childPanel
        
        scrollAnimationClosures.append {
            button.childPanel.viewShown()
            self.scrollView.isUserInteractionEnabled = userInteractionEnabled
        }
        
        scrollView.contentSize = CGSize(width: button.childPanel.frame.maxX, height: scrollView.contentSize.height)
        scrollView.scrollRectToVisible(button.childPanel.frame, animated: true)
        self.resetPopTimer()
    }
    
    @IBAction func themeInfo() {
        self.showAlert("Theme Copyright Info", ThemesManager.shared.currentTheme.copyrightString, sync: false)
    }
    
    @IBAction func openDiscord(){
        UIApplication.shared.open(URL(string: "https://taurine.app/discord")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func photoLibrary(_ sender: Any?) {
        themeImagePicker.pickerController.sourceType = .photoLibrary
        themeImagePicker.presentationController.present(themeImagePicker.pickerController, animated: true)
        cancelPopTimer()
    }
    
    @objc public func showColourPicker(_ notification: NSNotification) {
        cancelPopTimer()
        if let dict = notification.userInfo as NSDictionary? {
            if let key = dict["default"] as? String {
                activeColourDefault = key
            } else {
                fatalError("Set a key for the colour picker")
            }
        }
        navigationController!.present(colorPickerViewController, animated: true)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let animationClosures = scrollAnimationClosures
        scrollAnimationClosures = []
        for closure in animationClosures {
            closure()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.cancelPopTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var popCount = 0
        guard var view = self.currentView else {
            return
        }
        while view.frame.minX != self.scrollView.contentOffset.x {
            guard view.frame.minX > self.scrollView.contentOffset.x else {
                fatalError("User dragged the other way???")
            }
            popCount += 1
            view = view.parentView
        }
        
        for _ in 0..<popCount {
            self.popCurrentView(animated: false)
        }
        
        self.resetPopTimer()
    }
}

extension ViewController {
    func bindToKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func unbindKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc
    func keyboardWillChange(notification: Notification) {
        /*guard let userInfo = notification.userInfo,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
            let curFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            let targetFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        self.view.layoutIfNeeded()
        let deltaY = (targetFrame.origin.y - curFrame.origin.y
        self.containerViewYConstraint.constant += deltaY
        UIView.animateKeyframes(withDuration: duration, delay: 0.00, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)*/
    }
}

extension ViewController: ThemeImagePickerDelegate {
    func didSelect(image: UIImage?) {
        resetPopTimer()
        guard let image = image,
              let data = image.pngData() else { return }
        do {
            try data.write(to: ThemesManager.customImageDirectory, options: .atomic)
            self.updateTheme()
        } catch {
            print("Confusion")
        }
    }
}

extension ViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        UserDefaults.standard.set(viewController.selectedColor, forKey: activeColourDefault)
        NotificationCenter.default.post(name: ThemesManager.themeChangeNotification, object: nil)
    }
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        resetPopTimer()
    }
}

func isJailbroken() -> Bool {
    var flags = UInt32()
    let CS_OPS_STATUS = UInt32(0)
    csops(getpid(), CS_OPS_STATUS, &flags, 0)
    if flags & Consts.shared.CS_PLATFORM_BINARY != 0 {
        return true
    }
    
    let imageCount = _dyld_image_count()
    for i in 0..<imageCount {
        if let cName = _dyld_get_image_name(i) {
            let name = String(cString: cName)
            if name == "/usr/lib/pspawn_payload-stg2.dylib" {
                return true
            }
        }
    }
    return false
}
