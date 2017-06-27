//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 0 color palettes.
  struct color {
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 2 files.
  struct file {
    /// Resource file `endClockSound.mp3`.
    static let endClockSoundMp3 = Rswift.FileResource(bundle: R.hostingBundle, name: "endClockSound", pathExtension: "mp3")
    /// Resource file `tickingSound.mp3`.
    static let tickingSoundMp3 = Rswift.FileResource(bundle: R.hostingBundle, name: "tickingSound", pathExtension: "mp3")
    
    /// `bundle.url(forResource: "endClockSound", withExtension: "mp3")`
    static func endClockSoundMp3(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.endClockSoundMp3
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "tickingSound", withExtension: "mp3")`
    static func tickingSoundMp3(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.tickingSoundMp3
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 0 fonts.
  struct font {
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 4 images.
  struct image {
    /// Image `buttonTimerIcon`.
    static let buttonTimerIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "buttonTimerIcon")
    /// Image `launchScreen`.
    static let launchScreen = Rswift.ImageResource(bundle: R.hostingBundle, name: "launchScreen")
    /// Image `pomodoroLogo`.
    static let pomodoroLogo = Rswift.ImageResource(bundle: R.hostingBundle, name: "pomodoroLogo")
    /// Image `pomodoro`.
    static let pomodoro = Rswift.ImageResource(bundle: R.hostingBundle, name: "pomodoro")
    
    /// `UIImage(named: "buttonTimerIcon", bundle: ..., traitCollection: ...)`
    static func buttonTimerIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.buttonTimerIcon, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "launchScreen", bundle: ..., traitCollection: ...)`
    static func launchScreen(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.launchScreen, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "pomodoro", bundle: ..., traitCollection: ...)`
    static func pomodoro(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.pomodoro, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "pomodoroLogo", bundle: ..., traitCollection: ...)`
    static func pomodoroLogo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.pomodoroLogo, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 0 nibs.
  struct nib {
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `taskCell`.
    static let taskCell: Rswift.ReuseIdentifier<TableViewCell> = Rswift.ReuseIdentifier(identifier: "taskCell")
    
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 0 view controllers.
  struct segue {
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 0 localization tables.
  struct string {
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try main.validate()
      try launchScreen.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if UIKit.UIImage(named: "launchScreen") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'launchScreen' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController
      
      let addTaskViewController = StoryboardViewControllerResource<AddTaskViewController>(identifier: "AddTaskViewController")
      let bundle = R.hostingBundle
      let name = "Main"
      let pomodoroViewController = StoryboardViewControllerResource<PomodoroViewController>(identifier: "PomodoroViewController")
      
      func addTaskViewController(_: Void = ()) -> AddTaskViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: addTaskViewController)
      }
      
      func pomodoroViewController(_: Void = ()) -> PomodoroViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: pomodoroViewController)
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "buttonTimerIcon") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'buttonTimerIcon' is used in storyboard 'Main', but couldn't be loaded.") }
        if _R.storyboard.main().addTaskViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'addTaskViewController' could not be loaded from storyboard 'Main' as 'AddTaskViewController'.") }
        if _R.storyboard.main().pomodoroViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'pomodoroViewController' could not be loaded from storyboard 'Main' as 'PomodoroViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
