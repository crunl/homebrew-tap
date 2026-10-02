cask "clash-nyanpasu" do
  version "2.0.0-alpha,946a79a"

  on_arm do
    sha256 "ad548c18119a877549199dcdd7bd1bb95bed281e352e89edcec55ef8932109e2"

    url "https://github.com/libnyanpasu/clash-nyanpasu/releases/download/pre-release/Clash.Nyanpasu_#{version.csv.first}%2B#{version.csv.second}_aarch64.dmg",
        verified: "github.com/libnyanpasu/clash-nyanpasu/"
  end
  on_intel do
    sha256 "4159ea2794c1ad0d0721f96fd0e542f001d5d003474a24d0a1ee651778b32c85"

    url "https://github.com/libnyanpasu/clash-nyanpasu/releases/download/pre-release/Clash.Nyanpasu_#{version.csv.first}%2B#{version.csv.second}_x64.dmg",
        verified: "github.com/libnyanpasu/clash-nyanpasu/"
  end

  name "Clash Nyanpasu"
  desc "Clash GUI based on Tauri (nightly build)"
  homepage "https://nyanpasu.elaina.moe/"

  livecheck do
    url "https://api.github.com/repos/libnyanpasu/clash-nyanpasu/releases/tags/pre-release"
    regex(/Clash\.Nyanpasu_(\d+(?:\.\d+)*(?:-\w+)?)\+(\h+)_aarch64\.dmg/i)
    strategy :json do |json, regex|
      json["assets"]&.filter_map do |asset|
        match = asset["name"]&.match(regex)
        next if match.blank?

        "#{match[1]},#{match[2]}"
      end
    end
  end

  depends_on :macos

  app "Clash Nyanpasu.app"

  zap trash: [
    "~/Library/Application Support/Clash Nyanpasu",
    "~/Library/Application Support/moe.elaina.clash.nyanpasu",
    "~/Library/Caches/moe.elaina.clash.nyanpasu",
    "~/Library/Preferences/moe.elaina.clash.nyanpasu.plist",
    "~/Library/Saved Application State/moe.elaina.clash.nyanpasu.savedState",
    "~/Library/WebKit/moe.elaina.clash.nyanpasu",
  ]
end
