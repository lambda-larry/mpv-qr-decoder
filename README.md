mpv QR decoder
==============

Scans the image for QR code and saves it to clipboard.

Features
--------

- Saves QR code to clipboard (ctrl+q).
- Opens the URI with `xdg-open` (ctrl+shift+q).

Supported platform
------------------

- Linux (x11)

### Pull requests are welcome

- Linux wayland
- Windows
- MacOS

Requirement
-----------

- [zbar](https://github.com/mchehab/zbar), for scanning the image.
- (optional) [xdg-utils](https://www.freedesktop.org/wiki/Software/xdg-utils/), for open URI.
- (optional) [xclip](https://github.com/astrand/xclip), for qr code to clipboard.

Install
-------

```bash
git clone https://github.com/lambda-larry/mpv-qr-decoder ~/.config/mpv/scripts/mpv-qr-decoder
```
