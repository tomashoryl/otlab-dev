# 2025-05-15 16:21:55 by RouterOS 7.18
# system id = gnOJWLZolAI
#
:delay 5
/interface bridge add admin-mac=4C:5E:0C:09:09:12 auto-mac=no name=bridge pvid=99 vlan-filtering=yes
/interface ethernet set [ find default-name=ether1 ] comment=mgmt-port disable-running-check=no
/interface ethernet set [ find default-name=ether2 ] disable-running-check=no
/interface ethernet set [ find default-name=ether3 ] disable-running-check=no
/interface ethernet set [ find default-name=ether4 ] disable-running-check=no
/interface ethernet set [ find default-name=ether5 ] disable-running-check=no
/interface ethernet set [ find default-name=ether6 ] disable-running-check=no
/interface ethernet set [ find default-name=ether7 ] disable-running-check=no
/interface ethernet set [ find default-name=ether8 ] comment=sw-acc2 disable-running-check=no
/interface ethernet set [ find default-name=ether9 ] comment="sw-acc1 (bond)" disable-running-check=no
/interface ethernet set [ find default-name=ether10 ] comment="sw-acc1 (bond)" disable-running-check=no
/interface ethernet set [ find default-name=ether11 ] comment="gw (bond)" disable-running-check=no
/interface ethernet set [ find default-name=ether12 ] comment="gw (bond)" disable-running-check=no
/interface bonding add mode=802.3ad name=bond-gw slaves=ether11,ether12
/interface bonding add mode=802.3ad name=bond-sw-acc1 slaves=ether9,ether10
/port set 0 name=serial0
/interface bridge port add bridge=bridge edge=no frame-types=admit-only-vlan-tagged interface=bond-gw learn=yes multicast-router=disabled point-to-point=no pvid=99
/interface bridge port add bridge=bridge edge=no frame-types=admit-only-vlan-tagged interface=bond-sw-acc1 learn=yes multicast-router=disabled point-to-point=no pvid=99
/interface bridge port add bridge=bridge edge=no frame-types=admit-only-vlan-tagged interface=ether8 learn=yes multicast-router=disabled point-to-point=no pvid=99
/interface bridge vlan add bridge=bridge comment=VLAN10 tagged=bond-gw,bond-sw-acc1,ether8 vlan-ids=10
/interface bridge vlan add bridge=bridge comment=VLAN20 tagged=bond-gw,bond-sw-acc1,ether8 vlan-ids=20
/system identity set name=clab-ot-net101-sw-dist
/system note set show-at-login=no
