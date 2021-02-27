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
@@ -0,0 +1,19 @@
+Tweak for international waters.
+---
+--- a/db.txt
++++ b/db.txt
+@@ -1579,13 +1579,13 @@ country US: DFS-FCC
+	(2400 - 2472 @ 40), (30)
+	# 5.15 ~ 5.25 GHz: 30 dBm for master mode, 23 dBm for clients
+-	(5150 - 5250 @ 80), (23), AUTO-BW
++	(5150 - 5250 @ 80), (30), AUTO-BW
+-	(5250 - 5350 @ 80), (23), DFS, AUTO-BW
++	(5250 - 5350 @ 80), (30), DFS, AUTO-BW
+	# This range ends at 5725 MHz, but channel 144 extends to 5730 MHz.
+	# Since 5725 ~ 5730 MHz belongs to the next range which has looser
+	# requirements, we can extend the range by 5 MHz to make the kernel
+	# happy and be able to use channel 144.
+-	(5470 - 5730 @ 160), (23), DFS
++	(5470 - 5730 @ 160), (23)
+	(5730 - 5850 @ 80), (30)
+	# 60g band
+	# reference: section IV-D https://docs.fcc.gov/public/attachments/FCC-16-89A1.pdf
EOF

( cd $base_feed && git apply $patch_file && {
  echo "Patch applied, now you can use the special country US when you deploy a mesh network on International Waters"
} || echo "Patch does not apply, maybe it is already applied or OpenWrt source has changed" )
