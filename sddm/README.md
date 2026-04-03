# SDDM Theme — arch-spectrum

Dark Side of the Moon aesthetic: deep space wallpaper, spectrum rainbow
border, dark card, large clock. Matches the Hyprland arch-spectrum theme.

## Install

```bash
sudo cp -r themes/arch-spectrum /usr/share/sddm/themes/
sudo cp "~/Pictures/wallpaper/Deep Space Arch Linux Logo with Spectrum.png" \
    /usr/share/sddm/themes/arch-spectrum/background.png
sudo mkdir -p /etc/sddm.conf.d
echo -e "[Theme]\nCurrent=arch-spectrum" | sudo tee /etc/sddm.conf.d/theme.conf
```

## Test without rebooting

```bash
sddm-greeter --test-mode --theme /usr/share/sddm/themes/arch-spectrum
```

## Update after editing

After editing files in this directory, re-run the install step to copy
changes into `/usr/share/sddm/themes/arch-spectrum/`.
