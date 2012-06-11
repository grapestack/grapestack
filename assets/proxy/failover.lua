function connect_server()
    if proxy.global.backends[1].state == proxy.BACKEND_STATE_DOWN then
        proxy.connection.backend_ndx = 2
    else
        proxy.connection.backend_ndx = 1
    end
--    print ("s Connecting: " .. proxy.global.backends[proxy.connection.backend_ndx].dst.name)
end

function read_query(packet)
    if proxy.global.backends[1].state == proxy.BACKEND_STATE_DOWN then
        proxy.connection.backend_ndx = 2
    else
        proxy.connection.backend_ndx = 1
    end
--    print ("q Connecting: " .. proxy.global.backends[proxy.connection.backend_ndx].dst.name)
end