#!/bin/bash
. options.conf

base_feed="$feeds_dir/base"
echo "Patch will be applied to $base_feed"

[ ! -d $base_feed ] && {
  echo "$base_feed does not exist. Before applying this snippet you must clone the feeds (option -f of cooker)"
  exit 1
}

patch_file="$PWD/$tmp_dir/regdb.patch"

cat > $patch_file << EOF
diff --git a/package/firmware/wireless-regdb/patches/999-regdbus.patch b/package/firmware/wireless-regdb/patches/999-regdbus.patch
new file mode 100644
index 0000000000..30213bdeda
--- /dev/null
+++ b/package/firmware/wireless-regdb/patches/999-regdbus.patch
@@ -0,0 +1,36 @@
+Tweak for international waters.
+---
+--- a/db.txt
++++ b/db.txt
+@@ -1717,27 +1717,27 @@
+ country US: DFS-FCC
+	# S1G Channel 1-3
+	(902 - 904 @ 2), (30)
+	# S1G Channel 5-35
+	(904 - 920 @ 16), (30)
+	# S1G Channel 37-51
+	(920 - 928 @ 8), (30)
+	(2400 - 2472 @ 40), (30)
+	# 5.15 ~ 5.25 GHz: 30 dBm for master mode, 23 dBm for clients
+-	(5150 - 5250 @ 80), (23), AUTO-BW
+-	(5250 - 5350 @ 80), (24), DFS, AUTO-BW
++	(5150 - 5250 @ 80), (30), AUTO-BW
++	(5250 - 5350 @ 80), (30), AUTO-BW
+	# This range ends at 5725 MHz, but channel 144 extends to 5730 MHz.
+	# Since 5725 ~ 5730 MHz belongs to the next range which has looser
+	# requirements, we can extend the range by 5 MHz to make the kernel
+	# happy and be able to use channel 144.
+-	(5470 - 5730 @ 160), (24), DFS
++	(5470 - 5730 @ 160), (30)
+	(5730 - 5850 @ 80), (30), AUTO-BW
+	# https://www.federalregister.gov/documents/2021/05/03/2021-08802/use-of-the-5850-5925-ghz-band
+	# max. 33 dBm AP @ 20MHz, 36 dBm AP @ 40Mhz+, 6 dB less for clients
+-	(5850 - 5895 @ 40), (27), NO-OUTDOOR, AUTO-BW, NO-IR
++	(5850 - 5895 @ 40), (30), NO-OUTDOOR, AUTO-BW, NO-IR
+	# 6g band
+	# https://www.federalregister.gov/documents/2020/05/26/2020-11236/unlicensed-use-of-the-6ghz-band
+	(5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
+	# 60g band
+	# reference: section IV-D https://docs.fcc.gov/public/attachments/FCC-16-89A1.pdf
+	# channels 1-6 EIRP=40dBm(43dBm peak)
+	(57240 - 71000 @ 2160), (40)
EOF

( cd $base_feed && git apply $patch_file && {
  echo "Patch applied, now you can use the special country US when you deploy a mesh network on International Waters"
} || echo "Patch does not apply, maybe it is already applied or OpenWrt source has changed" )

