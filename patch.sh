#!/bin/sh
#
# Copyright (c) 2009-2013 Robert Nelson <robertcnelson@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Split out, so build_kernel.sh and build_deb.sh can share..

git="git am"

git_patchset="git://github.com/RobertCNelson/linux.git"
if [ -f ${DIR}/system.sh ] ; then
	. ${DIR}/system.sh
	if [ "${GIT_OVER_HTTP}" ] ; then
		git_patchset="https://github.com/RobertCNelson/linux.git"
	fi
fi

if [ "${RUN_BISECT}" ] ; then
	git="git apply"
fi

echo "Starting patch.sh"

git_add () {
	git add .
	git commit -a -m 'testing patchset'
}

start_cleanup () {
	git="git am --whitespace=fix"
}

cleanup () {
	git format-patch -${number} -o ${DIR}/patches/
	exit
}

imx_git () {
	tag="imx_3.0.35_jb4.1.2_1.0.0-beta_wandboard"
	echo "pulling: ${tag}"
	git pull ${GIT_OPTS} ${git_patchset} ${tag}
}

wandboard () {
	echo "dir: wandboard"

	#http://repo.or.cz/w/wandboard.git/shortlog/refs/heads/wandboard
	#Generated by:
	#git checkout v3.0.35 -b tmp
	#git pull --no-edit git://github.com/RobertCNelson/linux.git imx_3.0.35_jb4.1.2_1.0.0-beta_wandboard
	#git pull --no-edit git://repo.or.cz/wandboard.git wandboard
	#git rebase 699cd64427e41c9331e074fd51b651e548e87de0
	#git format-patch -232 | grep 'Wandboard-Add-support-for-PCI-Express.patch' ; rm -rf *.patch
	#0001-Wandboard-Add-support-for-PCI-Express.patch
	#git format-patch -231 -o /opt/github/imx-devel/patches/wandboard/
	#git checkout master -f ; git branch -D tmp

	${git} "${DIR}/patches/wandboard/0001-Wandboard-Add-author-s-names-to-the-board-file.patch"
	${git} "${DIR}/patches/wandboard/0002-ENGR00235626-FEC-Enable-phy-pause-frame-feature.patch"
	${git} "${DIR}/patches/wandboard/0003-ENGR00235624-Quad-DualLite-ARD-MTD-partition-non-ali.patch"
	${git} "${DIR}/patches/wandboard/0004-ENGR00236620-Add-fastboot-and-recovery-methods-for-i.patch"
	${git} "${DIR}/patches/wandboard/0005-ENGR00235370-4-pmic-Fix-the-bug-of-pmic-I2C.patch"
	${git} "${DIR}/patches/wandboard/0006-ENGR00235665-mxc_v4l2_capture-add-YV12-format-suppor.patch"
	${git} "${DIR}/patches/wandboard/0007-ENGR00236196-mxc_vout-add-YV12-format-support-in-enu.patch"
	${git} "${DIR}/patches/wandboard/0008-ENGR00236499-ASRC-fix-build-warning.patch"
	${git} "${DIR}/patches/wandboard/0009-ENGR00235817-mx6-use-SNVS-LPGPR-register-to-store-bo.patch"
	${git} "${DIR}/patches/wandboard/0010-ENGR00236020-1-ALSA-add-calling-of-trigger-in-machin.patch"
	${git} "${DIR}/patches/wandboard/0011-ENGR00236827-Enable-MPR121-capacitive-button-driver.patch"
	${git} "${DIR}/patches/wandboard/0012-ENGR00236827-1-Enable-MPR121-capacitive-button-drive.patch"
	${git} "${DIR}/patches/wandboard/0013-gpu-ion-several-bugfixes-and-enhancements-of-ION.patch"
	${git} "${DIR}/patches/wandboard/0014-ENGR00236834-RTC-fix-a-crash-in-mxc_rtc_read_time-wh.patch"
	${git} "${DIR}/patches/wandboard/0015-ENGR00236052-add-keychord-driver-in-android-config.patch"
	${git} "${DIR}/patches/wandboard/0016-ENGR00236512-mmc-esdhc-make-sd3-and-sd2-have-same-pl.patch"
	${git} "${DIR}/patches/wandboard/0017-ENGR00179636-07-i.MX6-Enable-ethernet-NAPI-method-in.patch"
	${git} "${DIR}/patches/wandboard/0018-ENGR00236169-MX6-USB-kfree-udc_controller-when-remov.patch"
	${git} "${DIR}/patches/wandboard/0019-ENGR00235540-add-fbmem-config-for-sabreauto.patch"
	${git} "${DIR}/patches/wandboard/0020-ENGR00235540-1-reserve-mem-for-framebuffer-in-sabrea.patch"
	${git} "${DIR}/patches/wandboard/0021-ENGR00237520-MX6-PCIE-add-flag-to-keep-power-supply.patch"
	${git} "${DIR}/patches/wandboard/0022-ENGR00237520-mx6q_sabresd-Move-power-control-to-pcie.patch"
	${git} "${DIR}/patches/wandboard/0023-ENGR00235370-5-pmic-Fix-the-bug-of-wm8326-pmic.patch"
	${git} "${DIR}/patches/wandboard/0024-ENGR00237868-input-egalax_ts-remove-the-while-loop-f.patch"
	${git} "${DIR}/patches/wandboard/0025-ENGR00237678-IPUv3-Clean-up-sync-and-error-interrupt.patch"
	${git} "${DIR}/patches/wandboard/0026-ENGR00238052-Add-support-for-Android-RAM-console-for.patch"
	${git} "${DIR}/patches/wandboard/0027-ENGR00238053-Fix-the-bug-in-Fuse-read-for-VPU-and-GP.patch"
	${git} "${DIR}/patches/wandboard/0028-ENGR00238201-1-V4L2-ADV7180-enable-adv7180-in-Androi.patch"
	${git} "${DIR}/patches/wandboard/0029-ENGR00238201-2-V4L2-ADV7180-enable-adv7180-in-Androi.patch"
	${git} "${DIR}/patches/wandboard/0030-ENGR00238201-3-V4L2-ADV7180-enable-adv7180-in-Androi.patch"
	${git} "${DIR}/patches/wandboard/0031-ENGR00238276-rfkill-change-rfkill-node-permission.patch"
	${git} "${DIR}/patches/wandboard/0032-ENGR00235540-Change-the-menu-key-to-power-key-for-sa.patch"
	${git} "${DIR}/patches/wandboard/0033-ENGR00237588-Add-PTP-ctrl-request-func.patch"
	${git} "${DIR}/patches/wandboard/0034-ENGR00180079-rfkill-revert-change-rfkill-node-permis.patch"
	${git} "${DIR}/patches/wandboard/0035-ENGR00238357-MX6x-Change-HDMI-default-output-RGB.patch"
	${git} "${DIR}/patches/wandboard/0036-ENGR00238382-MX6-HDMI-Change-VGA-mode-flag-adjust-de.patch"
	${git} "${DIR}/patches/wandboard/0037-ENGR00238384-MX6x-HDMI-Update-HDMI-setting-when-HDMI.patch"
	${git} "${DIR}/patches/wandboard/0038-ENGR00238391-MX6x-HDMI-Add-default-EDID-config-funct.patch"
	${git} "${DIR}/patches/wandboard/0039-ENGR00239187-input-novatek_ts-fix-some-point-not-rel.patch"
	${git} "${DIR}/patches/wandboard/0040-ENGR00238882-yaffs2-fix-yaffs2-build.patch"
	${git} "${DIR}/patches/wandboard/0041-ENGR00238947-GPU-Integrate-Vivante-4.6.9p10-gpu-driv.patch"
	${git} "${DIR}/patches/wandboard/0042-ENGR00240112-1-caam-fix-user-space-crypto-API-suppor.patch"
	${git} "${DIR}/patches/wandboard/0043-ENGR00240112-2-crypto-caam-add-ecb-aes-crypto-algori.patch"
	${git} "${DIR}/patches/wandboard/0044-ENGR00240740-1-IPUv3-Workaround-Android-bootup-ipu-e.patch"
	${git} "${DIR}/patches/wandboard/0045-ENGR00240740-2-ARM-IPUv3-Add-an-interface-to-disable.patch"
	${git} "${DIR}/patches/wandboard/0046-ENGR00240740-3-IPUv3-fb-Workaround-Android-bootup-ip.patch"
	${git} "${DIR}/patches/wandboard/0047-ENGR00239734-Mx6-HDMI-PHY-Add-2-variable-to-pass-boa.patch"
	${git} "${DIR}/patches/wandboard/0048-ENGR00241251-imx6_sabreauto-workaround-touch-screen-.patch"
	${git} "${DIR}/patches/wandboard/0049-ENGR00241251-input-egalax_ts-not-suspend-when-not-ab.patch"
	${git} "${DIR}/patches/wandboard/0050-ENGR00241777-fix-rare-kernel-panic-by-gpu-lowmem-kil.patch"
	${git} "${DIR}/patches/wandboard/0051-ENGR00241962-Add-another-hdmi-switch-for-hdmi-driver.patch"
	${git} "${DIR}/patches/wandboard/0052-fix-a-couple-uninitialized-variables.patch"
	${git} "${DIR}/patches/wandboard/0053-Wandboard-Fix-SDHC-platform-data.patch"
	${git} "${DIR}/patches/wandboard/0054-kernel-header-missing-during-installation.patch"
	${git} "${DIR}/patches/wandboard/0055-Don-t-touch-iMX6-SATA-clock-on-other-than-iMX6Q.patch"
	${git} "${DIR}/patches/wandboard/0056-ENGR00235086-I2C-update-i2c-clock-divider-for-each-t.patch"
	${git} "${DIR}/patches/wandboard/0057-ENGR00235363-I2C-fix-kernel-crash-due.patch"
	${git} "${DIR}/patches/wandboard/0058-ENGR00236837-MX6SL-Fix-random-crash-caused-by-incorr.patch"
	${git} "${DIR}/patches/wandboard/0059-ENGR00229855-mx6sl-csi-can-not-support-two-camera-in.patch"
	${git} "${DIR}/patches/wandboard/0060-ENGR00236137-mx6sl-csi-Change-video-buffer-access-mo.patch"
	${git} "${DIR}/patches/wandboard/0061-ENGR00236722-mx6sl-csi-Ensure-dma-reflash-operation-.patch"
	${git} "${DIR}/patches/wandboard/0062-ENGR00231808-Add-epdc-pmic-shut-down-feature.patch"
	${git} "${DIR}/patches/wandboard/0063-ENGR00237742-busfreq-fix-IPG_PERCLK-will-be-decrease.patch"
	${git} "${DIR}/patches/wandboard/0064-ENGR00238439-ASRC-add-delay-before-reading-ASRC-FIFO.patch"
	${git} "${DIR}/patches/wandboard/0065-ENGR00238809-1-mx6sl-clock-add-dependency-of-IRAM-cl.patch"
	${git} "${DIR}/patches/wandboard/0066-ENGR00238809-2-mx6sl-ssi-add-IRAM-support.patch"
	${git} "${DIR}/patches/wandboard/0067-ENGR00238237-1-mx6sl-csi-v4l-fix-camera-picture-flic.patch"
	${git} "${DIR}/patches/wandboard/0068-ENGR00238237-2-mx6sl-csi-v4l-Initialize-the-variable.patch"
	${git} "${DIR}/patches/wandboard/0069-ENGR00238813-ASRC-add-check-before-release-ASRC-pair.patch"
	${git} "${DIR}/patches/wandboard/0070-ENGR00239062-MX6X-HDMI-add-1440x240p60-mode-support.patch"
	${git} "${DIR}/patches/wandboard/0071-ENGR00232879-mx6sl-EPDC-VDDH-and-VPOS-power-on-off-s.patch"
	${git} "${DIR}/patches/wandboard/0072-fix-echo-1-compact_memory-return-error-issue.patch"
	${git} "${DIR}/patches/wandboard/0073-ENGR00237364-board-mx6q_sabreauto-fix-adv7180-tvin-p.patch"
	${git} "${DIR}/patches/wandboard/0074-ENGR00237682-1-mxc_v4l2_capture-ov5640-use-global-in.patch"
	${git} "${DIR}/patches/wandboard/0075-ENGR00237706-mxc_v4l2_capture-ov5640-correct-the-beh.patch"
	${git} "${DIR}/patches/wandboard/0076-ENGR00237682-2-mxc_v4l2_capture-ov5640-support-all-s.patch"
	${git} "${DIR}/patches/wandboard/0077-ENGR00237682-3-mxc_v4l2_capture-ov5640-support-scali.patch"
	${git} "${DIR}/patches/wandboard/0078-ENGR00232755-USB-disable-clock-and-abnormal-wakeup-w.patch"
	${git} "${DIR}/patches/wandboard/0079-ENGR00239207-MX6x-HDMI-add-some-support-modes.patch"
	${git} "${DIR}/patches/wandboard/0080-ENGR00239569-Mx6x-HDMI-Add-RGB-YCbCr-output-select-v.patch"
	${git} "${DIR}/patches/wandboard/0081-ENGR00239905-PCIe-Enable-PCIe-switch-support.patch"
	${git} "${DIR}/patches/wandboard/0082-ENGR00240298-IMX-IPU-Optimize-IPU-resize-performance.patch"
	${git} "${DIR}/patches/wandboard/0083-ENGR00240571-mtd-gpmi-fix-the-compiler-warning.patch"
	${git} "${DIR}/patches/wandboard/0084-ENGR00240650-pcie-imx-fix-ep-device-no-int-when-pcie.patch"
	${git} "${DIR}/patches/wandboard/0085-ENGR00240228-IPUv3-CSI-Correct-enum-definition-of-IP.patch"
	${git} "${DIR}/patches/wandboard/0086-ENGR00240972-1-IPU-Add-deinterlace-frame-rate-double.patch"
	${git} "${DIR}/patches/wandboard/0087-ENGR00240972-2-IPU-Add-vdic-double-frame-rate-featur.patch"
	${git} "${DIR}/patches/wandboard/0088-ENGR00240972-3-V4L2-VDI-double-frame-rate-for-interl.patch"
	${git} "${DIR}/patches/wandboard/0089-ENGR00240988-5-Update-gpu-code-to-support-3.5-kernel.patch"
	${git} "${DIR}/patches/wandboard/0090-ENGR00240988-10-Add-runtime-pm-function-call-in-gpu-.patch"
	${git} "${DIR}/patches/wandboard/0091-ENGR00240988-12-Enable-GPU-hardware-reset-for-3.5-ke.patch"
	${git} "${DIR}/patches/wandboard/0092-ENGR00241003-2-pfuze-using-_sel-interface-to-add-del.patch"
	${git} "${DIR}/patches/wandboard/0093-ENGR00241582-MX6-USB-host-USB-host-certification-pat.patch"
	${git} "${DIR}/patches/wandboard/0094-ENGR00241739-1-thermal-providing-the-thermal-hot-not.patch"
	${git} "${DIR}/patches/wandboard/0095-ENGR00241739-2-gpu-Enable-thermal-hot-notification-i.patch"
	${git} "${DIR}/patches/wandboard/0096-ENGR00242201-3-gpu-Makeup-GPU-driver-for-kernel-3.5..patch"
	${git} "${DIR}/patches/wandboard/0097-ENGR00242269-MX6-PCIE-Print-out-link-up-failure-log.patch"
	${git} "${DIR}/patches/wandboard/0098-ENGR00242214-IMX-PWM-Correct-duty-cycle-calculation.patch"
	${git} "${DIR}/patches/wandboard/0099-ENGR00242239-1-Camera-app-be-freezed-when-taking-5M-.patch"
	${git} "${DIR}/patches/wandboard/0100-ENGR00242239-2-Camera-app-be-freezed-when-taking-5M-.patch"
	${git} "${DIR}/patches/wandboard/0101-ENGR00242672-MX6-local-timer-Remove-enable_wait_mode.patch"
	${git} "${DIR}/patches/wandboard/0102-ENGR00242788-usb-host-disable-stream-mode-due-to-IC-.patch"
	${git} "${DIR}/patches/wandboard/0103-ENGR00242327-V4L2-output-Support-field-format-change.patch"
	${git} "${DIR}/patches/wandboard/0104-ENGR00243339-imx-sata-disable-sata-phy-when-sata-is-.patch"
	${git} "${DIR}/patches/wandboard/0105-ENGR00244769-1-NOR-FLASH-Improve-WEIM-NOR-speed.patch"
	${git} "${DIR}/patches/wandboard/0106-ENGR00243314-MX6-Sabreauto-Setup-ipu-di-parent-clock.patch"
	${git} "${DIR}/patches/wandboard/0107-ENGR00250756-4-V4L2-output-fix-coding-format-and-rev.patch"
	${git} "${DIR}/patches/wandboard/0108-ENGR00251008-GPU-4.6.9p11-integration-for-DRM.patch"
	${git} "${DIR}/patches/wandboard/0109-ENGR00251630-MX6DQ-do-not-power-off-ARM-in-suspend-o.patch"
	${git} "${DIR}/patches/wandboard/0110-ENGR00243077-Fixed-JB4.2-multi-user-switch-hang-issu.patch"
	${git} "${DIR}/patches/wandboard/0111-ENGR00251849-1-cpufreq-print-the-max-freq-directly-n.patch"
	${git} "${DIR}/patches/wandboard/0112-ENGR00251836-IPU-device-Support-local-alpha-with-alp.patch"
	${git} "${DIR}/patches/wandboard/0113-ENGR00251842-cpufreq-interactive-specify-duration-of.patch"
	${git} "${DIR}/patches/wandboard/0114-ENGR00252162-mxc_v4l2_capture-ov5640-some-formats-ha.patch"
	${git} "${DIR}/patches/wandboard/0115-ENGR00252071-1-mxc_v4l2_capture-auto-detection-paral.patch"
	${git} "${DIR}/patches/wandboard/0116-ENGR00252071-2-mxc_v4l2_capture-ov5640_mipi-update-p.patch"
	${git} "${DIR}/patches/wandboard/0117-ENGR00252071-3-mxc_v4l2_capture-enable-auto-detect-o.patch"
	${git} "${DIR}/patches/wandboard/0118-ENGR00252071-4-mxc_v4l2_capture-enable-auto-detect-o.patch"
	${git} "${DIR}/patches/wandboard/0119-timer-fix-the-too-many-reries-on-the-per-cpu-event-d.patch"
	${git} "${DIR}/patches/wandboard/0120-ENGR00252381-mxc_v4l2_capture-ov5640-incorrect-retur.patch"
	${git} "${DIR}/patches/wandboard/0121-ENGR00252418-imx6-add-fuse-check-for-available-devic.patch"
	${git} "${DIR}/patches/wandboard/0122-ENGR00237452-i.MX6-IEEE1588-disable-phy-Ar8031-Smart.patch"
	${git} "${DIR}/patches/wandboard/0123-ENGR00252411-mxc_v4l2_capture-ov5642-ov5640-cannot-b.patch"
	${git} "${DIR}/patches/wandboard/0124-ENGR00252559-mxc_v4l2_capture-ov5640-incorrect-warni.patch"
	${git} "${DIR}/patches/wandboard/0125-ENGR00252727-1-mxc-Add-fuse-check-for-gpu-platform-d.patch"
	${git} "${DIR}/patches/wandboard/0126-ENGR00252727-2-GPU-Power-on-VG-core-if-there-is-only.patch"
	${git} "${DIR}/patches/wandboard/0127-ENGR00251209-1-usb-add-host-1-vbus-callback.patch"
	${git} "${DIR}/patches/wandboard/0128-ENGR00251209-2-usb-otg-fix-the-dp-dm-will-be-floatin.patch"
	${git} "${DIR}/patches/wandboard/0129-ENGR00251209-3-usb-fix-below-build-warning.patch"
	${git} "${DIR}/patches/wandboard/0130-ENGR00251209-4-msl-mx6-usb-Fix-system-hang-when-unlo.patch"
	${git} "${DIR}/patches/wandboard/0131-ENGR00251209-5-usb-fix-the-system-hang-when-unload-g.patch"
	${git} "${DIR}/patches/wandboard/0132-ENGR00251209-6-msl-mx6-usb-keep-the-phy-lower-flag-a.patch"
	${git} "${DIR}/patches/wandboard/0133-ENGR00251209-7-usb-mark-phy-s-low-power-flag-as-fals.patch"
	${git} "${DIR}/patches/wandboard/0134-ENGR00251209-8-usb-fix-the-build-error-when-building.patch"
	${git} "${DIR}/patches/wandboard/0135-ENGR00251209-9-msl-usb-make-global-variable-as-drvda.patch"
	${git} "${DIR}/patches/wandboard/0136-ARM-7417-1-vfp-ensure-preemption-is-disabled-when-en.patch"
	${git} "${DIR}/patches/wandboard/0137-ENGR00252782-mxc-v4l2-capture-Support-csi-number-att.patch"
	${git} "${DIR}/patches/wandboard/0138-ENGR00252404-imx6-config-enable-ov5640-csi-sensor.patch"
	${git} "${DIR}/patches/wandboard/0139-ENGR00252418-1-Fix-iMX53-build-break-due-to-Fuse-com.patch"
	${git} "${DIR}/patches/wandboard/0140-ENGR00169384-imx6q-uart-config-and-enble-uart5.patch"
	${git} "${DIR}/patches/wandboard/0141-ENGR00253290-1-ASoC-wm8962-fix-over-gained-audio-pla.patch"
	${git} "${DIR}/patches/wandboard/0142-ENGR00234501-ASoC-spdif-fix-Ubuntu-reboot-hang-issue.patch"
	${git} "${DIR}/patches/wandboard/0143-ENGR00253835-CAAM-Fix-build-warnings-in-caamhash.c.patch"
	${git} "${DIR}/patches/wandboard/0144-ENGR00253849-EPDC-fix-build-warnings-in-epdc-fb-driv.patch"
	${git} "${DIR}/patches/wandboard/0145-ENGR00163527-Sabresd-BT-add-BT-support.patch"
	${git} "${DIR}/patches/wandboard/0146-ENGR00253947-EPDC-fix-reboot-failure.patch"
	${git} "${DIR}/patches/wandboard/0147-ENGR00253927-IPU-Fix-NULL-pointer-bug-when-BG-EOF-in.patch"
	${git} "${DIR}/patches/wandboard/0148-ENGR00243315-1-IPUv3-CSI-Correct-CCIR-code1-2-for-PA.patch"
	${git} "${DIR}/patches/wandboard/0149-ENGR00243315-2-IPUv3-CSI-Remove-test-mode-clock-sett.patch"
	${git} "${DIR}/patches/wandboard/0150-ENGR00243315-3-MXC-V4L2-Capture-Remove-unnecessary-m.patch"
	${git} "${DIR}/patches/wandboard/0151-ENGR00243315-4-MXC-V4L2-Capture-Improve-debug-info-f.patch"
	${git} "${DIR}/patches/wandboard/0152-ENGR00243315-5-ADV7180-Power-management-adjustment.patch"
	${git} "${DIR}/patches/wandboard/0153-ENGR00243315-6-ADV7180-Remove-unnecessary-header-fil.patch"
	${git} "${DIR}/patches/wandboard/0154-ENGR00254267-MX6DL-MX6SL-max-freq-Fix-max-cpu-freq-a.patch"
	${git} "${DIR}/patches/wandboard/0155-ENGR00254457-mx6dl-fix-mx6dl-TO1.1-can-t-enter-mem.patch"
	${git} "${DIR}/patches/wandboard/0156-ENGR00253355-ARM-imx6q-imx6dl-Set-proper-PAD-value-f.patch"
	${git} "${DIR}/patches/wandboard/0157-ENGR00254442-Sabre-ARD-Include-WEIM-NOR-on-imx6_upda.patch"
	${git} "${DIR}/patches/wandboard/0158-ENGR00232913-Hdmidongle-add-a-seperate-config-for-hd.patch"
	${git} "${DIR}/patches/wandboard/0159-ENGR00254931-IPUv3-Fb-Fix-display-twinkling-issue-du.patch"
	${git} "${DIR}/patches/wandboard/0160-ENGR00252064-1-csi-v4l-need-power-on-sensor-for-its-.patch"
	${git} "${DIR}/patches/wandboard/0161-ENGR00252064-2-mx6sl-ov5640-need-enable-MCLK-before-.patch"
	${git} "${DIR}/patches/wandboard/0162-ENGR00252064-3-camera-ov5640-fix-missed-setting-for-.patch"
	${git} "${DIR}/patches/wandboard/0163-ENGR00255029-ASoC-spdif-fix-clk_enable-disable-misma.patch"
	${git} "${DIR}/patches/wandboard/0164-ENGR00255482-ASoC-HDMI-audio-Add-error-message-for-H.patch"
	${git} "${DIR}/patches/wandboard/0165-ENGR00255484-1-msl-usb-add-NULL-poiner-check-for-fsl.patch"
	${git} "${DIR}/patches/wandboard/0166-ENGR00255484-2-usb-ehci-arc-add-NULL-pointer-check-f.patch"
	${git} "${DIR}/patches/wandboard/0167-ENGR00255484-3-msl-usb-add-clock-deinit-at-fail-path.patch"
	${git} "${DIR}/patches/wandboard/0168-ENGR00255491-ov5640-Fix-build-break-by-make-modules.patch"
	${git} "${DIR}/patches/wandboard/0169-ENGR00255481-mx6-Update-equation-for-thermal-sensor.patch"
	${git} "${DIR}/patches/wandboard/0170-ENGR00255111-battery-fix-voltage-decreased-only-whil.patch"
	${git} "${DIR}/patches/wandboard/0171-ENGR00255305-Sabreauto-refactor-sd-config.patch"
	${git} "${DIR}/patches/wandboard/0172-ENGR00255322-Disable-non-contiguous-memory-using-for.patch"
	${git} "${DIR}/patches/wandboard/0173-ENGR00253652-ov5640-dvp-Align-iq-setting-with-mipi-c.patch"
	${git} "${DIR}/patches/wandboard/0174-ENGR00255104-The-opening-time-of-cs42888-is-very-lon.patch"
	${git} "${DIR}/patches/wandboard/0175-ENGR00256629-V4L2-output-Fix-color-bar-issue-on-1080.patch"
	${git} "${DIR}/patches/wandboard/0176-ENGR00254106-Avoid-incorrect-GPU-frequency-scaling-b.patch"
	${git} "${DIR}/patches/wandboard/0177-ENGR00256820-1-ASoC-WM8962-revert-FLL-disable-before.patch"
	${git} "${DIR}/patches/wandboard/0178-ENGR00256820-2-ASoC-imx-wm8962-Fix-incorrect-setting.patch"
	${git} "${DIR}/patches/wandboard/0179-ENGR00256543-mx6-Update-equation-for-thermal-sensor-.patch"
	${git} "${DIR}/patches/wandboard/0180-ASoC-wm8962-Don-t-automatically-enable-and-disable-F.patch"
	${git} "${DIR}/patches/wandboard/0181-ENGR00256933-ASoC-WM8962-Add-delay-after-FLL-enable.patch"
	${git} "${DIR}/patches/wandboard/0182-ENGR00256315-2-Revert-ENGR00244769-1-NOR-FLASH-Impro.patch"
	${git} "${DIR}/patches/wandboard/0183-ENGR00256315-3-ARM-WEIM-NOR-set-the-proper-timing.patch"
	${git} "${DIR}/patches/wandboard/0184-ENGR00256315-4-ARM-imx6-weim-nor-set-proper-PAD-valu.patch"
	${git} "${DIR}/patches/wandboard/0185-ENGR00256315-5-mtd-cfi_cmdset_0002-print-adr-when-wr.patch"
	${git} "${DIR}/patches/wandboard/0186-ENGR00237365-board-mx6q_sabreauto-fix-mipi-csi2-sett.patch"
	${git} "${DIR}/patches/wandboard/0187-ENGR00255371-v4l2-fg-overlay-workaround-ipu-warning.patch"
	${git} "${DIR}/patches/wandboard/0188-ENGR00256918-IPUv3-common-Correct-CSI_PRP_MEM-disabl.patch"
	${git} "${DIR}/patches/wandboard/0189-ENGR00255518-ipu-ipu3-using-the-kernel-common-help-f.patch"
	${git} "${DIR}/patches/wandboard/0190-ENGR00257947-mtd-use-memcpy-to-replace-the-memcpy_fr.patch"
	${git} "${DIR}/patches/wandboard/0191-ENGR00257755-1-Revert-ASoC-wm8962-Don-t-automaticall.patch"
	${git} "${DIR}/patches/wandboard/0192-ENGR00257755-3-Revert-ENGR00256933-ASoC-WM8962-Add-d.patch"
	${git} "${DIR}/patches/wandboard/0193-ENGR00257755-4-ASoC-WM8962-Disable-FLL-when-chip-s-n.patch"
	${git} "${DIR}/patches/wandboard/0194-mtd-replace-DEBUG-with-pr_debug.patch"
	${git} "${DIR}/patches/wandboard/0195-mtd-cleanup-style-on-pr_debug-messages.patch"
	${git} "${DIR}/patches/wandboard/0196-mtd-cfi-AMD-Fujitsu-compatibles-add-panic-write-supp.patch"
	${git} "${DIR}/patches/wandboard/0197-mtd-chips-cfi_cmdset_0002-Match-ENABLE_VPP-DISABLE_V.patch"
	${git} "${DIR}/patches/wandboard/0198-mtd-add-fixup-for-S29NS512P-NOR-flash.patch"
	${git} "${DIR}/patches/wandboard/0199-mtd-cfi_cmdset_0002-Slight-cleanup-of-fixup-messages.patch"
	${git} "${DIR}/patches/wandboard/0200-mtd-cfi_cmdset_0002-Micron-M29EW-bugfixes-as-per-TN-.patch"
	${git} "${DIR}/patches/wandboard/0201-mtd-fix-recovery-after-failed-write-buffer-operation.patch"
	${git} "${DIR}/patches/wandboard/0202-ENGR00256417-MLB-can-t-receive-data-in-wait-mode.patch"
	${git} "${DIR}/patches/wandboard/0203-ENGR00258357-1-mlb-Remove-MLB150_-from-macro-define-.patch"
	${git} "${DIR}/patches/wandboard/0204-ENGR00258357-2-mlb-Add-more-debug-msgs-in-DEBUG-mode.patch"
	${git} "${DIR}/patches/wandboard/0205-ENGR00258357-3-mlb-Reset-whole-CDR-in-init-function.patch"
	${git} "${DIR}/patches/wandboard/0206-ENGR00258357-4-mlb-Group-static-variables-to-structu.patch"
	${git} "${DIR}/patches/wandboard/0207-ENGR00258357-5-mlb-Use-circle-buf-macros-to-replace-.patch"
	${git} "${DIR}/patches/wandboard/0208-ENGR00258733-WEIM-NOR-mtd-cfi_cmdset_0002-Do-not-rel.patch"
	${git} "${DIR}/patches/wandboard/0209-can-dev-let-can_get_echo_skb-return-dlc-of-CAN-frame.patch"
	${git} "${DIR}/patches/wandboard/0210-can-flexcan-Fix-CAN_RAW_RECV_OWN_MSGS-and-CAN_RAW_LO.patch"
	${git} "${DIR}/patches/wandboard/0211-ENGR00258885-flexcan-fix-errata-ERR005641-that-MB-ma.patch"
	${git} "${DIR}/patches/wandboard/0212-ENGR00259008-mlb-reduce-iram-usage-amount-in-async-m.patch"
	${git} "${DIR}/patches/wandboard/0213-Wandboard-Enable-zone-DMA-when-not-using-ION-i.e.-no.patch"
	${git} "${DIR}/patches/wandboard/0214-Add-support-for-AUO-97G070-LVDS-panel.patch"
	${git} "${DIR}/patches/wandboard/0215-Wandboard-Add-LVDS-suppport-to-Wandboard-Kconfig.patch"
	${git} "${DIR}/patches/wandboard/0216-Wandboard-Add-and-enable-LVDS-in-Wandboard-board-fil.patch"
	${git} "${DIR}/patches/wandboard/0217-Wandboard-Reorganize-pad-setup-macros-to-support-mul.patch"
	${git} "${DIR}/patches/wandboard/0218-Fix-signal-type-for-AUO-97G070-LVDS-panel.patch"
	${git} "${DIR}/patches/wandboard/0219-ENGR00233366-2-mx6q_sabresd-mx6sl_arm2-mx6sl_evk-con.patch"
	${git} "${DIR}/patches/wandboard/0220-ENGR00241003-1-mx6-need-to-add-delay-in-LDO-voltage-.patch"
	${git} "${DIR}/patches/wandboard/0221-ENGR00257847-1-MX6Q-DL-Fix-Ethernet-performance-issu.patch"
	${git} "${DIR}/patches/wandboard/0222-ENGR00257847-2-MX6Q-DL-Fix-Ethernet-performance-issu.patch"
	${git} "${DIR}/patches/wandboard/0223-Wandboard-Update-default-config.patch"
	${git} "${DIR}/patches/wandboard/0224-Set-iMX6DQ-DL-max-speed-back-to-1GHz.patch"
	${git} "${DIR}/patches/wandboard/0225-Wandboard-Add-SATA-support.patch"
	${git} "${DIR}/patches/wandboard/0226-ENGR00224245-HDMI-AUDIO-stop-start-PCM-while-unplug-.patch"
	${git} "${DIR}/patches/wandboard/0227-config-Enable-CGROUPS-by-default.patch"
	${git} "${DIR}/patches/wandboard/0228-config-Enable-Root-over-NFS-support.patch"
	${git} "${DIR}/patches/wandboard/0229-config-Enable-devtmpfs-as-it-is-required-for-new-ude.patch"
	${git} "${DIR}/patches/wandboard/0230-config-Disable-Seiko-LCD-support.patch"
	${git} "${DIR}/patches/wandboard/0231-gpu-viv-Avoid-possible-use-of-uninitialized-memory.patch"
}

