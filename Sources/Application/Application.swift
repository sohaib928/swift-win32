/**
 * Copyright © 2019 Saleem Abdulrasool <compnerd@compnerd.org>
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/// The centralised point of control and coordination for running applications.
public class Application: Responder {
  /// Getting the Application Instance

  /// Returns the singleton application instance.
  public static var shared: Application = Application()

  /// Managing the Application's Behaviour

  /// The delegate of the application object.
  public var delegate: ApplicationDelegate?

  /// Getting the Application State

  /// The applications current state or that of its most active scene.
  public internal(set) var state: Application.State

  /// Getting Scene Information

  /// A boolean indicating whether the application may display multiple scenes.
  public var supportsMultipleScenes: Bool {
    // TODO(compnerd) deserialise this from Info.plist in the bundle
    false
  }

  /// The application's currently connected scenes.
  public internal(set) var connectedScenes: Set<Scene> = []

  /// The sessions whose scenes are either currently active or archived by the
  /// system.
  public internal(set) var openSessions: Set<SceneSession> = []

  /// Getting App Windows
  public internal(set) var keyWindow: Window?
  public internal(set) var windows: [Window]

  override public required init() {
    self.state = .active
    self.windows = []
    super.init()
  }

  // Responder Chain
  override public var next: Responder? {
    if let responder = self.delegate as? Responder,
       !(self.delegate is View), !(self.delegate is ViewController),
       !(self.delegate === self) {
      return responder
    }
    return nil
  }

  internal var information: Information?
}

extension Application {
  /// The running states of the application
  public enum State: Int {
  /// The application is running in the foreground
  case active
  case inactive
  /// The application is running in the background
  case background
  }
}
