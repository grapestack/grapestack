function connect_server()
  for i = 1, #proxy.backends do
    local s = proxy.backends[i]

    if s.state ~= proxy.BACKEND_STATE_DOWN then
      proxy.connection.backend_ndx = i
--      print ("connecting to " .. i)
      return
    end
  end
end

function read_query(packet)
  for i = 1, #proxy.backends do
    local s = proxy.backends[i]

    if s.state ~= proxy.BACKEND_STATE_DOWN then
      proxy.connection.backend_ndx = i
--      print ("connecting to " .. i)
      return
    end
  end
end