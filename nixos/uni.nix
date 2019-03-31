{ config, pkgs, ... }:

{
  systemd = {
    services = {
      # TODO: Replace the user and put your password in /etc/nixos/uni-pw.secret
      "uni-vpn" = {
        description = "Connect to the VPN network of the University of Tübingen";
        path = with pkgs; [ openconnect_gnutls nettools iproute openresolv ];
        serviceConfig = {
          Type = "forking";
          PIDFile = "/run/openconnect.pid";
        };
        script = ''
          ${pkgs.openconnect_gnutls}/bin/openconnect \
            --background --pid-file=/run/openconnect.pid --no-system-trust \
            --cafile=/etc/ssl/certs/T-TeleSec_GlobalRoot_Class_2.pem --pfs \
            --compression=none --interface=tun0 --user=zxmXXXX(TODO) --non-inter \
            --passwd-on-stdin 'https://ras2.uni-tuebingen.de/' \
            < /etc/nixos/uni-pw.secret # TODO
        '';
        postStart = ''
          ${pkgs.coreutils}/bin/sleep 5;
          ${pkgs.iproute}/bin/ip route add 134.2.0.0/16 dev tun0
        '';
        preStop = ''
          ${pkgs.iproute}/bin/ip route del 134.2.0.0/16 dev tun0
          ${pkgs.openresolv}/bin/resolvconf -d tun0
        '';
      };
    };
  };
}
