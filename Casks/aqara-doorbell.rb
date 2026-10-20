cask "aqara-doorbell" do
  version "0.1.2"
  sha256 "cec4192456134d469c7b871ab803950de60aad202e1bb343edc0d3f5bf2e61f5"

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
