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
+@@ -1236,12 +1236,8 @@
+	(5735 - 5835 @ 80), (30)
+
+ country US: DFS-FCC
+-	(2402 - 2472 @ 40), (30)
+-	# 5.15 ~ 5.25 GHz: 30 dBm for master mode, 23 dBm for clients
+-	(5170 - 5250 @ 80), (23), AUTO-BW
+-	(5250 - 5330 @ 80), (23), DFS, AUTO-BW
+-	(5490 - 5730 @ 160), (23), DFS
+-	(5735 - 5835 @ 80), (30)
++	(2402 - 2483.5 @ 40), (30)
++	(5150 - 5835 @ 80), (30)
+	# 60g band
+	# reference: http://cfr.regstoday.com/47cfr15.aspx#47_CFR_15p255
+	# channels 1,2,3, EIRP=40dBm(43dBm peak)