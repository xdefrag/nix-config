{
  services.openvpn.servers = {
    expressvpn-europe = {
      autoStart = false;
      config = '' config /root/.vpn/expressvpn-europe/my_expressvpn_netherlands_-_rotterdam_udp.ovpn '';
    };
    expressvpn-usa = {
      autoStart = false;
      config = '' config /root/.vpn/expressvpn-usa/expressvpn-usa.ovpn '';
    };
  };
}
