cask "voicekey" do
  version "2.1.0"
  sha256 "b24b05d0d982cd5764365dd0257f03ed289ef5f6ac6bc62a9bb47d7178350886"

  url "https://github.com/Tomato-1101/voicekey/releases/download/v#{version}/voicekey-#{version}.zip"
  name "voicekey"
  desc "Push-to-talk voice input that types into the app you're using"
  homepage "https://github.com/Tomato-1101/voicekey"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Sparkle が自分で更新するので brew upgrade の対象にしない。
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "voicekey.app"

  # 公証していないので、Homebrew が付ける quarantine を外して Gatekeeper の警告を出さない（AeroSpace と同じ方式）。
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/voicekey.app"], must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/voicekey",
    "~/Library/Preferences/com.voicekey.app.plist",
  ]
end
