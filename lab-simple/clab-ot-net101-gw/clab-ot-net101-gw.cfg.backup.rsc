# 2025-05-15 16:21:55 by RouterOS 7.18
# system id = MLpVYGLZIRP
#
:delay 5
/interface bridge add admin-mac=4C:5E:0C:09:09:11 auto-mac=no name=bridge pvid=99 vlan-filtering=yes
/interface ethernet set [ find default-name=ether1 ] comment=mgmt-port disable-running-check=no
/interface ethernet set [ find default-name=ether2 ] comment=internet disable-running-check=no
/interface ethernet set [ find default-name=ether3 ] disable-running-check=no
/interface ethernet set [ find default-name=ether4 ] disable-running-check=no
/interface ethernet set [ find default-name=ether5 ] disable-running-check=no
/interface ethernet set [ find default-name=ether6 ] disable-running-check=no
/interface ethernet set [ find default-name=ether7 ] disable-running-check=no
/interface ethernet set [ find default-name=ether8 ] disable-running-check=no
/interface ethernet set [ find default-name=ether9 ] disable-running-check=no
/interface ethernet set [ find default-name=ether10 ] disable-running-check=no
/interface ethernet set [ find default-name=ether11 ] comment="sw-dist (bond)" disable-running-check=no
/interface ethernet set [ find default-name=ether12 ] comment="sw-dist (bond)" disable-running-check=no
/interface vlan add comment=VLAN10 interface=bridge mtu=1496 name=vlan10 vlan-id=10
/interface vlan add comment=VLAN20 interface=bridge mtu=1496 name=vlan20 vlan-id=20
/interface bonding add mode=802.3ad name=bond-sw-dist slaves=ether11,ether12
/interface list add comment="Interfaces to masquerade" name=toMasquerade
/port set 0 name=serial0
/interface bridge port add bridge=bridge edge=no frame-types=admit-only-vlan-tagged interface=bond-sw-dist learn=yes multicast-router=disabled point-to-point=no pvid=99
/interface bridge vlan add bridge=bridge comment=VLAN10 tagged=bridge,bond-sw-dist vlan-ids=10
/interface bridge vlan add bridge=bridge comment=VLAN20 tagged=bridge,bond-sw-dist vlan-ids=20
/interface list member add interface=vlan10 list=toMasquerade
/interface list member add interface=vlan20 list=toMasquerade
/ip address add address=1.1.1.2/24 interface=ether2 network=1.1.1.0
/ip address add address=10.10.0.1/24 interface=vlan10 network=10.10.0.0
/ip address add address=10.20.0.1/24 interface=vlan20 network=10.20.0.0
/ip dns set allow-remote-requests=yes
/ip dns static add address=1.1.1.1 name=internet type=A
/ip dns static add address=10.10.0.11 name=host1 type=A
/ip dns static add address=10.20.0.12 name=host2 type=A
/ip dns static add address=10.10.0.13 name=host3 type=A
/ip dns static add address=10.10.0.1 name=vlan10-gw type=A
/ip dns static add address=10.20.0.1 name=vlan20-gw type=A
/ip dns static add address=1.1.1.2 name=gw-ext type=A
/ip firewall nat add action=src-nat chain=srcnat in-interface-list=toMasquerade to-addresses=1.1.1.2
/system identity set name=clab-ot-net101-gw
/system note set show-at-login=no
