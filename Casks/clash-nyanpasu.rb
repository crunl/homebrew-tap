cask "clash-nyanpasu" do
  version "2.0.0-alpha,83fbe50"

  on_arm do
    sha256 "92268de05ab4dba2271245a448fb80f617992343248e2e1b2a8b2aa68e1d2508"

    url "https://github.com/libnyanpasu/clash-nyanpasu/releases/download/pre-release/Clash.Nyanpasu_#{version.csv.first}%2B#{version.csv.second}_aarch64.dmg",
        verified: "github.com/libnyanpasu/clash-nyanpasu/"
  end
  on_intel do
    sha256 "0b5b49a74db7914998a6a793f23a498f9a702c45d959bb171b4c4bb31ad13661"

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
