local mp = require('mp')

local function subprocess(args, stdin_data, detach)
  return mp.command_native({
    name = "subprocess",
    playback_only = false,
    args = args,
    stdin_data = stdin_data,

    -- If the streams are not _captured_ it will spam console log...
    capture_stdout = true and (detach == nil or not detach),
    capture_stderr = true and (detach == nil or not detach),
    detach         = detach,
  })
end

if subprocess({"zbarimg", "--version"}).status ~= 0 then
  mp.log("error", "zbarimg is not installed")
  return
end

local function scan_image(callback)

  return function()
    local filename = os.tmpname()

    mp.commandv("screenshot-to-file", filename)

    local zbarimg = subprocess({"zbarimg", "-q", filename})

    os.remove(filename)

    if zbarimg.status ~= 0 then
      mp.log("warn", "No valid qr code")
      return
    end

    local qr_data = zbarimg.stdout:sub(string.len("QR-Code:") + 1, -2)

    callback(qr_data)
  end
end


if subprocess({"xclip", "-quiet", "-version"}).status == 0 then
  mp.add_key_binding("ctrl+q", "copy-qr-code", scan_image(function(data)
    subprocess({"xclip", "-selection", "clipboard"}, data, true)
    -- subprocess({"/tmp/test.sh"}, data, true)
    mp.osd_message("QR code copied to clipboard")
  end))
end


if subprocess({"xdg-open", "--version"}).status == 0 then
  mp.add_key_binding("ctrl+shift+q", "open-qr-code", scan_image(function(data)
    subprocess({"xdg-open", data})
  end))
end
