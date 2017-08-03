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
  
  /// This `R.image` struct is generated, and contains static references to 16 images.
  struct image {
    /// Image `buttonTimerIcon`.
    static let buttonTimerIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "buttonTimerIcon")
    /// Image `completedPomodoro`.
    static let completedPomodoro = Rswift.ImageResource(bundle: R.hostingBundle, name: "completedPomodoro")
    /// Image `goToTimerDisable`.
    static let goToTimerDisable = Rswift.ImageResource(bundle: R.hostingBundle, name: "goToTimerDisable")
    /// Image `goToTimer`.
    static let goToTimer = Rswift.ImageResource(bundle: R.hostingBundle, name: "goToTimer")
    /// Image `launchScreen`.
    static let launchScreen = Rswift.ImageResource(bundle: R.hostingBundle, name: "launchScreen")
    /// Image `microfoneForController`.
    static let microfoneForController = Rswift.ImageResource(bundle: R.hostingBundle, name: "microfoneForController")
    /// Image `microphone`.
    static let microphone = Rswift.ImageResource(bundle: R.hostingBundle, name: "microphone")
    /// Image `miniBackground`.
    static let miniBackground = Rswift.ImageResource(bundle: R.hostingBundle, name: "miniBackground")
    /// Image `okButton`.
    static let okButton = Rswift.ImageResource(bundle: R.hostingBundle, name: "okButton")
    /// Image `plannedBackground`.
    static let plannedBackground = Rswift.ImageResource(bundle: R.hostingBundle, name: "plannedBackground")
    /// Image `plannedPomodoroSelected`.
    static let plannedPomodoroSelected = Rswift.ImageResource(bundle: R.hostingBundle, name: "plannedPomodoroSelected")
    /// Image `plannedPomodoro`.
    static let plannedPomodoro = Rswift.ImageResource(bundle: R.hostingBundle, name: "plannedPomodoro")
    /// Image `pomodoroLogo`.
    static let pomodoroLogo = Rswift.ImageResource(bundle: R.hostingBundle, name: "pomodoroLogo")
    /// Image `pomodoro`.
    static let pomodoro = Rswift.ImageResource(bundle: R.hostingBundle, name: "pomodoro")
    /// Image `reloadButton`.
    static let reloadButton = Rswift.ImageResource(bundle: R.hostingBundle, name: "reloadButton")
    /// Image `settingIcon`.
    static let settingIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "settingIcon")
    
    /// `UIImage(named: "buttonTimerIcon", bundle: ..., traitCollection: ...)`
    static func buttonTimerIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.buttonTimerIcon, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "completedPomodoro", bundle: ..., traitCollection: ...)`
    static func completedPomodoro(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.completedPomodoro, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "goToTimer", bundle: ..., traitCollection: ...)`
    static func goToTimer(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.goToTimer, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "goToTimerDisable", bundle: ..., traitCollection: ...)`
    static func goToTimerDisable(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.goToTimerDisable, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "launchScreen", bundle: ..., traitCollection: ...)`
    static func launchScreen(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.launchScreen, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "microfoneForController", bundle: ..., traitCollection: ...)`
    static func microfoneForController(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.microfoneForController, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "microphone", bundle: ..., traitCollection: ...)`
    static func microphone(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.microphone, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "miniBackground", bundle: ..., traitCollection: ...)`
    static func miniBackground(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.miniBackground, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "okButton", bundle: ..., traitCollection: ...)`
    static func okButton(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.okButton, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "plannedBackground", bundle: ..., traitCollection: ...)`
    static func plannedBackground(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.plannedBackground, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "plannedPomodoro", bundle: ..., traitCollection: ...)`
    static func plannedPomodoro(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.plannedPomodoro, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "plannedPomodoroSelected", bundle: ..., traitCollection: ...)`
    static func plannedPomodoroSelected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.plannedPomodoroSelected, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "pomodoro", bundle: ..., traitCollection: ...)`
    static func pomodoro(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.pomodoro, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "pomodoroLogo", bundle: ..., traitCollection: ...)`
    static func pomodoroLogo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.pomodoroLogo, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "reloadButton", bundle: ..., traitCollection: ...)`
    static func reloadButton(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.reloadButton, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "settingIcon", bundle: ..., traitCollection: ...)`
    static func settingIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.settingIcon, compatibleWith: traitCollection)
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
  
  /// This `R.string` struct is generated, and contains static references to 2 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 16 localization keys.
    struct localizable {
      /// ru translation: Внимание
      /// 
      /// Locales: ru
      static let attention = Rswift.StringResource(key: "Attention", tableName: "Localizable", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: Вы действительно хотите остановить текущий таймер?
      /// 
      /// Locales: ru
      static let areYouSureYouWantToStopTheCurentPomodoro = Rswift.StringResource(key: "Are you sure you want to stop the curent pomodoro?", tableName: "Localizable", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: Вы завершили свою дневную цель. Поздравляем.
      /// 
      /// Locales: ru
      static let youVeCompletedYourTargetForTheDatyCongratulations = Rswift.StringResource(key: "You've completed your target for the daty! Congratulations!", tableName: "Localizable", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: Да
      /// 
      /// Locales: ru
      static let yes = Rswift.StringResource(key: "Yes", tableName: "Localizable", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: Длинный отдых, мин
      /// 
      /// Locales: ru
      static let longBreakDurationMin = Rswift.StringResource(key: "Long Break Duration, min", tableName: "Localizable", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: Добавить задачу
      /// 
      /// Locales: ru
      static let addAToDo = Rswift.StringResource(key: "Add a to-do", tableName: "Localizable", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: Звук ВКЛ.
      /// 
      /// Locales: ru
      static let soundON = Rswift.StringResource(key: "Sound ON", tableName: "Localizable", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: Звук ВЫКЛ.
      /// 
      /// Locales: ru
      static let soundOFF = Rswift.StringResource(key: "Sound OFF", tableName: "Localizable", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: Кол-во Pomodoros на день
      /// 
      /// Locales: ru
      static let targetPomodorosPerDay = Rswift.StringResource(key: "Target Pomodoros Per Day", tableName: "Localizable", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: Короткий отдых, мин
      /// 
      /// Locales: ru
      static let shortBreakDurationMin = Rswift.StringResource(key: "Short Break Duration, min", tableName: "Localizable", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: Нет
      /// 
      /// Locales: ru
      static let no = Rswift.StringResource(key: "No", tableName: "Localizable", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: Остановить таймер
      /// 
      /// Locales: ru
      static let stopTimer = Rswift.StringResource(key: "Stop Timer", tableName: "Localizable", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: Отлично
      /// 
      /// Locales: ru
      static let ok = Rswift.StringResource(key: "Ok", tableName: "Localizable", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: Очень длинная задача, советуем разбить на более короткие задачи.
      /// 
      /// Locales: ru
      static let aVeryLongTaskBreakTheTaskIntoSmaller = Rswift.StringResource(key: "A very long task, break the task into smaller", tableName: "Localizable", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: Таймер, мин
      /// 
      /// Locales: ru
      static let pomodoroDurationMin = Rswift.StringResource(key: "Pomodoro Duration, min", tableName: "Localizable", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: Цель достигнута!
      /// 
      /// Locales: ru
      static let reachedDailyGoal = Rswift.StringResource(key: "Reached Daily Goal", tableName: "Localizable", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      
      /// ru translation: Внимание
      /// 
      /// Locales: ru
      static func attention(_: Void = ()) -> String {
        return NSLocalizedString("Attention", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: Вы действительно хотите остановить текущий таймер?
      /// 
      /// Locales: ru
      static func areYouSureYouWantToStopTheCurentPomodoro(_: Void = ()) -> String {
        return NSLocalizedString("Are you sure you want to stop the curent pomodoro?", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: Вы завершили свою дневную цель. Поздравляем.
      /// 
      /// Locales: ru
      static func youVeCompletedYourTargetForTheDatyCongratulations(_: Void = ()) -> String {
        return NSLocalizedString("You've completed your target for the daty! Congratulations!", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: Да
      /// 
      /// Locales: ru
      static func yes(_: Void = ()) -> String {
        return NSLocalizedString("Yes", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: Длинный отдых, мин
      /// 
      /// Locales: ru
      static func longBreakDurationMin(_: Void = ()) -> String {
        return NSLocalizedString("Long Break Duration, min", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: Добавить задачу
      /// 
      /// Locales: ru
      static func addAToDo(_: Void = ()) -> String {
        return NSLocalizedString("Add a to-do", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: Звук ВКЛ.
      /// 
      /// Locales: ru
      static func soundON(_: Void = ()) -> String {
        return NSLocalizedString("Sound ON", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: Звук ВЫКЛ.
      /// 
      /// Locales: ru
      static func soundOFF(_: Void = ()) -> String {
        return NSLocalizedString("Sound OFF", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: Кол-во Pomodoros на день
      /// 
      /// Locales: ru
      static func targetPomodorosPerDay(_: Void = ()) -> String {
        return NSLocalizedString("Target Pomodoros Per Day", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: Короткий отдых, мин
      /// 
      /// Locales: ru
      static func shortBreakDurationMin(_: Void = ()) -> String {
        return NSLocalizedString("Short Break Duration, min", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: Нет
      /// 
      /// Locales: ru
      static func no(_: Void = ()) -> String {
        return NSLocalizedString("No", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: Остановить таймер
      /// 
      /// Locales: ru
      static func stopTimer(_: Void = ()) -> String {
        return NSLocalizedString("Stop Timer", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: Отлично
      /// 
      /// Locales: ru
      static func ok(_: Void = ()) -> String {
        return NSLocalizedString("Ok", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: Очень длинная задача, советуем разбить на более короткие задачи.
      /// 
      /// Locales: ru
      static func aVeryLongTaskBreakTheTaskIntoSmaller(_: Void = ()) -> String {
        return NSLocalizedString("A very long task, break the task into smaller", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: Таймер, мин
      /// 
      /// Locales: ru
      static func pomodoroDurationMin(_: Void = ()) -> String {
        return NSLocalizedString("Pomodoro Duration, min", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: Цель достигнута!
      /// 
      /// Locales: ru
      static func reachedDailyGoal(_: Void = ()) -> String {
        return NSLocalizedString("Reached Daily Goal", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    /// This `R.string.main` struct is generated, and contains static references to 7 localization keys.
    struct main {
      /// ru translation: Button
      /// 
      /// Locales: ru
      static let gznQfQOTNormalTitle = Rswift.StringResource(key: "gzn-qf-QOT.normalTitle", tableName: "Main", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: TOMATO - DO
      /// 
      /// Locales: ru
      static let iB3TGTitle = Rswift.StringResource(key: "725-IB-3TG.title", tableName: "Main", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: Выполнено
      /// 
      /// Locales: ru
      static let aRTU6SUnTitle = Rswift.StringResource(key: "ART-u6-SUn.title", tableName: "Main", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: Добавить задачу
      /// 
      /// Locales: ru
      static let bbRZtW7cPlaceholder = Rswift.StringResource(key: "BbR-zt-w7c.placeholder", tableName: "Main", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: Задачи
      /// 
      /// Locales: ru
      static let haXPN0cgTitle = Rswift.StringResource(key: "HaX-PN-0cg.title", tableName: "Main", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: СТАРТ
      /// 
      /// Locales: ru
      static let qiNmSdjNormalTitle = Rswift.StringResource(key: "6qi-Nm-sdj.normalTitle", tableName: "Main", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      /// ru translation: СТОП
      /// 
      /// Locales: ru
      static let wkc5RX3KNormalTitle = Rswift.StringResource(key: "Wkc-5R-x3K.normalTitle", tableName: "Main", bundle: R.hostingBundle, locales: ["ru"], comment: nil)
      
      /// ru translation: Button
      /// 
      /// Locales: ru
      static func gznQfQOTNormalTitle(_: Void = ()) -> String {
        return NSLocalizedString("gzn-qf-QOT.normalTitle", tableName: "Main", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: TOMATO - DO
      /// 
      /// Locales: ru
      static func iB3TGTitle(_: Void = ()) -> String {
        return NSLocalizedString("725-IB-3TG.title", tableName: "Main", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: Выполнено
      /// 
      /// Locales: ru
      static func aRTU6SUnTitle(_: Void = ()) -> String {
        return NSLocalizedString("ART-u6-SUn.title", tableName: "Main", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: Добавить задачу
      /// 
      /// Locales: ru
      static func bbRZtW7cPlaceholder(_: Void = ()) -> String {
        return NSLocalizedString("BbR-zt-w7c.placeholder", tableName: "Main", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: Задачи
      /// 
      /// Locales: ru
      static func haXPN0cgTitle(_: Void = ()) -> String {
        return NSLocalizedString("HaX-PN-0cg.title", tableName: "Main", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: СТАРТ
      /// 
      /// Locales: ru
      static func qiNmSdjNormalTitle(_: Void = ()) -> String {
        return NSLocalizedString("6qi-Nm-sdj.normalTitle", tableName: "Main", bundle: R.hostingBundle, comment: "")
      }
      
      /// ru translation: СТОП
      /// 
      /// Locales: ru
      static func wkc5RX3KNormalTitle(_: Void = ()) -> String {
        return NSLocalizedString("Wkc-5R-x3K.normalTitle", tableName: "Main", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
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
        if UIKit.UIImage(named: "microphone") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'microphone' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "settingIcon") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'settingIcon' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "microfoneForController") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'microfoneForController' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "goToTimer") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'goToTimer' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "goToTimerDisable") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'goToTimerDisable' is used in storyboard 'Main', but couldn't be loaded.") }
        if _R.storyboard.main().addTaskViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'addTaskViewController' could not be loaded from storyboard 'Main' as 'AddTaskViewController'.") }
        if _R.storyboard.main().pomodoroViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'pomodoroViewController' could not be loaded from storyboard 'Main' as 'PomodoroViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
