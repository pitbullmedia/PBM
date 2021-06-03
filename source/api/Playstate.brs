function PlaystateUpdate(id, state as string, params = {})
  if state = "start" then
    url = "Sessions/Playing"
  else if state = "stop" then
    url = "Sessions/Playing/Stopped"
  else if state = "update"
    url = "Sessions/Playing/Progress"
  end if
  params = PlaystateDefaults(id, params)
  resp = APIRequest(url)
  return postJson(resp, params)
end function

function PlaystateDefaults(id="" as string, params={} as object)
  new_params = {
    '"CanSeek": false
    '"Item": "{}", ' TODO!
    '"NowPlayingQueue": "[]", ' TODO!
    '"PlaylistItemId": "",
    "ItemId": id,
    '"SessionId": "", ' TODO!
    '"MediaSourceId": id,
    '"AudioStreamIndex": 1,
    '"SubtitleStreamIndex": 0,
    "IsPaused": false,
    '"IsMuted": false,
    "PositionTicks": 0,
    '"PlaybackStartTimeTicks": 0,
    '"VolumeLevel": 100,
    '"Brightness": 100,
    '"AspectRatio": "16x9",
    '"PlayMethod": "DirectStream"
    '"LiveStreamId": "",
    '"PlaySessionId": "",
    '"RepeatMode": "RepeatNone"
  }
  for each p in params.items()
    new_params[p.key] = p.value
  end for
  return FormatJson(new_params)
end function

function deleteTranscode(id)
  devinfo = CreateObject("roDeviceInfo")
  device_id = devinfo.getChannelClientID()
  req = APIRequest("/Videos/ActiveEncodings", { "deviceID" : devinfo.getChannelClientID(),  "PlaySessionId": id })
  req.setRequest("DELETE")
  postVoid(req)
end function