deb_pkg () {
	echo "dir: deb_pkg"
	${git} "${DIR}/patches/deb_pkg/0001-kbuild-Fix-link-to-headers-in-make-deb-pkg.patch"
	${git} "${DIR}/patches/deb_pkg/0002-kbuild-Only-build-linux-image-package-for-UML.patch"
	${git} "${DIR}/patches/deb_pkg/0003-kbuild-Fix-out-of-tree-build-for-make-deb-pkg.patch"
	${git} "${DIR}/patches/deb_pkg/0004-builddeb-include-autogenerated-header-files.patch"
	${git} "${DIR}/patches/deb_pkg/0005-deb-pkg-Install-linux-firmware-image-in-versioned-di.patch"
	${git} "${DIR}/patches/deb_pkg/0006-deb-pkg-Add-all-Makefiles-to-header-package.patch"
	${git} "${DIR}/patches/deb_pkg/0007-deb-pkg-Simplify-architecture-matching-for-cross-bui.patch"
	${git} "${DIR}/patches/deb_pkg/0008-deb-disable-header_check-header_install.patch"
}

arm () {
	echo "dir: arm"
}

imx () {
	echo "dir: imx"
}

fixes () {
	echo "dir: fixes"
}

saucy () {
	echo "dir: saucy"
	${git} "${DIR}/patches/saucy/0001-saucy-disable-Werror-pointer-sign.patch"
	${git} "${DIR}/patches/saucy/0002-saucy-disable-stack-protector.patch"
}

imx_git
wandboard
deb_pkg
arm
imx
fixes
saucy

echo "patch.sh ran successful"
