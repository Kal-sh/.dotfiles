#!/usr/bin/env bash
# install-flatpaks.sh

flatpaks=(
  com.mattjakeman.ExtensionManager  
  org.localsend.localsend_app
  app.zen_browser.zen
  flathub io.mpv.Mpv
  org.telegram.desktop
  com.spotify.Client
  com.stremio.Stremio
  com.protonvpn.www
  com.github.dynobo.normcap
  io.github.milkshiift.GoofCord
  org.jdownloader.JDownloader
  com.brave.Browser
  #org.videolan.VLC
  #io.github.kolunmi.Bazaar
  #com.github.wwmm.easyeffects
  #org.pulseaudio.pavucontrol
)

echo "📦 Installing Flatpak apps..."
for app in "${flatpaks[@]}"; do
  if flatpak list | grep -q "$app"; then
    echo "✅ $app already installed"
  else
    echo "⬇️ Installing $app..."
    flatpak install -y flathub "$app"
  fi
done

echo "🎉 All apps installed!"

