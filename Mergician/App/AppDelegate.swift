import AppKit
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
    lazy var statusBarItem = makeStatusBarItem()
    lazy var popover = makePopover()

    func applicationDidFinishLaunching(_ notification: Notification) {
        popover.contentViewController = NSHostingController(rootView: PopoverView())
        configure(statusBarItem.button)
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        guard let button = statusBarItem.button else { return }
        if popover.isShown {
            popover.performClose(sender)
        } else {
            popover.show(
                relativeTo: button.bounds,
                of: button,
                preferredEdge: NSRectEdge.minY
            )
        }
    }

    private func configure(_ button: NSStatusBarButton?) {
        guard let button = button else { return }

        button.image = NSImage(named: "MenuIcon")
        button.action = #selector(togglePopover(_:))
    }

    private func makeStatusBarItem() -> NSStatusItem {
        NSStatusBar.system.statusItem(
            withLength: NSStatusItem.squareLength
        )
    }

    private func makePopover() -> NSPopover {
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 400, height: 400)
        popover.behavior = .transient
        popover.animates = true
        return popover
    }
}
