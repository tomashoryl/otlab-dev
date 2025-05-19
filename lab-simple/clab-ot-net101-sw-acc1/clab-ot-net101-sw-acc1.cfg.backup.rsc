# 2025-05-15 16:21:55 by RouterOS 7.18
# system id = HJQAeNGFKFK
#
:delay 5
/interface bridge add admin-mac=4C:5E:0C:09:09:13 auto-mac=no name=bridge pvid=99 vlan-filtering=yes
/interface ethernet set [ find default-name=ether1 ] comment=mgmt-port disable-running-check=no
/interface ethernet set [ find default-name=ether2 ] comment=host1 disable-running-check=no
/interface ethernet set [ find default-name=ether3 ] comment=host2 disable-running-check=no
/interface ethernet set [ find default-name=ether4 ] disable-running-check=no
/interface ethernet set [ find default-name=ether5 ] disable-running-check=no
/interface ethernet set [ find default-name=ether6 ] disable-running-check=no
/interface ethernet set [ find default-name=ether7 ] disable-running-check=no
/interface ethernet set [ find default-name=ether8 ] disable-running-check=no
/interface ethernet set [ find default-name=ether9 ] disable-running-check=no
/interface ethernet set [ find default-name=ether10 ] comment=sw-acc2 disable-running-check=no
/interface ethernet set [ find default-name=ether11 ] comment="sw-dist (bond)" disable-running-check=no
/interface ethernet set [ find default-name=ether12 ] comment="sw-dist (bond)" disable-running-check=no
/interface bonding add mode=802.3ad name=bond-sw-dist slaves=ether11,ether12
/port set 0 name=serial0
/interface bridge port add bridge=bridge edge=no frame-types=admit-only-vlan-tagged interface=bond-sw-dist learn=yes multicast-router=disabled point-to-point=no pvid=99
/interface bridge port add bridge=bridge edge=no frame-types=admit-only-vlan-tagged interface=ether10 learn=yes multicast-router=disabled point-to-point=no pvid=99
/interface bridge port add bpdu-guard=yes bridge=bridge edge=yes frame-types=admit-only-untagged-and-priority-tagged interface=ether2 learn=yes multicast-router=disabled point-to-point=no pvid=10
/interface bridge port add bpdu-guard=yes bridge=bridge edge=yes frame-types=admit-only-untagged-and-priority-tagged interface=ether3 learn=yes multicast-router=disabled point-to-point=no pvid=20
/interface bridge vlan add bridge=bridge comment=VLAN10 tagged=bond-sw-dist,ether10 vlan-ids=10
/interface bridge vlan add bridge=bridge comment=VLAN20 tagged=bond-sw-dist,ether10 vlan-ids=20
/system identity set name=clab-ot-net101-sw-acc1
/system note set show-at-login=no
