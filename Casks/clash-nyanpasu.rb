cask "clash-nyanpasu" do
  version "2.0.1-alpha,e15ba9b"

  on_arm do
    sha256 "038fbe21d5f9e6b004b6d36add6e2e31f2121178a5761e1c35f7e8fa957e5b6b"

    url "https://github.com/libnyanpasu/clash-nyanpasu/releases/download/pre-release/Clash.Nyanpasu_#{version.csv.first}%2B#{version.csv.second}_aarch64.dmg",
        verified: "github.com/libnyanpasu/clash-nyanpasu/"
  end
  on_intel do
    sha256 "c54148a6af71b14bfe33d38f17abfd3d4e5fdcdfc0b990addf5d68b1fe7c4d5c"

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
