cask "aqara-doorbell" do
  version "0.1.0"
  sha256 "7bdc27e0a643d57afb7e650423ad3159c499a566d7b6b01dd0cc12db82944903"

  url "https://github.com/nxm/aqara-doorbell/releases/download/v#{version}/AqaraDoorbell-#{version}.zip"
  name "Aqara Doorbell"
  desc "Unofficial menu-bar client for the Aqara G410 video doorbell"
  homepage "https://github.com/nxm/aqara-doorbell"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "AqaraDoorbell.app"

  # Ad-hoc signed, not notarized (no paid Apple Developer ID): clear the
  # quarantine flag so Gatekeeper lets the app open.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/AqaraDoorbell.app"]
  end

  uninstall quit: "io.github.nxm.aqara-doorbell"

  zap trash: [
    "~/.config/aqara-doorbell",
    "~/Library/Preferences/io.github.nxm.aqara-doorbell.plist",
  ]
end
