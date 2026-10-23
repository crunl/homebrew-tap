cask "clash-nyanpasu" do
  version "2.0.1-alpha,f86a20b"

  on_arm do
    sha256 "22289c54fbed7d3212f9c58164fb16db49b1d0d65cf959699fba1dc0e9ae3fe8"

    url "https://github.com/libnyanpasu/clash-nyanpasu/releases/download/pre-release/Clash.Nyanpasu_#{version.csv.first}%2B#{version.csv.second}_aarch64.dmg",
        verified: "github.com/libnyanpasu/clash-nyanpasu/"
  end
  on_intel do
    sha256 "10a997fb863d5aed55682b0c539a6bcd481e943a2a9dd54b3a35223592d647d4"

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
