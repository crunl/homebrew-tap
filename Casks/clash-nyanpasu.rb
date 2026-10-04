cask "clash-nyanpasu" do
  version "2.0.1-alpha,676463e"

  on_arm do
    sha256 "0b6b483f317abd7c634a7d81147b575fa8008cd0833b90a52997bc7a9bf8658f"

    url "https://github.com/libnyanpasu/clash-nyanpasu/releases/download/pre-release/Clash.Nyanpasu_#{version.csv.first}%2B#{version.csv.second}_aarch64.dmg",
        verified: "github.com/libnyanpasu/clash-nyanpasu/"
  end
  on_intel do
    sha256 "14f6bc72871c74fe34a99dd396723ce81e473b33ff3c11426817dfe111750efa"

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
